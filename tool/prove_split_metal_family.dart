import 'dart:io';

import 'package:ffigen/ffigen.dart';
import 'package:ffigen/src/config_provider/spec_utils.dart' as spec_utils;
import 'package:logging/logging.dart';

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.repoRoot,
    required this.workDir,
    required this.keepWorkDir,
  });

  final Directory repoRoot;
  final Directory workDir;
  final bool keepWorkDir;
}

final class _Scenario {
  const _Scenario({
    required this.key,
    required this.importStatement,
    required this.typePrefix,
  });

  final String key;
  final String importStatement;
  final String typePrefix;
}

final class _CommandResult {
  const _CommandResult({required this.elapsedMs, required this.maxRssBytes});

  final int elapsedMs;
  final int maxRssBytes;
}

final class _ScenarioResult {
  const _ScenarioResult({
    required this.scenario,
    required this.analyze,
    required this.kernel,
  });

  final _Scenario scenario;
  final _CommandResult analyze;
  final _CommandResult kernel;
}

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  if (options.workDir.existsSync()) {
    options.workDir.deleteSync(recursive: true);
  }
  options.workDir.createSync(recursive: true);

  final sdkPath = _sdkPathForMacos();
  final packagesDir = Directory('${options.workDir.path}/packages')
    ..createSync(recursive: true);
  final appsDir = Directory('${options.workDir.path}/apps')
    ..createSync(recursive: true);

  final monolithPackageDir = Directory(
    '${packagesDir.path}/objc_metal_archive_monolith_tmp',
  );
  final splitPackageDir = Directory(
    '${packagesDir.path}/objc_metal_archive_split_tmp',
  );

  try {
    await _generateMonolithPackage(
      repoRoot: options.repoRoot,
      packageDir: monolithPackageDir,
      sdkPath: sdkPath,
    );
    await _generateSplitPackage(
      repoRoot: options.repoRoot,
      packageDir: splitPackageDir,
      sdkPath: sdkPath,
    );

    final scenarios = const <_Scenario>[
      _Scenario(
        key: 'current_full_metal',
        importStatement: "import 'package:objc_metal/objc_metal.dart' as m;",
        typePrefix: 'm',
      ),
      _Scenario(
        key: 'archive_monolith',
        importStatement:
            "import 'package:objc_metal_archive_monolith_tmp/objc_metal_archive_monolith_tmp.dart' as m;",
        typePrefix: 'm',
      ),
      _Scenario(
        key: 'archive_split_root',
        importStatement:
            "import 'package:objc_metal_archive_split_tmp/objc_metal_archive_split_tmp.dart' as m;",
        typePrefix: 'm',
      ),
      _Scenario(
        key: 'archive_split_direct',
        importStatement:
            "import 'package:objc_metal_archive_split_tmp/archive.dart' as m;",
        typePrefix: 'm',
      ),
    ];

    final results = <_ScenarioResult>[];
    for (final scenario in scenarios) {
      results.add(
        await _measureScenario(
          repoRoot: options.repoRoot,
          appsDir: appsDir,
          scenario: scenario,
        ),
      );
    }

    _printPackageSummary(monolithPackageDir, splitPackageDir);
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

  for (final arg in args) {
    switch (arg) {
      case '--keep-workdir':
        keepWorkDir = true;
      case '--help':
      case '-h':
        stdout.writeln(
          'Usage: dart run tool/prove_split_metal_family.dart [--keep-workdir]',
        );
        exit(0);
      default:
        stderr.writeln('Unknown argument: $arg');
        exit(64);
    }
  }

  return BenchmarkOptions(
    repoRoot: repoRoot,
    workDir: Directory(
      '${Directory.systemTemp.path}/dart_objc_split_metal_family',
    ),
    keepWorkDir: keepWorkDir,
  );
}

bool _isArchiveDeclaration(Declaration declaration) =>
    declaration.originalName == 'MTL4Archive';

bool _isArchiveBaseDeclaration(Declaration declaration) {
  final name = declaration.originalName;
  return name.startsWith('MTL4BinaryFunction') ||
      name == 'MTL4FunctionDescriptor' ||
      name.startsWith('MTL4ComputePipelineDescriptor') ||
      name == 'MTL4PipelineDescriptor' ||
      name == 'MTL4PipelineStageDynamicLinkingDescriptor' ||
      name == 'MTL4RenderPipelineDynamicLinkingDescriptor' ||
      name == 'MTLComputePipelineState' ||
      name == 'MTLRenderPipelineState';
}

