import 'dart:io';

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.workDir,
    required this.keepWorkDir,
    required this.classCount,
    required this.methodsPerClass,
  });

  final Directory workDir;
  final bool keepWorkDir;
  final int classCount;
  final int methodsPerClass;
}

enum _Density { stub, heavy }

final class _ScenarioResult {
  const _ScenarioResult({
    required this.density,
    required this.generatedLines,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
  });

  final _Density density;
  final int generatedLines;
  final int analyzeMs;
  final int analyzeMaxRssBytes;
}

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  if (options.workDir.existsSync()) {
    options.workDir.deleteSync(recursive: true);
  }
  options.workDir.createSync(recursive: true);

  try {
    final results = <_ScenarioResult>[];
    for (final density in _Density.values) {
      final packageDir = Directory('${options.workDir.path}/${density.name}');
      final generatedLines = await _writeScenarioPackage(
        packageDir: packageDir,
        density: density,
        classCount: options.classCount,
        methodsPerClass: options.methodsPerClass,
      );
      final appDir = await _writeHarness(
        workDir: options.workDir,
        packageDir: packageDir,
        density: density,
      );
      final analyze = await _timeDartCommand(
        workingDirectory: appDir.path,
        arguments: const ['analyze', 'bin/main.dart'],
      );
      results.add(
        _ScenarioResult(
          density: density,
          generatedLines: generatedLines,
          analyzeMs: analyze.elapsedMs,
          analyzeMaxRssBytes: analyze.maxRssBytes,
        ),
      );
    }

    _printResults(results);
  } finally {
    if (!options.keepWorkDir && options.workDir.existsSync()) {
      options.workDir.deleteSync(recursive: true);
    }
  }
}

BenchmarkOptions _parseArgs(List<String> args) {
  var keepWorkDir = false;
  var classCount = 3000;
  var methodsPerClass = 6;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--keep-workdir') {
      keepWorkDir = true;
      continue;
    }
    if (arg == '--classes') {
      classCount = int.parse(args[++i]);
      continue;
    }
    if (arg == '--methods') {
      methodsPerClass = int.parse(args[++i]);
      continue;
    }
    if (arg == '--help' || arg == '-h') {
      stdout.writeln('''
Usage: dart run tool/benchmark_api_density.dart [options]

Options:
  --classes N   Number of synthetic classes. Default: 3000
  --methods N   Methods per class. Default: 6
  --keep-workdir
''');
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  return BenchmarkOptions(
    workDir: Directory('${Directory.systemTemp.path}/dart_api_density'),
    keepWorkDir: keepWorkDir,
    classCount: classCount,
    methodsPerClass: methodsPerClass,
  );
}

Future<int> _writeScenarioPackage({
  required Directory packageDir,
  required _Density density,
  required int classCount,
  required int methodsPerClass,
}) async {
  packageDir.createSync(recursive: true);
  final libDir = Directory('${packageDir.path}/lib')
    ..createSync(recursive: true);

  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: density_${density.name}
publish_to: none

environment:
  sdk: ^3.11.0
''');

  final buffer = StringBuffer()..writeln('library big_api;');
  if (density == _Density.heavy) {
    for (var classIndex = 0; classIndex < classCount; classIndex++) {
      for (var methodIndex = 0; methodIndex < methodsPerClass; methodIndex++) {
        buffer
          ..writeln(
            "const _sel_ApiType${classIndex}_method$methodIndex = 'ApiType$classIndex.method$methodIndex';",
          )
          ..writeln(
            'int _dispatch_ApiType${classIndex}_method$methodIndex(int value) => value + $methodIndex;',
          );
      }
    }
  }

  for (var classIndex = 0; classIndex < classCount; classIndex++) {
    buffer.writeln('class ApiType$classIndex {');
    buffer.writeln('  const ApiType$classIndex(this.value);');
    buffer.writeln('  final int value;');
    for (var methodIndex = 0; methodIndex < methodsPerClass; methodIndex++) {
      if (density == _Density.stub) {
        buffer.writeln('  int method$methodIndex() => value + $methodIndex;');
      } else {
        buffer.writeln('  int method$methodIndex() {');
        buffer.writeln(
          '    final selector = _sel_ApiType${classIndex}_method$methodIndex;',
        );
        buffer.writeln('    if (selector.isEmpty) {');
        buffer.writeln(
          "      throw StateError('Failed to load method signature for ApiType$classIndex.method$methodIndex');",
        );
        buffer.writeln('    }');
        buffer.writeln(
          '    return _dispatch_ApiType${classIndex}_method$methodIndex(value);',
        );
        buffer.writeln('  }');
      }
    }
    buffer.writeln('}');
  }

  final content = '${buffer.toString()}\n';
  File('${libDir.path}/big_api.dart').writeAsStringSync(content);
  return '\n'.allMatches(content).length + 1;
}

Future<Directory> _writeHarness({
  required Directory workDir,
  required Directory packageDir,
  required _Density density,
}) async {
  final appDir = Directory('${workDir.path}/app_${density.name}');
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
  Directory('${appDir.path}/bin').createSync(recursive: true);

  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: app_${density.name}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  density_${density.name}:
    path: ${packageDir.path}
''');

  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
