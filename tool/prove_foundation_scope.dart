import 'dart:io';

enum BenchmarkPhase { analyze, kernel, cli }

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.repoRoot,
    required this.workDir,
    required this.runs,
    required this.warmups,
    required this.keepWorkDir,
  });

  final Directory repoRoot;
  final Directory workDir;
  final int runs;
  final int warmups;
  final bool keepWorkDir;
}

final class Scenario {
  const Scenario({
    required this.key,
    required this.packageName,
    required this.packagePath,
    required this.bindingFilePath,
    required this.source,
  });

  final String key;
  final String packageName;
  final String packagePath;
  final String bindingFilePath;
  final String source;
}

final class ScenarioResult {
  const ScenarioResult({
    required this.scenario,
    required this.generatedBytes,
    required this.generatedLines,
    required this.analyzeMs,
    required this.kernelMs,
    required this.kernelBytes,
    required this.cliMs,
    required this.cliBundleBytes,
  });

  final Scenario scenario;
  final int generatedBytes;
  final int generatedLines;
  final double analyzeMs;
  final double kernelMs;
  final int kernelBytes;
  final double cliMs;
  final int cliBundleBytes;
}

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);

  if (options.workDir.existsSync()) {
    options.workDir.deleteSync(recursive: true);
  }
  options.workDir.createSync(recursive: true);

  final minimalPackageDir = Directory(
    '${options.workDir.path}/generated/objc_foundation_process_info',
  );
  await _generateMinimalFoundationPackage(options.repoRoot, minimalPackageDir);

  final scenarios = _scenarios(options.repoRoot, minimalPackageDir);
  final projectDirs = <String, Directory>{};

  try {
    for (final scenario in scenarios) {
      final projectDir = Directory('${options.workDir.path}/${scenario.key}');
      await _prepareProject(projectDir: projectDir, scenario: scenario);
      projectDirs[scenario.key] = projectDir;
    }

    final analyzeMs = await _measurePhaseAcrossScenarios(
      scenarios: scenarios,
      projectDirs: projectDirs,
      phase: BenchmarkPhase.analyze,
      command: const ['analyze', 'bin/main.dart'],
      options: options,
    );
    final kernelMs = await _measurePhaseAcrossScenarios(
      scenarios: scenarios,
      projectDirs: projectDirs,
      phase: BenchmarkPhase.kernel,
      command: const [
        'compile',
        'kernel',
        'bin/main.dart',
        '-o',
        'build/app.dill',
      ],
      options: options,
    );
    final cliMs = await _measurePhaseAcrossScenarios(
      scenarios: scenarios,
      projectDirs: projectDirs,
      phase: BenchmarkPhase.cli,
      command: const [
        'build',
        'cli',
        '--target=bin/main.dart',
        '--output=build/cli',
      ],
      options: options,
    );

    final results = <ScenarioResult>[
      for (final scenario in scenarios)
        _buildScenarioResult(
          scenario: scenario,
          projectDir: projectDirs[scenario.key]!,
          analyzeMs: analyzeMs[scenario.key]!,
          kernelMs: kernelMs[scenario.key]!,
          cliMs: cliMs[scenario.key]!,
        ),
    ];

    _printResults(results);
  } finally {
    if (!options.keepWorkDir && options.workDir.existsSync()) {
      options.workDir.deleteSync(recursive: true);
    }
  }
}