bool _isMonolithDeclaration(Declaration declaration) =>
    _isArchiveDeclaration(declaration) ||
    _isArchiveBaseDeclaration(declaration) ||
    _isAllocatorDeclaration(declaration);

bool _isAllocatorDeclaration(Declaration declaration) =>
    declaration.originalName.startsWith('MTL4Command');

Future<void> _generateMonolithPackage({
  required Directory repoRoot,
  required Directory packageDir,
  required String sdkPath,
}) async {
  await _writePackageScaffold(
    repoRoot: repoRoot,
    packageDir: packageDir,
    packageName: 'objc_metal_archive_monolith_tmp',
  );

  _makeMetalGenerator(
    packageDir: packageDir,
    packageName: 'objc_metal_archive_monolith_tmp',
    sdkPath: sdkPath,
    libraryName: 'family_bindings',
    includeDeclaration: _isMonolithDeclaration,
    importedTypesByUsr: const <String, ImportedType>{},
    libraryImports: const <LibraryImport>[],
  ).generate(logger: Logger('monolith'));

  File(
    '${packageDir.path}/lib/objc_metal_archive_monolith_tmp.dart',
  ).writeAsStringSync("export 'src/family_bindings.dart';\n");

  await _runChecked(
    workingDirectory: packageDir.path,
    arguments: const ['pub', 'get'],
  );
}

Future<void> _generateSplitPackage({
  required Directory repoRoot,
  required Directory packageDir,
  required String sdkPath,
}) async {
  await _writePackageScaffold(
    repoRoot: repoRoot,
    packageDir: packageDir,
    packageName: 'objc_metal_archive_split_tmp',
  );

  Logger.root.level = Level.OFF;
  final logger = Logger.root;

  final baseSymbolFile = File(
    '${packageDir.path}/lib/src/archive_base_symbols.yaml',
  );

  _makeMetalGenerator(
    packageDir: packageDir,
    packageName: 'objc_metal_archive_split_tmp',
    sdkPath: sdkPath,
    libraryName: 'archive_base_bindings',
    includeDeclaration: _isArchiveBaseDeclaration,
    importedTypesByUsr: const <String, ImportedType>{},
    libraryImports: const <LibraryImport>[],
    symbolFile: SymbolFile(
      Uri.parse('package:objc_metal_archive_split_tmp/archive_base.dart'),
      baseSymbolFile.uri,
    ),
  ).generate(logger: logger);

  final importLibraries = <String, LibraryImport>{};
  final importedTypes = spec_utils.symbolFileImportExtractor(
    logger,
    [baseSymbolFile.path],
    importLibraries,
    null,
    null,
  );

  _makeMetalGenerator(
    packageDir: packageDir,
    packageName: 'objc_metal_archive_split_tmp',
    sdkPath: sdkPath,
    libraryName: 'archive_bindings',
    includeDeclaration: _isArchiveDeclaration,
    importedTypesByUsr: importedTypes,
    libraryImports: importLibraries.values.toList(),
  ).generate(logger: logger);

  _makeMetalGenerator(
    packageDir: packageDir,
    packageName: 'objc_metal_archive_split_tmp',
    sdkPath: sdkPath,
    libraryName: 'allocator_bindings',
    includeDeclaration: _isAllocatorDeclaration,
    importedTypesByUsr: const <String, ImportedType>{},
    libraryImports: const <LibraryImport>[],
  ).generate(logger: logger);

  final archiveBaseFile = File(
    '${packageDir.path}/lib/src/archive_base_bindings.dart',
  );
  final archiveFile = File('${packageDir.path}/lib/src/archive_bindings.dart');
  final allocatorFile = File(
    '${packageDir.path}/lib/src/allocator_bindings.dart',
  );
  final archiveDuplicateNames = _topLevelTypeNames(
    archiveBaseFile,
  ).intersection(_topLevelTypeNames(archiveFile)).toList()..sort();
  final archivePublicNames = {
    ..._topLevelTypeNames(archiveBaseFile),
    ..._topLevelTypeNames(archiveFile),
  };
  final rootDuplicateNames =
      archivePublicNames
          .intersection(_topLevelTypeNames(allocatorFile))
          .toList()
        ..sort();

  File(
    '${packageDir.path}/lib/archive_base.dart',
  ).writeAsStringSync("export 'src/archive_base_bindings.dart';\n");
  File('${packageDir.path}/lib/archive.dart').writeAsStringSync(
    "export 'archive_base.dart'${_hideClause(archiveDuplicateNames)};\n"
    "export 'src/archive_bindings.dart';\n",
  );
  File(
    '${packageDir.path}/lib/allocator.dart',
  ).writeAsStringSync("export 'src/allocator_bindings.dart';\n");
  File(
    '${packageDir.path}/lib/objc_metal_archive_split_tmp.dart',
  ).writeAsStringSync(
    "export 'archive.dart';\n"
    "export 'allocator.dart'${_hideClause(rootDuplicateNames)};\n",
  );

  await _runChecked(
    workingDirectory: packageDir.path,
    arguments: const ['pub', 'get'],
  );
}