import 'package:density_${density.name}/big_api.dart';

void main() {
  const value = ApiType0(1);
  print(value.method0());
}
''');

  await _runChecked(
    workingDirectory: appDir.path,
    arguments: const ['pub', 'get'],
  );
  return appDir;
}

final class _TimedRunResult {
  const _TimedRunResult({required this.elapsedMs, required this.maxRssBytes});

  final int elapsedMs;
  final int maxRssBytes;
}

Future<_TimedRunResult> _timeDartCommand({
  required String workingDirectory,
  required List<String> arguments,
}) async {
  final result = await Process.run('/usr/bin/time', [
    '-l',
    'dart',
    ...arguments,
  ], workingDirectory: workingDirectory);
  if (result.exitCode != 0) {
    throw ProcessException(
      'dart',
      arguments,
      '${result.stdout}${result.stderr}',
      result.exitCode,
    );
  }

  final timingOutput = result.stderr as String;
  final realMatch = RegExp(
    r'^\s*([0-9]+(?:\.[0-9]+)?) real',
    multiLine: true,
  ).firstMatch(timingOutput);
  final rssMatch = RegExp(
    r'^\s*(\d+)\s+maximum resident set size',
    multiLine: true,
  ).firstMatch(timingOutput);
  if (realMatch == null || rssMatch == null) {
    throw StateError('Unable to parse timing output:\n$timingOutput');
  }

  return _TimedRunResult(
    elapsedMs: (double.parse(realMatch.group(1)!) * 1000).round(),
    maxRssBytes: int.parse(rssMatch.group(1)!),
  );
}

Future<void> _runChecked({
  required String workingDirectory,
  required List<String> arguments,
}) async {
  final result = await Process.run(
    'dart',
    arguments,
    workingDirectory: workingDirectory,
  );
  if (result.exitCode != 0) {
    throw ProcessException(
      'dart',
      arguments,
      '${result.stdout}${result.stderr}',
      result.exitCode,
    );
  }
}

void _printResults(List<_ScenarioResult> results) {
  stdout.writeln('');
  stdout.writeln('density  gen_lines  analyze_ms  analyze_rss');
  for (final result in results) {
    stdout.writeln(
      '${result.density.name.padRight(7)} '
      '${result.generatedLines.toString().padLeft(10)} '
      '${result.analyzeMs.toString().padLeft(10)} '
      '${_formatBytes(result.analyzeMaxRssBytes).padLeft(12)}',
    );
  }
}

String _formatBytes(num bytes) {
  const units = ['B', 'KiB', 'MiB', 'GiB'];
  var value = bytes.toDouble();
  var unitIndex = 0;
  while (value >= 1024 && unitIndex < units.length - 1) {
    value /= 1024;
    unitIndex++;
  }
  final formatted = unitIndex == 0
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
  return '$formatted ${units[unitIndex]}';
}
