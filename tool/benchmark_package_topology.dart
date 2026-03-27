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
  monolith,
  samePackageRoot,
  multiPackageRoot,
  multiPackageDirect,
}

final class _ScenarioResult {
  const _ScenarioResult({
    required this.shape,
    required this.packageCount,
    required this.fileCount,
    required this.generatedLines,
    required this.generatedBytes,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
    required this.kernelMs,
    required this.kernelMaxRssBytes,
  });

  final _Shape shape;
  final int packageCount;
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
      final scenarioDir = Directory('${options.workDir.path}/${shape.name}');
      final generated = await _writeScenario(
        scenarioDir: scenarioDir,
        shape: shape,
        familyCount: options.familyCount,
        methodsPerFamily: options.methodsPerFamily,
        groupCount: options.groupCount,
      );
      final appDir = await _writeHarness(
        workDir: options.workDir,
        scenarioDir: scenarioDir,
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
          packageCount: generated.packageCount,
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
Usage: dart run tool/benchmark_package_topology.dart [options]

Options:
  --families N   Number of synthetic API families. Default: 1500
  --methods N    Methods per family. Default: 24
  --groups N     Number of grouped method libraries/packages. Default: 6
  --keep-workdir
''');
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  return BenchmarkOptions(
    workDir: Directory('${Directory.systemTemp.path}/dart_package_topology'),
    keepWorkDir: keepWorkDir,
    familyCount: familyCount,
    methodsPerFamily: methodsPerFamily,
    groupCount: groupCount,
  );
}

final class _GeneratedScenario {
  const _GeneratedScenario({
    required this.packageCount,
    required this.fileCount,
    required this.lines,
    required this.bytes,
  });

  final int packageCount;
  final int fileCount;
  final int lines;
  final int bytes;
}

Future<_GeneratedScenario> _writeScenario({
  required Directory scenarioDir,
  required _Shape shape,
  required int familyCount,
  required int methodsPerFamily,
  required int groupCount,
}) async {
  scenarioDir.createSync(recursive: true);
  switch (shape) {
    case _Shape.monolith:
      return _writeMonolithScenario(
        scenarioDir: scenarioDir,
        familyCount: familyCount,
        methodsPerFamily: methodsPerFamily,
      );
    case _Shape.samePackageRoot:
      return _writeSamePackageRootScenario(
        scenarioDir: scenarioDir,
        familyCount: familyCount,
        methodsPerFamily: methodsPerFamily,
        groupCount: groupCount,
      );
    case _Shape.multiPackageRoot:
    case _Shape.multiPackageDirect:
      return _writeMultiPackageScenario(
        scenarioDir: scenarioDir,
        familyCount: familyCount,
        methodsPerFamily: methodsPerFamily,
        groupCount: groupCount,
      );
  }
}

_GeneratedScenario _writeMonolithScenario({
  required Directory scenarioDir,
  required int familyCount,
  required int methodsPerFamily,
}) {
  final packageDir = Directory('${scenarioDir.path}/api_monolith')
    ..createSync(recursive: true);
  final libDir = Directory('${packageDir.path}/lib')..createSync();
  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: api_monolith
publish_to: none

environment:
  sdk: ^3.11.0
''');
  final source = _monolithSource(
    familyCount: familyCount,
    methodsPerFamily: methodsPerFamily,
  );
  File('${libDir.path}/api_monolith.dart').writeAsStringSync(source);
  return _GeneratedScenario(
    packageCount: 1,
    fileCount: 1,
    lines: _countLines(source),
    bytes: source.length,
  );
}