FfiGenerator _makeMetalGenerator({
  required Directory packageDir,
  required String packageName,
  required String sdkPath,
  required String libraryName,
  required bool Function(Declaration declaration) includeDeclaration,
  required Map<String, ImportedType> importedTypesByUsr,
  required List<LibraryImport> libraryImports,
  SymbolFile? symbolFile,
}) {
  return FfiGenerator(
    headers: Headers(
      entryPoints: [
        Uri.file(
          '$sdkPath/System/Library/Frameworks/Metal.framework/Headers/Metal.h',
        ),
      ],
      compilerOptions: [
        '-isysroot',
        sdkPath,
        '-F$sdkPath/System/Library/Frameworks',
      ],
      ignoreSourceErrors: true,
    ),
    objectiveC: ObjectiveC(
      interfaces: Interfaces(
        include: includeDeclaration,
        includeTransitive: false,
      ),
      protocols: Protocols(
        include: includeDeclaration,
        includeTransitive: false,
      ),
      categories: Categories(
        include: includeDeclaration,
        includeTransitive: false,
      ),
    ),
    output: Output(
      dartFile: Uri.file('${packageDir.path}/lib/src/$libraryName.dart'),
      objectiveCFile: Uri.file('${packageDir.path}/native/$libraryName.m'),
      symbolFile: symbolFile,
      commentType: const CommentType.none(),
      preamble:
          '// Metal split-family benchmark output for $packageName/$libraryName.',
      style: const NativeExternalBindings(),
    ),
    importedTypesByUsr: importedTypesByUsr,
    libraryImports: libraryImports,
  );
}