BenchmarkOptions _parseArgs(List<String> args) {
  final repoRoot = Directory.current.absolute;
  var runs = 3;
  var warmups = 1;
  var keepWorkDir = false;

  for (final arg in args) {
    if (arg.startsWith('--runs=')) {
      runs = int.parse(arg.substring('--runs='.length));
      continue;
    }
    if (arg.startsWith('--warmups=')) {
      warmups = int.parse(arg.substring('--warmups='.length));
      continue;
    }
    if (arg == '--keep-workdir') {
      keepWorkDir = true;
      continue;
    }
    if (arg == '--help') {
      stdout.writeln(
        'Usage: dart run tool/prove_foundation_scope.dart '
        '[--runs=3] [--warmups=1] [--keep-workdir]',
      );
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  if (runs < 1 || warmups < 0) {
    stderr.writeln('--runs must be >= 1 and --warmups must be >= 0');
    exit(64);
  }

  return BenchmarkOptions(
    repoRoot: repoRoot,
    workDir: Directory(
      '${Directory.systemTemp.path}/dart_objc_foundation_scope',
    ),
    runs: runs,
    warmups: warmups,
    keepWorkDir: keepWorkDir,
  );
}

List<Scenario> _scenarios(Directory repoRoot, Directory minimalPackageDir) => [
  Scenario(
    key: 'single_api_generated',
    packageName: 'objc_foundation_process_info',
    packagePath: minimalPackageDir.path,
    bindingFilePath:
        '${minimalPackageDir.path}/lib/src/objc_foundation_process_info_bindings.dart',
    source: '''
import 'dart:io';

import 'package:objc_foundation_process_info/objc_foundation_process_info.dart'
    as foundation;

void main() {
  final processInfo = foundation.NSProcessInfo.getProcessInfo();
  stdout.writeln(processInfo.processIdentifier);
}
''',
  ),
  Scenario(
    key: 'full_package_generated',
    packageName: 'objc_foundation',
    packagePath: '${repoRoot.path}/packages/objc-foundation',
    bindingFilePath:
        '${repoRoot.path}/packages/objc-foundation/lib/src/foundation_bindings.dart',
    source: '''
import 'dart:io';

import 'package:objc_foundation/objc_foundation.dart' as foundation;

void main() {
  final processInfo = foundation.NSProcessInfo.getProcessInfo();
  stdout.writeln(processInfo.processIdentifier);
}
''',
  ),
];

Future<void> _generateMinimalFoundationPackage(
  Directory repoRoot,
  Directory packageDir,
) async {
  Directory('${packageDir.path}/lib/src').createSync(recursive: true);
  Directory('${packageDir.path}/native').createSync(recursive: true);

  final generatorDir = Directory('${packageDir.parent.path}/generator');
  Directory('${generatorDir.path}/bin').createSync(recursive: true);

  final sdkPath = _sdkPathForMacos();

  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: objc_foundation_process_info
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  ffi: ^2.2.0
  objective_c:
    path: '${repoRoot.path}/ffigen/pkgs/objective_c'

dependency_overrides:
  ffi:
    path: '${repoRoot.path}/ffigen/pkgs/ffi'
''');
  File(
    '${packageDir.path}/lib/objc_foundation_process_info.dart',
  ).writeAsStringSync(
    "export 'src/objc_foundation_process_info_bindings.dart';\n",
  );

  File('${generatorDir.path}/pubspec.yaml').writeAsStringSync('''
name: objc_foundation_scope_generator
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  ffigen:
    path: '${repoRoot.path}/ffigen/pkgs/ffigen'
''');

  File('${generatorDir.path}/bin/generate.dart').writeAsStringSync('''
import 'package:ffigen/ffigen.dart';

bool includeProcessInfoMember(Declaration declaration, String member) {
  if (declaration.originalName != 'NSProcessInfo') {
    return false;
  }
  return member == 'processInfo' || member == 'processIdentifier';
}

void main() {
  final generator = FfiGenerator(
    headers: Headers(
      entryPoints: [
        Uri.file(
          '$sdkPath/System/Library/Frameworks/Foundation.framework/Headers/Foundation.h',
        ),
      ],
      compilerOptions: [
        '-isysroot',
        '$sdkPath',
        '-F$sdkPath/System/Library/Frameworks',
      ],
      ignoreSourceErrors: true,
    ),
    objectiveC: ObjectiveC(
      interfaces: Interfaces(
        include: Declarations.includeSet({'NSProcessInfo'}),
        includeTransitive: false,
        includeMember: includeProcessInfoMember,
      ),
      protocols: Protocols.excludeAll,
      categories: Categories.excludeAll,
    ),
    output: Output(
      dartFile: Uri.file(
        '${packageDir.path}/lib/src/objc_foundation_process_info_bindings.dart',
      ),
      objectiveCFile: Uri.file(
        '${packageDir.path}/native/objc_foundation_process_info_bindings.m',
      ),
      preamble: '// Minimal Foundation bindings generated for benchmark comparison.',
      style: const NativeExternalBindings(),
    ),
  );
  generator.generate();
}
''');

  await _runChecked(
    executable: Platform.environment['DART_BIN'] ?? 'dart',
    arguments: ['pub', 'get'],
    workingDirectory: generatorDir.path,
    quiet: true,
  );
  await _runChecked(
    executable: Platform.environment['DART_BIN'] ?? 'dart',
    arguments: ['run', 'bin/generate.dart'],
    workingDirectory: generatorDir.path,
    quiet: true,
  );
}

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
      '${result.stdout}${result.stderr}',
      result.exitCode,
    );
  }
  return (result.stdout as String)
      .split('\n')
      .firstWhere((line) => line.trim().isNotEmpty);
}

Future<void> _prepareProject({
  required Directory projectDir,
  required Scenario scenario,
}) async {
  if (projectDir.existsSync()) {
    projectDir.deleteSync(recursive: true);
  }
  Directory('${projectDir.path}/bin').createSync(recursive: true);
  Directory('${projectDir.path}/build').createSync(recursive: true);

  File('${projectDir.path}/pubspec.yaml').writeAsStringSync('''
name: ${scenario.key}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  ${scenario.packageName}:
    path: '${scenario.packagePath}'

dependency_overrides:
  objective_c:
    path: '${Directory.current.path}/ffigen/pkgs/objective_c'
  ffi:
    path: '${Directory.current.path}/ffigen/pkgs/ffi'
''');
  File('${projectDir.path}/bin/main.dart').writeAsStringSync(scenario.source);

  await _runChecked(
    executable: Platform.environment['DART_BIN'] ?? 'dart',
    arguments: ['pub', 'get'],
    workingDirectory: projectDir.path,
    quiet: true,
  );
}

ScenarioResult _buildScenarioResult({
  required Scenario scenario,
  required Directory projectDir,
  required double analyzeMs,
  required double kernelMs,
  required double cliMs,
}) {
  final bindingFile = File(scenario.bindingFilePath);
  final bindingText = bindingFile.readAsStringSync();

  return ScenarioResult(
    scenario: scenario,
    generatedBytes: bindingFile.lengthSync(),
    generatedLines: '\n'.allMatches(bindingText).length + 1,
    analyzeMs: analyzeMs,
    kernelMs: kernelMs,
    kernelBytes: File('${projectDir.path}/build/app.dill').lengthSync(),
    cliMs: cliMs,
    cliBundleBytes: _directorySize(
      Directory('${projectDir.path}/build/cli/bundle'),
    ),
  );
}

Future<Map<String, double>> _measurePhaseAcrossScenarios({
  required List<Scenario> scenarios,
  required Map<String, Directory> projectDirs,
  required BenchmarkPhase phase,
  required List<String> command,
  required BenchmarkOptions options,
}) async {
  final dart = Platform.environment['DART_BIN'] ?? 'dart';
  final durations = <String, List<int>>{
    for (final scenario in scenarios) scenario.key: <int>[],
  };

  for (var i = 0; i < options.warmups; i++) {
    for (final scenario in _orderedScenarios(scenarios, i)) {
      final projectDir = projectDirs[scenario.key]!;
      _clearPhaseOutput(phase, projectDir);
      await _runChecked(
        executable: dart,
        arguments: command,
        workingDirectory: projectDir.path,
        quiet: true,
      );
    }
  }

  for (var i = 0; i < options.runs; i++) {
    for (final scenario in _orderedScenarios(scenarios, i)) {
      final projectDir = projectDirs[scenario.key]!;
      _clearPhaseOutput(phase, projectDir);
      final stopwatch = Stopwatch()..start();
      await _runChecked(
        executable: dart,
        arguments: command,
        workingDirectory: projectDir.path,
        quiet: true,
      );
      stopwatch.stop();
      durations[scenario.key]!.add(stopwatch.elapsedMilliseconds);
    }
  }

  return {
    for (final scenario in scenarios)
      scenario.key:
          durations[scenario.key]!.reduce((a, b) => a + b) /
          durations[scenario.key]!.length,
  };
}

Iterable<Scenario> _orderedScenarios(
  List<Scenario> scenarios,
  int iteration,
) sync* {
  if (iteration.isEven) {
    yield* scenarios;
    return;
  }
  for (final scenario in scenarios.reversed) {
    yield scenario;
  }
}

void _clearPhaseOutput(BenchmarkPhase phase, Directory projectDir) {
  switch (phase) {
    case BenchmarkPhase.analyze:
      return;
    case BenchmarkPhase.kernel:
      final file = File('${projectDir.path}/build/app.dill');
      if (file.existsSync()) {
        file.deleteSync();
      }
    case BenchmarkPhase.cli:
      final dir = Directory('${projectDir.path}/build/cli');
      if (dir.existsSync()) {
        dir.deleteSync(recursive: true);
      }
  }
}

Future<void> _runChecked({
  required String executable,
  required List<String> arguments,
  required String workingDirectory,
  bool quiet = false,
}) async {
  final result = await Process.run(
    executable,
    arguments,
    workingDirectory: workingDirectory,
  );
  if (result.exitCode != 0) {
    throw ProcessException(
      executable,
      arguments,
      '${result.stdout}${result.stderr}',
      result.exitCode,
    );
  }
  if (!quiet) {
    final stdoutText = (result.stdout as String).trim();
    final stderrText = (result.stderr as String).trim();
    if (stdoutText.isNotEmpty) {
      stdout.writeln(stdoutText);
    }
    if (stderrText.isNotEmpty) {
      stderr.writeln(stderrText);
    }
  }
}

int _directorySize(Directory directory) {
  var bytes = 0;
  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File) {
      bytes += entity.lengthSync();
    }
  }
  return bytes;
}

void _printResults(List<ScenarioResult> results) {
  final baseline = results.firstWhere(
    (result) => result.scenario.key == 'single_api_generated',
  );
  final full = results.firstWhere(
    (result) => result.scenario.key == 'full_package_generated',
  );

  stdout.writeln('');
  stdout.writeln(
    'scenario                  gen_size   gen_lines  analyze_ms  kernel_ms  kernel_size  cli_ms  cli_bundle',
  );
  for (final result in results) {
    stdout.writeln(
      '${result.scenario.key.padRight(24)} '
      '${_formatBytes(result.generatedBytes).padLeft(10)} '
      '${result.generatedLines.toString().padLeft(10)} '
      '${result.analyzeMs.toStringAsFixed(1).padLeft(10)} '
      '${result.kernelMs.toStringAsFixed(1).padLeft(10)} '
      '${_formatBytes(result.kernelBytes).padLeft(11)} '
      '${result.cliMs.toStringAsFixed(1).padLeft(7)} '
      '${_formatBytes(result.cliBundleBytes).padLeft(10)}',
    );
  }

  stdout.writeln('');
  stdout.writeln('metric                    delta');
  stdout.writeln(
    'generated_size            ${_formatSignedBytes(full.generatedBytes - baseline.generatedBytes)}',
  );
  stdout.writeln(
    'generated_lines           ${(full.generatedLines - baseline.generatedLines).toString()}',
  );
  stdout.writeln(
    'analyze_ms                ${(full.analyzeMs - baseline.analyzeMs).toStringAsFixed(1)}',
  );
  stdout.writeln(
    'kernel_ms                 ${(full.kernelMs - baseline.kernelMs).toStringAsFixed(1)}',
  );
  stdout.writeln(
    'kernel_size               ${_formatSignedBytes(full.kernelBytes - baseline.kernelBytes)}',
  );
  stdout.writeln(
    'cli_ms                    ${(full.cliMs - baseline.cliMs).toStringAsFixed(1)}',
  );
  stdout.writeln(
    'cli_bundle                ${_formatSignedBytes(full.cliBundleBytes - baseline.cliBundleBytes)}',
  );
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

String _formatSignedBytes(int bytes) {
  final sign = bytes > 0 ? '+' : '';
  return '$sign${_formatBytes(bytes.abs())}';
}
