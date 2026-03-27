import 'dart:io';

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.workDir,
    required this.keepWorkDir,
    required this.familyCount,
    required this.methodsPerFamily,
    required this.groupCount,
  });

  final Directory workDir;
  final bool keepWorkDir;
  final int familyCount;
  final int methodsPerFamily;
  final int groupCount;
}

enum _Shape {
  inlineMembers,
  sameLibraryExtensions,
  splitExtensionsRoot,
  splitExtensionsDirect,
}

final class _ScenarioResult {
  const _ScenarioResult({
    required this.shape,
    required this.fileCount,
    required this.generatedLines,
    required this.generatedBytes,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
    required this.kernelMs,
    required this.kernelMaxRssBytes,
  });

  final _Shape shape;
  final int fileCount;
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
      final generated = await _writeScenarioPackage(
        packageDir: packageDir,
        shape: shape,
        familyCount: options.familyCount,
        methodsPerFamily: options.methodsPerFamily,
        groupCount: options.groupCount,
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
          fileCount: generated.fileCount,
          generatedLines: generated.lines,
          generatedBytes: generated.bytes,
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
  var familyCount = 1500;
  var methodsPerFamily = 24;
  var groupCount = 6;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--keep-workdir') {
      keepWorkDir = true;
      continue;
    }
    if (arg == '--families') {
      familyCount = int.parse(args[++i]);
      continue;
    }
    if (arg == '--methods') {
      methodsPerFamily = int.parse(args[++i]);
      continue;
    }
    if (arg == '--groups') {
      groupCount = int.parse(args[++i]);
      continue;
    }
    if (arg == '--help' || arg == '-h') {
      stdout.writeln('''
Usage: dart run tool/benchmark_member_topology.dart [options]

Options:
  --families N   Number of synthetic API families. Default: 1500
  --methods N    Methods per family. Default: 24
  --groups N     Method groups for extension layouts. Default: 6
  --keep-workdir
''');
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  return BenchmarkOptions(
    workDir: Directory('${Directory.systemTemp.path}/dart_member_topology'),
    keepWorkDir: keepWorkDir,
    familyCount: familyCount,
    methodsPerFamily: methodsPerFamily,
    groupCount: groupCount,
  );
}

final class _GeneratedPackage {
  const _GeneratedPackage({
    required this.fileCount,
    required this.lines,
    required this.bytes,
  });

