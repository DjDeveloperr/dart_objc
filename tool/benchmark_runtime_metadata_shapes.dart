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

enum _Shape { heavyInline, thinInline, thinTable, thinExternal }

final class _ScenarioResult {
  const _ScenarioResult({
    required this.shape,
    required this.generatedLines,
    required this.generatedBytes,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
    required this.kernelMs,
    required this.kernelMaxRssBytes,
  });

  final _Shape shape;
  final int generatedLines;
  final int generatedBytes;
  final int analyzeMs;
  final int analyzeMaxRssBytes;
  final int kernelMs;
  final int kernelMaxRssBytes;
}

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  if (options.workDir.existsSync()) {
    options.workDir.deleteSync(recursive: true);
  }
  options.workDir.createSync(recursive: true);

  try {
    final results = <_ScenarioResult>[];
    for (final shape in _Shape.values) {
      final packageDir = Directory('${options.workDir.path}/${shape.name}');
      final generatedContent = await _writeScenarioPackage(
        packageDir: packageDir,
        shape: shape,
        classCount: options.classCount,
        methodsPerClass: options.methodsPerClass,
      );
      final appDir = await _writeHarness(
        workDir: options.workDir,
        packageDir: packageDir,
        shape: shape,
      );
      final analyze = await _timeDartCommand(
        workingDirectory: appDir.path,
        arguments: const ['analyze', 'bin/main.dart'],
      );
      final kernel = await _timeDartCommand(
        workingDirectory: appDir.path,
        arguments: const [
          'compile',
          'kernel',
          'bin/main.dart',
          '-o',
          'build/app.dill',
        ],
      );
      results.add(
        _ScenarioResult(
          shape: shape,
          generatedLines: '\n'.allMatches(generatedContent).length + 1,
          generatedBytes: generatedContent.length,
          analyzeMs: analyze.elapsedMs,
          analyzeMaxRssBytes: analyze.maxRssBytes,
          kernelMs: kernel.elapsedMs,
          kernelMaxRssBytes: kernel.maxRssBytes,
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
  var classCount = 2000;
  var methodsPerClass = 8;

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
Usage: dart run tool/benchmark_runtime_metadata_shapes.dart [options]

Options:
  --classes N   Number of synthetic classes. Default: 2000
  --methods N   Methods per class. Default: 8
  --keep-workdir
''');
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  return BenchmarkOptions(
    workDir: Directory(
      '${Directory.systemTemp.path}/dart_runtime_metadata_shapes',
    ),
    keepWorkDir: keepWorkDir,
    classCount: classCount,
    methodsPerClass: methodsPerClass,
  );
}

Future<String> _writeScenarioPackage({
  required Directory packageDir,
  required _Shape shape,
  required int classCount,
  required int methodsPerClass,
}) async {
  packageDir.createSync(recursive: true);
  final libDir = Directory('${packageDir.path}/lib')
    ..createSync(recursive: true);

  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: runtime_shape_${shape.name}
publish_to: none

environment:
  sdk: ^3.11.0
''');

  final buffer = StringBuffer()..writeln('library runtime_shape;');
  buffer
    ..writeln(
      'int _runtimeInvoke(Object receiver, String selector, int value) => value + selector.length + receiver.hashCode;',
    )
    ..writeln(
      'int _runtimeInvokeByIndex(Object receiver, int selectorIndex, int value) => value + selectorIndex + receiver.hashCode;',
    );

  if (shape == _Shape.heavyInline || shape == _Shape.thinInline) {
    for (var classIndex = 0; classIndex < classCount; classIndex++) {
      for (var methodIndex = 0; methodIndex < methodsPerClass; methodIndex++) {
        buffer.writeln(
          "const _sel_ApiType${classIndex}_method$methodIndex = 'ApiType$classIndex.method$methodIndex';",
        );
        if (shape == _Shape.heavyInline) {
          buffer.writeln(
            'int _dispatch_ApiType${classIndex}_method$methodIndex(Object receiver, int value) {',
          );
          buffer.writeln(
            '  final selector = _sel_ApiType${classIndex}_method$methodIndex;',
          );
          buffer.writeln('  final selectorLength = selector.length;');
          buffer.writeln('  if (selectorLength == 0) {');
          buffer.writeln(
            "    throw StateError('Missing metadata for ApiType$classIndex.method$methodIndex');",
          );
          buffer.writeln('  }');
          buffer.writeln('  final adjusted = value + $methodIndex;');
          buffer.writeln(
            '  return _runtimeInvoke(receiver, selector, adjusted) + selectorLength;',
          );
          buffer.writeln('}');
        }
      }
    }
  }

  if (shape == _Shape.thinTable) {
    buffer.writeln('const _selectors = <String>[');
    for (var classIndex = 0; classIndex < classCount; classIndex++) {
      for (var methodIndex = 0; methodIndex < methodsPerClass; methodIndex++) {
        buffer.writeln("  'ApiType$classIndex.method$methodIndex',");
      }
    }
    buffer.writeln('];');
  }

  for (var classIndex = 0; classIndex < classCount; classIndex++) {
    final selectorBase = classIndex * methodsPerClass;
    buffer.writeln('class ApiType$classIndex {');
    buffer.writeln('  const ApiType$classIndex(this.value);');
    buffer.writeln('  final int value;');
    for (var methodIndex = 0; methodIndex < methodsPerClass; methodIndex++) {
      switch (shape) {
        case _Shape.heavyInline:
          buffer.writeln(
            '  int method$methodIndex() => _dispatch_ApiType${classIndex}_method$methodIndex(this, value);',
          );
        case _Shape.thinInline:
          buffer.writeln(
            '  int method$methodIndex() => _runtimeInvoke(this, _sel_ApiType${classIndex}_method$methodIndex, value + $methodIndex);',
          );
        case _Shape.thinTable:
          buffer.writeln(
            '  int method$methodIndex() => _runtimeInvoke(this, _selectors[${selectorBase + methodIndex}], value + $methodIndex);',
          );
        case _Shape.thinExternal:
          buffer.writeln(
            '  int method$methodIndex() => _runtimeInvokeByIndex(this, ${selectorBase + methodIndex}, value + $methodIndex);',
          );
      }
    }
    buffer.writeln('}');
  }

  final content = '${buffer.toString()}\n';
  File('${libDir.path}/runtime_shape.dart').writeAsStringSync(content);
  return content;
}

Future<Directory> _writeHarness({
  required Directory workDir,
  required Directory packageDir,
  required _Shape shape,
}) async {
  final appDir = Directory('${workDir.path}/app_${shape.name}');
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
  Directory('${appDir.path}/bin').createSync(recursive: true);
  Directory('${appDir.path}/build').createSync(recursive: true);

  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: app_${shape.name}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  runtime_shape_${shape.name}:
    path: ${packageDir.path}
''');

  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
import 'package:runtime_shape_${shape.name}/runtime_shape.dart';

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
  for (final result in results) {
    stdout.writeln(
      '${result.shape.name}: '
      '${_mib(result.generatedBytes)} MiB, ${result.generatedLines} lines, '
      'analyze ${result.analyzeMs} ms / ${_mib(result.analyzeMaxRssBytes)} MiB, '
      'kernel ${result.kernelMs} ms / ${_mib(result.kernelMaxRssBytes)} MiB',
    );
  }
}

String _mib(int bytes) => (bytes / (1024 * 1024)).toStringAsFixed(1);
