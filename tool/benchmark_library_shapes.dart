import 'dart:io';

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.repoRoot,
    required this.workDir,
    required this.keepWorkDir,
    required this.classCount,
    required this.chunkCount,
  });

  final Directory repoRoot;
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
        repoRoot: options.repoRoot,
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
  final repoRoot = Directory.current.absolute;
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
Usage: dart run tool/benchmark_library_shapes.dart [options]

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
    repoRoot: repoRoot,
    workDir: Directory('${Directory.systemTemp.path}/dart_library_shapes'),
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
name: synthetic_${shape.name}
publish_to: none

environment:
  sdk: ^3.11.0
''');

  final chunks = _buildChunks(classCount: classCount, chunkCount: chunkCount);
  var totalLines = 0;

  switch (shape) {
    case _Shape.monolith:
      final content = _libraryHeader(
        libraryName: 'big_api',
        body: chunks.expand((chunk) => chunk.lines).join('\n'),
      );
      File('${libDir.path}/big_api.dart').writeAsStringSync(content);
      totalLines += '\n'.allMatches(content).length + 1;
    case _Shape.exportsRoot:
      final buffer = StringBuffer();
      for (var i = 0; i < chunks.length; i++) {
        final fileName = 'chunk_$i.dart';
        final content = _libraryHeader(
          libraryName: 'big_api_chunk_$i',
          body: chunks[i].lines.join('\n'),
        );
        File('${chunkDir.path}/$fileName').writeAsStringSync(content);
        totalLines += '\n'.allMatches(content).length + 1;
        buffer.writeln("export 'src/chunks/$fileName';");
      }
      final root = buffer.toString();
      File('${libDir.path}/big_api.dart').writeAsStringSync(root);
      totalLines += '\n'.allMatches(root).length + 1;
    case _Shape.exportsDirect:
      final buffer = StringBuffer();
      for (var i = 0; i < chunks.length; i++) {
        final fileName = 'chunk_$i.dart';
        final content = _libraryHeader(
          libraryName: 'big_api_chunk_$i',
          body: chunks[i].lines.join('\n'),
        );
        File('${chunkDir.path}/$fileName').writeAsStringSync(content);
        totalLines += '\n'.allMatches(content).length + 1;
      }
      buffer.writeln("export 'src/chunks/chunk_0.dart';");
      File('${libDir.path}/big_api.dart').writeAsStringSync(buffer.toString());
      totalLines += '\n'.allMatches(buffer.toString()).length + 1;
    case _Shape.partsRoot:
      final buffer = StringBuffer()..writeln('library big_api;');
      for (var i = 0; i < chunks.length; i++) {
        final fileName = 'chunk_$i.dart';
        buffer.writeln("part 'src/chunks/$fileName';");
        final content = _partBody(chunks[i].lines.join('\n'));
        File('${chunkDir.path}/$fileName').writeAsStringSync(content);
        totalLines += '\n'.allMatches(content).length + 1;
      }
      final root = buffer.toString();
      File('${libDir.path}/big_api.dart').writeAsStringSync(root);
      totalLines += '\n'.allMatches(root).length + 1;
  }

  return totalLines;
}

List<_Chunk> _buildChunks({required int classCount, required int chunkCount}) {
  final chunks = List.generate(chunkCount, (_) => <String>[]);
  for (var i = 0; i < classCount; i++) {
    final chunk = chunks[i % chunkCount];
    chunk.add(_classSource(i));
  }
  return chunks.map((lines) => _Chunk(lines)).toList(growable: false);
}

String _classSource(int index) {
  return '''
class ApiType$index {
  const ApiType$index(this.value);

  final int value;

  int get doubled => value * 2;

  String describe() => 'ApiType$index(\$value)';
}
''';
}

String _libraryHeader({required String libraryName, required String body}) {
  return '''
library $libraryName;

$body
''';
}

String _partBody(String body) {
  return '''
part of big_api;

$body
''';
}

Future<Directory> _writeHarness({
  required Directory repoRoot,
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
  synthetic_${shape.name}:
    path: ${packageDir.path}
''');

  final import = switch (shape) {
    _Shape.exportsDirect =>
      "import 'package:synthetic_${shape.name}/src/chunks/chunk_0.dart';",
    _ => "import 'package:synthetic_${shape.name}/big_api.dart';",
  };

  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
$import

void main() {
  const value = ApiType0(1);
  print(value.describe());
}
''');

  await _runChecked(
    workingDirectory: appDir.path,
    arguments: const ['pub', 'get'],
  );
  return appDir;
}

final class _Chunk {
  const _Chunk(this.lines);

  final List<String> lines;
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