Future<void> _writePackageScaffold({
  required Directory repoRoot,
  required Directory packageDir,
  required String packageName,
}) async {
  packageDir.createSync(recursive: true);
  Directory('${packageDir.path}/lib/src').createSync(recursive: true);
  Directory('${packageDir.path}/native').createSync(recursive: true);

  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: $packageName
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  ffi: ^2.2.0
  objective_c:
    path: ${repoRoot.path}/ffigen/pkgs/objective_c

dependency_overrides:
  ffi:
    path: ${repoRoot.path}/ffigen/pkgs/ffi
''');

  File('${packageDir.path}/analysis_options.yaml').writeAsStringSync('''
analyzer:
  exclude:
    - lib/src/*_bindings.dart
''');
}

Future<_ScenarioResult> _measureScenario({
  required Directory repoRoot,
  required Directory appsDir,
  required _Scenario scenario,
}) async {
  final appDir = Directory('${appsDir.path}/${scenario.key}');
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
  Directory('${appDir.path}/bin').createSync(recursive: true);
  Directory('${appDir.path}/build').createSync(recursive: true);

  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: ${scenario.key}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  objc_metal:
    path: ${repoRoot.path}/packages/objc-metal
  objc_metal_archive_monolith_tmp:
    path: ${Directory('${optionsWorkDir(appsDir).path}/packages/objc_metal_archive_monolith_tmp').path}
  objc_metal_archive_split_tmp:
    path: ${Directory('${optionsWorkDir(appsDir).path}/packages/objc_metal_archive_split_tmp').path}

dependency_overrides:
  ffi:
    path: ${repoRoot.path}/ffigen/pkgs/ffi
  objective_c:
    path: ${repoRoot.path}/ffigen/pkgs/objective_c
''');

  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
${scenario.importStatement}

void main() {
  final types = <Type>[
    ${scenario.typePrefix}.MTL4Archive,
    ${scenario.typePrefix}.MTL4BinaryFunction,
  ];
  print(types.length);
}
''');

  await _runChecked(
    workingDirectory: appDir.path,
    arguments: const ['pub', 'get'],
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

  return _ScenarioResult(scenario: scenario, analyze: analyze, kernel: kernel);
}

Directory optionsWorkDir(Directory appsDir) => appsDir.parent;

Future<_CommandResult> _timeDartCommand({
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
      '/usr/bin/time',
      ['-l', 'dart', ...arguments],
      '${result.stdout}\n${result.stderr}',
      result.exitCode,
    );
  }

  final stderrText = result.stderr.toString();
  final realMatch = RegExp(
    r'^\s*([0-9]+(?:\.[0-9]+)?) real',
    multiLine: true,
  ).firstMatch(stderrText);
  final rssMatch = RegExp(
    r'^\s*([0-9]+)\s+maximum resident set size',
    multiLine: true,
  ).firstMatch(stderrText);
  if (realMatch == null || rssMatch == null) {
    throw StateError('Failed to parse timing output:\n$stderrText');
  }

  return _CommandResult(
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
      '${result.stdout}\n${result.stderr}',
      result.exitCode,
    );
  }
}

void _printPackageSummary(
  Directory monolithPackageDir,
  Directory splitPackageDir,
) {
  final monolithFile = File(
    '${monolithPackageDir.path}/lib/src/family_bindings.dart',
  );
  final splitBase = File(
    '${splitPackageDir.path}/lib/src/archive_base_bindings.dart',
  );
  final splitArchive = File(
    '${splitPackageDir.path}/lib/src/archive_bindings.dart',
  );
  final splitAllocator = File(
    '${splitPackageDir.path}/lib/src/allocator_bindings.dart',
  );

  stdout.writeln('Package sizes:');
  stdout.writeln(
    '  monolith_family: ${_lineCount(monolithFile)} lines, ${_mib(monolithFile.lengthSync())} MiB',
  );
  stdout.writeln(
    '  split_archive_base: ${_lineCount(splitBase)} lines, ${_mib(splitBase.lengthSync())} MiB',
  );
  stdout.writeln(
    '  split_archive: ${_lineCount(splitArchive)} lines, ${_mib(splitArchive.lengthSync())} MiB',
  );
  stdout.writeln(
    '  split_allocator: ${_lineCount(splitAllocator)} lines, ${_mib(splitAllocator.lengthSync())} MiB',
  );
  final totalSplitBytes =
      splitBase.lengthSync() +
      splitArchive.lengthSync() +
      splitAllocator.lengthSync();
  final totalSplitLines =
      _lineCount(splitBase) +
      _lineCount(splitArchive) +
      _lineCount(splitAllocator);
  stdout.writeln(
    '  split_total: $totalSplitLines lines, ${_mib(totalSplitBytes)} MiB',
  );
  final duplicateNames = _topLevelTypeNames(
    splitBase,
  ).intersection(_topLevelTypeNames(splitArchive)).toList()..sort();
  stdout.writeln(
    '  split_duplicate_exports: ${duplicateNames.length}${duplicateNames.isEmpty ? '' : ' (${duplicateNames.take(12).join(', ')})'}',
  );
}

void _printResults(List<_ScenarioResult> results) {
  stdout.writeln();
  stdout.writeln('Benchmarks:');
  for (final result in results) {
    stdout.writeln(
      '  ${result.scenario.key}: '
      'analyze ${result.analyze.elapsedMs} ms / ${_mib(result.analyze.maxRssBytes)} MiB, '
      'kernel ${result.kernel.elapsedMs} ms / ${_mib(result.kernel.maxRssBytes)} MiB',
    );
  }
}

int _lineCount(File file) =>
    '\n'.allMatches(file.readAsStringSync()).length + 1;

String _mib(int bytes) => (bytes / (1024 * 1024)).toStringAsFixed(1);

Set<String> _topLevelTypeNames(File file) {
  final text = file.readAsStringSync();
  final regex = RegExp(
    r'^(?:extension type|extension|final class|abstract final class|sealed class|enum|typedef|mixin|abstract interface class|interface class)\s+([A-Za-z0-9_$]+)',
    multiLine: true,
  );
  return regex.allMatches(text).map((match) => match.group(1)!).toSet();
}

String _hideClause(List<String> names) =>
    names.isEmpty ? '' : ' hide ${names.join(', ')}';

String _sdkPathForMacos() {
  final result = Process.runSync('xcrun', [
    '--show-sdk-path',
    '--sdk',
    'macosx',
  ]);
  if (result.exitCode != 0) {
    throw ProcessException(
      'xcrun',
      ['--show-sdk-path', '--sdk', 'macosx'],
      '${result.stdout}\n${result.stderr}',
      result.exitCode,
    );
  }
  return (result.stdout as String).trim();
}