_GeneratedScenario _writeSamePackageRootScenario({
  required Directory scenarioDir,
  required int familyCount,
  required int methodsPerFamily,
  required int groupCount,
}) {
  final packageDir = Directory('${scenarioDir.path}/api_same_package')
    ..createSync(recursive: true);
  final libDir = Directory('${packageDir.path}/lib')..createSync();
  Directory('${libDir.path}/src/groups').createSync(recursive: true);
  Directory('${libDir.path}/groups').createSync(recursive: true);

  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: api_same_package
publish_to: none

environment:
  sdk: ^3.11.0
''');

  var fileCount = 0;
  var lines = 0;
  var bytes = 0;
  void record(String relativePath, String content) {
    File('${libDir.path}/$relativePath').writeAsStringSync(content);
    fileCount++;
    lines += _countLines(content);
    bytes += content.length;
  }

  record('api_same_package.dart', _samePackageRootSource(groupCount));
  record('src/core.dart', _coreSource(familyCount: familyCount));
  for (var groupIndex = 0; groupIndex < groupCount; groupIndex++) {
    record(
      'src/groups/group_$groupIndex.dart',
      _groupSource(
        familyCount: familyCount,
        methodsPerFamily: methodsPerFamily,
        groupCount: groupCount,
        groupIndex: groupIndex,
        coreImport: "../core.dart",
      ),
    );
    record(
      'groups/group_$groupIndex.dart',
      '''
export '../src/core.dart';
export '../src/groups/group_$groupIndex.dart';
''',
    );
  }

  return _GeneratedScenario(
    packageCount: 1,
    fileCount: fileCount,
    lines: lines,
    bytes: bytes,
  );
}

_GeneratedScenario _writeMultiPackageScenario({
  required Directory scenarioDir,
  required int familyCount,
  required int methodsPerFamily,
  required int groupCount,
}) {
  var packageCount = 0;
  var fileCount = 0;
  var lines = 0;
  var bytes = 0;

  void recordPackage(String packageName, Map<String, String> files) {
    final packageDir = Directory('${scenarioDir.path}/$packageName')
      ..createSync(recursive: true);
    for (final entry in files.entries) {
      final file = File('${packageDir.path}/${entry.key}')
        ..parent.createSync(recursive: true)
        ..writeAsStringSync(entry.value);
      if (file.path.endsWith('.dart')) {
        fileCount++;
        lines += _countLines(entry.value);
        bytes += entry.value.length;
      }
    }
    packageCount++;
  }

  recordPackage('api_core', {
    'pubspec.yaml': '''
name: api_core
publish_to: none

environment:
  sdk: ^3.11.0
''',
    'lib/api_core.dart': _coreSource(familyCount: familyCount),
  });

  for (var groupIndex = 0; groupIndex < groupCount; groupIndex++) {
    recordPackage('api_group_$groupIndex', {
      'pubspec.yaml': '''
name: api_group_$groupIndex
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  api_core:
    path: ../api_core
''',
      'lib/api_group_$groupIndex.dart': '''
export 'package:api_core/api_core.dart';
export 'src/group_$groupIndex.dart';
''',
      'lib/src/group_$groupIndex.dart': _groupSource(
        familyCount: familyCount,
        methodsPerFamily: methodsPerFamily,
        groupCount: groupCount,
        groupIndex: groupIndex,
        coreImport: "package:api_core/api_core.dart",
      ),
    });
  }

  final umbrellaDeps = StringBuffer()
    ..writeln('  api_core:')
    ..writeln('    path: ../api_core');
  final umbrellaExports = StringBuffer()
    ..writeln("export 'package:api_core/api_core.dart';");
  for (var groupIndex = 0; groupIndex < groupCount; groupIndex++) {
    umbrellaDeps
      ..writeln('  api_group_$groupIndex:')
      ..writeln('    path: ../api_group_$groupIndex');
    umbrellaExports.writeln(
      "export 'package:api_group_$groupIndex/api_group_$groupIndex.dart';",
    );
  }
  recordPackage('api_umbrella', {
    'pubspec.yaml': '''
name: api_umbrella
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
${umbrellaDeps.toString()}''',
    'lib/api_umbrella.dart': '${umbrellaExports.toString()}\n',
  });

  return _GeneratedScenario(
    packageCount: packageCount,
    fileCount: fileCount,
    lines: lines,
    bytes: bytes,
  );
}

String _monolithSource({
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
    buffer
      ..writeln('}')
      ..writeln();
  }

  return '${buffer.toString()}\n';
}

String _samePackageRootSource(int groupCount) {
  final buffer = StringBuffer()..writeln("export 'src/core.dart';");
  for (var groupIndex = 0; groupIndex < groupCount; groupIndex++) {
    buffer.writeln("export 'groups/group_$groupIndex.dart';");
  }
  return '${buffer.toString()}\n';
}

String _coreSource({required int familyCount}) {
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

String _groupSource({
  required int familyCount,
  required int methodsPerFamily,
  required int groupCount,
  required int groupIndex,
  required String coreImport,
}) {
  final buffer = StringBuffer()
    ..writeln("import '$coreImport';")
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
    buffer
      ..writeln('}')
      ..writeln();
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
  required Directory scenarioDir,
  required _Shape shape,
}) async {
  final appDir = Directory('${workDir.path}/app_${shape.name}');
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
  Directory('${appDir.path}/bin').createSync(recursive: true);
  Directory('${appDir.path}/build').createSync(recursive: true);

  final dependencyName = switch (shape) {
    _Shape.monolith => 'api_monolith',
    _Shape.samePackageRoot => 'api_same_package',
    _Shape.multiPackageRoot => 'api_umbrella',
    _Shape.multiPackageDirect => 'api_group_0',
  };

  final dependencyPath = switch (shape) {
    _Shape.monolith => '${scenarioDir.path}/api_monolith',
    _Shape.samePackageRoot => '${scenarioDir.path}/api_same_package',
    _Shape.multiPackageRoot => '${scenarioDir.path}/api_umbrella',
    _Shape.multiPackageDirect => '${scenarioDir.path}/api_group_0',
  };

  final importPath = switch (shape) {
    _Shape.monolith => 'package:api_monolith/api_monolith.dart',
    _Shape.samePackageRoot =>
      'package:api_same_package/api_same_package.dart',
    _Shape.multiPackageRoot => 'package:api_umbrella/api_umbrella.dart',
    _Shape.multiPackageDirect => 'package:api_group_0/api_group_0.dart',
  };

  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: app_${shape.name}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  $dependencyName:
    path: $dependencyPath
''');

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
    '| Shape | Packages | Files | Size | Lines | Analyze | Analyze RSS | Kernel | Kernel RSS |',
  );
  stdout.writeln(
    '| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |',
  );
  for (final result in results) {
    stdout.writeln(
      '| `${result.shape.name}` | '
      '${result.packageCount} | '
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