  final int fileCount;
  final int lines;
  final int bytes;
}

Future<_GeneratedPackage> _writeScenarioPackage({
  required Directory packageDir,
  required _Shape shape,
  required int familyCount,
  required int methodsPerFamily,
  required int groupCount,
}) async {
  packageDir.createSync(recursive: true);
  final libDir = Directory('${packageDir.path}/lib')
    ..createSync(recursive: true);
  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: member_topology_${shape.name}
publish_to: none

environment:
  sdk: ^3.11.0
''');

  switch (shape) {
    case _Shape.inlineMembers:
      final source = _inlineMembersSource(
        familyCount: familyCount,
        methodsPerFamily: methodsPerFamily,
      );
      File('${libDir.path}/family_api.dart').writeAsStringSync(source);
      return _GeneratedPackage(
        fileCount: 1,
        lines: _countLines(source),
        bytes: source.length,
      );
    case _Shape.sameLibraryExtensions:
      final source = _sameLibraryExtensionsSource(
        familyCount: familyCount,
        methodsPerFamily: methodsPerFamily,
        groupCount: groupCount,
      );
      File('${libDir.path}/family_api.dart').writeAsStringSync(source);
      return _GeneratedPackage(
        fileCount: 1,
        lines: _countLines(source),
        bytes: source.length,
      );
    case _Shape.splitExtensionsRoot:
    case _Shape.splitExtensionsDirect:
      return _writeSplitExtensionsPackage(
        libDir: libDir,
        familyCount: familyCount,
        methodsPerFamily: methodsPerFamily,
        groupCount: groupCount,
      );
  }
}

String _inlineMembersSource({
  required int familyCount,
  required int methodsPerFamily,
}) {
  final buffer = StringBuffer()
    ..writeln('int _dispatch(int rawValue, int methodOffset) =>')
    ..writeln('    rawValue + methodOffset;')
    ..writeln();

  for (var familyIndex = 0; familyIndex < familyCount; familyIndex++) {
    buffer
      ..writeln('extension type ApiFamily$familyIndex._(int rawValue) {')
      ..writeln('  ApiFamily$familyIndex(int rawValue) : this._(rawValue);');
    for (var methodIndex = 0; methodIndex < methodsPerFamily; methodIndex++) {
      final offset = familyIndex * methodsPerFamily + methodIndex;
      buffer
        ..writeln('  int method$methodIndex() {')
        ..writeln(
          "    final selector = 'ApiFamily$familyIndex.method$methodIndex';",
        )
        ..writeln('    if (selector.isEmpty) {')
        ..writeln(
          "      throw StateError('missing selector for ApiFamily$familyIndex.method$methodIndex');",
        )
        ..writeln('    }')
        ..writeln('    return _dispatch(rawValue, $offset);')
        ..writeln('  }');
    }
    buffer.writeln('}');
    buffer.writeln();
  }

  return '${buffer.toString()}\n';
}

String _sameLibraryExtensionsSource({
  required int familyCount,
  required int methodsPerFamily,
  required int groupCount,
}) {
  final buffer = StringBuffer()
    ..writeln('int _dispatch(int rawValue, int methodOffset) =>')
    ..writeln('    rawValue + methodOffset;')
    ..writeln();

  for (var familyIndex = 0; familyIndex < familyCount; familyIndex++) {
    buffer
      ..writeln('extension type ApiFamily$familyIndex._(int rawValue) {')
      ..writeln('  ApiFamily$familyIndex(int rawValue) : this._(rawValue);')
      ..writeln('}')
      ..writeln();
  }

  for (var groupIndex = 0; groupIndex < groupCount; groupIndex++) {
    for (var familyIndex = 0; familyIndex < familyCount; familyIndex++) {
      buffer.writeln(
        'extension ApiFamily$familyIndex\$Group$groupIndex on ApiFamily$familyIndex {',
      );
      for (final methodIndex in _methodIndexesForGroup(
        methodsPerFamily: methodsPerFamily,
        groupCount: groupCount,
        groupIndex: groupIndex,
      )) {
        final offset = familyIndex * methodsPerFamily + methodIndex;
        buffer
          ..writeln('  int method$methodIndex() {')
          ..writeln(
            "    final selector = 'ApiFamily$familyIndex.method$methodIndex';",
          )
          ..writeln('    if (selector.isEmpty) {')
          ..writeln(
            "      throw StateError('missing selector for ApiFamily$familyIndex.method$methodIndex');",
          )
          ..writeln('    }')
          ..writeln('    return _dispatch(rawValue, $offset);')
          ..writeln('  }');
      }
      buffer.writeln('}');
      buffer.writeln();
    }
  }

  return '${buffer.toString()}\n';
}

Future<_GeneratedPackage> _writeSplitExtensionsPackage({
  required Directory libDir,
  required int familyCount,
  required int methodsPerFamily,
  required int groupCount,
}) async {
  final srcDir = Directory('${libDir.path}/src')..createSync(recursive: true);
  Directory('${srcDir.path}/groups').createSync();
  Directory('${libDir.path}/groups').createSync();
  final rootSource = _splitRootSource(groupCount);
  final coreSource = _splitCoreSource(familyCount: familyCount);

  var fileCount = 0;
  var lines = 0;
  var bytes = 0;

  void record(String relativePath, String content) {
    File('${libDir.path}/$relativePath').writeAsStringSync(content);
    fileCount++;
    lines += _countLines(content);
    bytes += content.length;
  }

  record('family_api.dart', rootSource);
  record('src/core.dart', coreSource);

  for (var groupIndex = 0; groupIndex < groupCount; groupIndex++) {
    final groupSource = _splitGroupSource(
      familyCount: familyCount,
      methodsPerFamily: methodsPerFamily,
      groupCount: groupCount,
      groupIndex: groupIndex,
    );
    final publicGroupSource = '''
export '../src/core.dart';
export '../src/groups/group_$groupIndex.dart';
''';
    record('src/groups/group_$groupIndex.dart', groupSource);
    record('groups/group_$groupIndex.dart', publicGroupSource);
  }

  return _GeneratedPackage(
    fileCount: fileCount,
    lines: lines,
    bytes: bytes,
  );
}

String _splitRootSource(int groupCount) {
  final buffer = StringBuffer()..writeln("export 'src/core.dart';");
  for (var groupIndex = 0; groupIndex < groupCount; groupIndex++) {
    buffer.writeln("export 'groups/group_$groupIndex.dart';");
  }
  return '${buffer.toString()}\n';
}

String _splitCoreSource({required int familyCount}) {
  final buffer = StringBuffer();
  for (var familyIndex = 0; familyIndex < familyCount; familyIndex++) {
    buffer
      ..writeln('extension type ApiFamily$familyIndex._(int rawValue) {')
      ..writeln('  ApiFamily$familyIndex(int rawValue) : this._(rawValue);')
      ..writeln('}')
      ..writeln();
  }
  return '${buffer.toString()}\n';
}

String _splitGroupSource({
  required int familyCount,
  required int methodsPerFamily,
  required int groupCount,
  required int groupIndex,
}) {
  final buffer = StringBuffer()
    ..writeln("import '../core.dart';")
    ..writeln()
    ..writeln('int _dispatch(int rawValue, int methodOffset) =>')
    ..writeln('    rawValue + methodOffset;')
    ..writeln();

  for (var familyIndex = 0; familyIndex < familyCount; familyIndex++) {
    buffer.writeln(
      'extension ApiFamily$familyIndex\$Group$groupIndex on ApiFamily$familyIndex {',
    );
    for (final methodIndex in _methodIndexesForGroup(
      methodsPerFamily: methodsPerFamily,
      groupCount: groupCount,
      groupIndex: groupIndex,
    )) {
      final offset = familyIndex * methodsPerFamily + methodIndex;
      buffer
        ..writeln('  int method$methodIndex() {')
        ..writeln(
          "    final selector = 'ApiFamily$familyIndex.method$methodIndex';",
        )
        ..writeln('    if (selector.isEmpty) {')
        ..writeln(
          "      throw StateError('missing selector for ApiFamily$familyIndex.method$methodIndex');",
        )
        ..writeln('    }')
        ..writeln('    return _dispatch(rawValue, $offset);')
        ..writeln('  }');
    }
    buffer.writeln('}');
    buffer.writeln();
  }

  return '${buffer.toString()}\n';
}

Iterable<int> _methodIndexesForGroup({
  required int methodsPerFamily,
  required int groupCount,
  required int groupIndex,
}) sync* {
  final baseGroupSize = methodsPerFamily ~/ groupCount;
  final remainder = methodsPerFamily % groupCount;
  final start =
      groupIndex * baseGroupSize +
      (groupIndex < remainder ? groupIndex : remainder);
  final count = baseGroupSize + (groupIndex < remainder ? 1 : 0);
  for (var i = 0; i < count; i++) {
    yield start + i;
  }
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
  member_topology_${shape.name}:
    path: ${packageDir.path}
''');

