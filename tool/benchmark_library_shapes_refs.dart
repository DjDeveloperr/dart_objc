import 'dart:io';

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.workDir,
    required this.keepWorkDir,
    required this.classCount,
    required this.chunkCount,
  });

  final Directory workDir;
  final bool keepWorkDir;
  final int classCount;
  final int chunkCount;
}

enum _Shape { monolith, exportsRoot, exportsDirect, partsRoot }

final class _ScenarioResult {
  const _ScenarioResult({
    required this.shape,
    required this.totalFiles,
    required this.generatedLines,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
  });

  final _Shape shape;
  final int totalFiles;
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
    for (final shape in _Shape.values) {
      final packageDir = Directory('${options.workDir.path}/${shape.name}');
      final totalLines = await _writeScenarioPackage(
        packageDir: packageDir,
        shape: shape,
        classCount: options.classCount,
        chunkCount: options.chunkCount,
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
      final totalFiles = packageDir
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .length;

      results.add(
        _ScenarioResult(
          shape: shape,
          totalFiles: totalFiles,
          generatedLines: totalLines,
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
  var classCount = 12000;
  var chunkCount = 120;

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
    if (arg == '--chunks') {
      chunkCount = int.parse(args[++i]);
      continue;
    }
    if (arg == '--help' || arg == '-h') {
      stdout.writeln('''
Usage: dart run tool/benchmark_library_shapes_refs.dart [options]

Options:
  --classes N   Number of synthetic classes to generate. Default: 12000
  --chunks N    Number of chunks for split layouts. Default: 120
  --keep-workdir
''');
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  return BenchmarkOptions(
    workDir: Directory('${Directory.systemTemp.path}/dart_library_shapes_refs'),
    keepWorkDir: keepWorkDir,
    classCount: classCount,
    chunkCount: chunkCount,
  );
}

Future<int> _writeScenarioPackage({
  required Directory packageDir,
  required _Shape shape,
  required int classCount,
  required int chunkCount,
}) async {
  packageDir.createSync(recursive: true);
  final libDir = Directory('${packageDir.path}/lib')
    ..createSync(recursive: true);
  final srcDir = Directory('${libDir.path}/src')..createSync(recursive: true);
  final chunkDir = Directory('${srcDir.path}/chunks')
    ..createSync(recursive: true);

  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: synthetic_refs_${shape.name}
publish_to: none

environment:
  sdk: ^3.11.0
''');

  final chunkAssignments = List.generate(chunkCount, (_) => <int>[]);
  for (var i = 0; i < classCount; i++) {
    chunkAssignments[i % chunkCount].add(i);
  }

  var totalLines = 0;

  switch (shape) {
    case _Shape.monolith:
      final body = StringBuffer();
      for (var i = 0; i < classCount; i++) {
        body.writeln(_classSource(i, classCount));
      }
      final content =
          '''
library big_api;

${body.toString()}
''';
      File('${libDir.path}/big_api.dart').writeAsStringSync(content);
      totalLines += '\n'.allMatches(content).length + 1;
    case _Shape.exportsRoot || _Shape.exportsDirect:
      for (
        var chunkIndex = 0;
        chunkIndex < chunkAssignments.length;
        chunkIndex++
      ) {
        final imports = <String>{};
        final previousChunk =
            (chunkIndex - 1 + chunkAssignments.length) %
            chunkAssignments.length;
        final nextChunk = (chunkIndex + 1) % chunkAssignments.length;
        imports.add("import 'chunk_$previousChunk.dart';");
        imports.add("import 'chunk_$nextChunk.dart';");

        final body = StringBuffer();
        for (final classIndex in chunkAssignments[chunkIndex]) {
          body.writeln(_classSource(classIndex, classCount));
        }
        final content =
            '''
library big_api_chunk_$chunkIndex;

${imports.join('\n')}

${body.toString()}
''';
        File(
          '${chunkDir.path}/chunk_$chunkIndex.dart',
        ).writeAsStringSync(content);
        totalLines += '\n'.allMatches(content).length + 1;
      }

      if (shape == _Shape.exportsRoot) {
        final root = StringBuffer();
        for (var i = 0; i < chunkAssignments.length; i++) {
          root.writeln("export 'src/chunks/chunk_$i.dart';");
        }
        final rootContent = root.toString();
        File('${libDir.path}/big_api.dart').writeAsStringSync(rootContent);
        totalLines += '\n'.allMatches(rootContent).length + 1;
      } else {
        const rootContent = "export 'src/chunks/chunk_0.dart';\n";
        File('${libDir.path}/big_api.dart').writeAsStringSync(rootContent);
        totalLines += '\n'.allMatches(rootContent).length + 1;
      }
    case _Shape.partsRoot:
      final root = StringBuffer()..writeln('library big_api;');
      for (
        var chunkIndex = 0;
        chunkIndex < chunkAssignments.length;
        chunkIndex++
      ) {
        root.writeln("part 'src/chunks/chunk_$chunkIndex.dart';");
        final body = StringBuffer();
        for (final classIndex in chunkAssignments[chunkIndex]) {
          body.writeln(_classSource(classIndex, classCount));
        }
        final content =
            '''
part of big_api;

${body.toString()}
''';
        File(
          '${chunkDir.path}/chunk_$chunkIndex.dart',
        ).writeAsStringSync(content);
        totalLines += '\n'.allMatches(content).length + 1;
      }
      final rootContent = root.toString();
      File('${libDir.path}/big_api.dart').writeAsStringSync(rootContent);
      totalLines += '\n'.allMatches(rootContent).length + 1;
  }

  return totalLines;
}

String _classSource(int index, int classCount) {
  final previous = (index - 1 + classCount) % classCount;
  final next = (index + 1) % classCount;
  return '''
class ApiType$index {
  const ApiType$index(this.previous, this.next);

  final ApiType$previous? previous;
  final ApiType$next? next;

  ApiType$previous? rewind() => previous;
  ApiType$next? advance() => next;
}
''';
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

  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: app_${shape.name}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  synthetic_refs_${shape.name}:
    path: ${packageDir.path}
''');

  final import = switch (shape) {
    _Shape.exportsDirect =>
      "import 'package:synthetic_refs_${shape.name}/src/chunks/chunk_0.dart';",
    _ => "import 'package:synthetic_refs_${shape.name}/big_api.dart';",
  };

  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
$import

void main() {
  const value = ApiType0(null, null);
  print(value.advance());
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
  stdout.writeln('shape           files  gen_lines  analyze_ms  analyze_rss');
  for (final result in results) {
    stdout.writeln(
      '${result.shape.name.padRight(15)} '
      '${result.totalFiles.toString().padLeft(5)} '
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