  final importPath = switch (shape) {
    _Shape.inlineMembers => "package:member_topology_${shape.name}/family_api.dart",
    _Shape.sameLibraryExtensions => "package:member_topology_${shape.name}/family_api.dart",
    _Shape.splitExtensionsRoot => "package:member_topology_${shape.name}/family_api.dart",
    _Shape.splitExtensionsDirect =>
      "package:member_topology_${shape.name}/groups/group_0.dart",
  };

  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
import '$importPath';

void main() {
  final family = ApiFamily0(1);
  print(family.method0());
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

int _countLines(String source) => '\n'.allMatches(source).length + 1;

String _formatBytes(int bytes) {
  const kib = 1024;
  const mib = kib * 1024;
  if (bytes >= mib) {
    return '${(bytes / mib).toStringAsFixed(1)} MiB';
  }
  if (bytes >= kib) {
    return '${(bytes / kib).toStringAsFixed(1)} KiB';
  }
  return '$bytes B';
}

String _formatMib(int bytes) => (bytes / (1024 * 1024)).toStringAsFixed(1);

void _printResults(List<_ScenarioResult> results) {
  stdout.writeln(
    '| Shape | Files | Size | Lines | Analyze | Analyze RSS | Kernel | Kernel RSS |',
  );
  stdout.writeln(
    '| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |',
  );
  for (final result in results) {
    stdout.writeln(
      '| `${result.shape.name}` | '
      '${result.fileCount} | '
      '${_formatBytes(result.generatedBytes)} | '
      '${result.generatedLines} | '
      '${result.analyzeMs} ms | '
      '${_formatMib(result.analyzeMaxRssBytes)} MiB | '
      '${result.kernelMs} ms | '
      '${_formatMib(result.kernelMaxRssBytes)} MiB |',
    );
  }
}
