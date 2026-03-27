import 'dart:io';

import 'package:ffigen/ffigen.dart';

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

enum _UiKitMode {
  full,
  fullNoComments,
  fullNoProtocols,
  prefixOnly,
  prefixOnlyNoComments,
}

final class _ScenarioSpec {
  const _ScenarioSpec({
    required this.key,
    required this.packageName,
    required this.mode,
  });

  final String key;
  final String packageName;
  final _UiKitMode mode;
}

final class _ScenarioResult {
  const _ScenarioResult({
    required this.spec,
    required this.generatedBytes,
    required this.generatedLines,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
    required this.kernelMs,
    required this.kernelMaxRssBytes,
  });

  final _ScenarioSpec spec;
  final int generatedBytes;
  final int generatedLines;
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

  final sdkPath = _sdkPathForIphoneSimulator();
  final packagesDir = Directory('${options.workDir.path}/packages')
    ..createSync(recursive: true);
  final appsDir = Directory('${options.workDir.path}/apps')
    ..createSync(recursive: true);

  final scenarios = const <_ScenarioSpec>[
    _ScenarioSpec(
      key: 'uikit_full',
      packageName: 'objc_uikit_full_tmp',
      mode: _UiKitMode.full,
    ),
    _ScenarioSpec(
      key: 'uikit_full_no_comments',
      packageName: 'objc_uikit_full_no_comments_tmp',
      mode: _UiKitMode.fullNoComments,
    ),
    _ScenarioSpec(
      key: 'uikit_full_no_protocols',
      packageName: 'objc_uikit_full_no_protocols_tmp',
      mode: _UiKitMode.fullNoProtocols,
    ),
    _ScenarioSpec(
      key: 'uikit_prefix_only',
      packageName: 'objc_uikit_prefix_only_tmp',
      mode: _UiKitMode.prefixOnly,
    ),
    _ScenarioSpec(
      key: 'uikit_prefix_only_no_comments',
      packageName: 'objc_uikit_prefix_only_no_comments_tmp',
      mode: _UiKitMode.prefixOnlyNoComments,
    ),
  ];

  try {
    final results = <_ScenarioResult>[];
    for (final spec in scenarios) {
      final packageDir = Directory('${packagesDir.path}/${spec.packageName}');
      await _generateUiKitPackage(
        repoRoot: options.repoRoot,
        packageDir: packageDir,
        packageName: spec.packageName,
        sdkPath: sdkPath,
        mode: spec.mode,
      );

      final scenario = _Scenario(
        spec: spec,
        packageDir: packageDir,
        bindingFile: File('${packageDir.path}/lib/src/uikit_bindings.dart'),
      );
      results.add(
        await _measureScenario(
          repoRoot: options.repoRoot,
          appsDir: appsDir,
          scenario: scenario,
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

final class _Scenario {
  const _Scenario({
    required this.spec,
    required this.packageDir,
    required this.bindingFile,
  });

  final _ScenarioSpec spec;
  final Directory packageDir;
  final File bindingFile;
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
          'Usage: dart run tool/prove_uikit_variants.dart [--keep-workdir]',
        );
        exit(0);
      default:
        stderr.writeln('Unknown argument: $arg');
        exit(64);
    }
  }

  return BenchmarkOptions(
    repoRoot: repoRoot,
    workDir: Directory('${Directory.systemTemp.path}/dart_objc_uikit_variants'),
    keepWorkDir: keepWorkDir,
  );
}

Future<_ScenarioResult> _measureScenario({
  required Directory repoRoot,
  required Directory appsDir,
  required _Scenario scenario,
}) async {
  final bindingText = scenario.bindingFile.readAsStringSync();
  final appDir = await _prepareHarness(
    repoRoot: repoRoot,
    appsDir: appsDir,
    scenario: scenario,
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

  return _ScenarioResult(
    spec: scenario.spec,
    generatedBytes: scenario.bindingFile.lengthSync(),
    generatedLines: '\n'.allMatches(bindingText).length + 1,
    analyzeMs: analyze.elapsedMs,
    analyzeMaxRssBytes: analyze.maxRssBytes,
    kernelMs: kernel.elapsedMs,
    kernelMaxRssBytes: kernel.maxRssBytes,
  );
}

Future<void> _generateUiKitPackage({
  required Directory repoRoot,
  required Directory packageDir,
  required String packageName,
  required String sdkPath,
  required _UiKitMode mode,
}) async {
  packageDir.createSync(recursive: true);
  Directory('${packageDir.path}/lib/src').createSync(recursive: true);
  Directory('${packageDir.path}/native').createSync(recursive: true);

  await _writePackageScaffold(
    repoRoot: repoRoot,
    packageDir: packageDir,
    packageName: packageName,
  );

  bool includeUi(Declaration declaration) =>
      declaration.originalName.startsWith('UI');
  bool includeSubclassHelpers(Declaration declaration) =>
      declaration.originalName == 'UIViewController';
  bool includeMember(Declaration declaration, String member) {
    if (declaration.originalName == 'UIViewController' &&
        member == 'preferredContainerBackgroundStyle') {
      return false;
    }
    if (declaration.originalName == 'CIImageProcessorKernel' &&
        (member == 'outputIsOpaque' || member == 'synchronizeInputs')) {
      return false;
    }
    return true;
  }

  final objectiveC = switch (mode) {
    _UiKitMode.full || _UiKitMode.fullNoComments => ObjectiveC(
      interfaces: Interfaces(
        include: Declarations.includeAll,
        includeTransitive: true,
        includeSubclassHelpers: includeSubclassHelpers,
        includeMember: includeMember,
      ),
      protocols: Protocols(
        include: Declarations.includeAll,
        includeTransitive: true,
      ),
      categories: Categories(
        include: Declarations.includeAll,
        includeTransitive: true,
      ),
    ),
    _UiKitMode.fullNoProtocols => ObjectiveC(
      interfaces: Interfaces(
        include: Declarations.includeAll,
        includeTransitive: true,
        includeSubclassHelpers: includeSubclassHelpers,
        includeMember: includeMember,
      ),
      protocols: Protocols.excludeAll,
      categories: Categories.excludeAll,
    ),
    _UiKitMode.prefixOnly || _UiKitMode.prefixOnlyNoComments => ObjectiveC(
      interfaces: Interfaces(
        include: includeUi,
        includeTransitive: false,
        includeSubclassHelpers: includeSubclassHelpers,
        includeMember: includeMember,
      ),
      protocols: Protocols(include: includeUi, includeTransitive: false),
      categories: Categories(include: includeUi, includeTransitive: false),
    ),
  };

  final commentType = switch (mode) {
    _UiKitMode.fullNoComments ||
    _UiKitMode.prefixOnlyNoComments => const CommentType.none(),
    _ => const CommentType.def(),
  };

  final generator = FfiGenerator(
    headers: Headers(
      entryPoints: [
        Uri.file(
          '$sdkPath/System/Library/Frameworks/UIKit.framework/Headers/UIKit.h',
        ),
      ],
      compilerOptions: [
        '-isysroot',
        sdkPath,
        '-F$sdkPath/System/Library/Frameworks',
      ],
      ignoreSourceErrors: true,
    ),
    objectiveC: objectiveC,
    output: Output(
      dartFile: Uri.file('${packageDir.path}/lib/src/uikit_bindings.dart'),
      objectiveCFile: Uri.file('${packageDir.path}/native/uikit_bindings.m'),
      commentType: commentType,
      preamble: '// UIKit benchmark package.',
      style: const NativeExternalBindings(),
    ),
  );
  generator.generate();
  await _runChecked(
    workingDirectory: packageDir.path,
    arguments: const ['pub', 'get'],
  );
}

Future<void> _writePackageScaffold({
  required Directory repoRoot,
  required Directory packageDir,
  required String packageName,
}) async {
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
  File(
    '${packageDir.path}/lib/$packageName.dart',
  ).writeAsStringSync("export 'src/uikit_bindings.dart';\n");
}

Future<Directory> _prepareHarness({
  required Directory repoRoot,
  required Directory appsDir,
  required _Scenario scenario,
}) async {
  final appDir = Directory('${appsDir.path}/${scenario.spec.key}');
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
  Directory('${appDir.path}/bin').createSync(recursive: true);
  Directory('${appDir.path}/build').createSync(recursive: true);
  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: ${scenario.spec.key}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  ${scenario.spec.packageName}:
    path: ${scenario.packageDir.path}

dependency_overrides:
  objective_c:
    path: ${repoRoot.path}/ffigen/pkgs/objective_c
  ffi:
    path: ${repoRoot.path}/ffigen/pkgs/ffi
''');
  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
import 'package:${scenario.spec.packageName}/${scenario.spec.packageName}.dart'
    as uikit;

void main() {
  final controller = uikit.UIViewController.alloc();
  print(controller);
}
''');
  await _runChecked(
    workingDirectory: appDir.path,
    arguments: const ['pub', 'get'],
  );
  return appDir;
}

String _sdkPathForIphoneSimulator() {
  final result = Process.runSync('xcrun', [
    '--show-sdk-path',
    '--sdk',
    'iphonesimulator',
  ]);
  if (result.exitCode != 0) {
    throw ProcessException(
      'xcrun',
      ['--show-sdk-path', '--sdk', 'iphonesimulator'],
      '${result.stdout}${result.stderr}',
      result.exitCode,
    );
  }
  return (result.stdout as String)
      .split('\n')
      .firstWhere((line) => line.trim().isNotEmpty);
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
  stdout.writeln(
    'scenario                         gen_size   gen_lines  analyze_ms  analyze_rss  kernel_ms  kernel_rss',
  );
  for (final result in results) {
    stdout.writeln(
      '${result.spec.key.padRight(31)} '
      '${_formatBytes(result.generatedBytes).padLeft(10)} '
      '${result.generatedLines.toString().padLeft(10)} '
      '${result.analyzeMs.toString().padLeft(10)} '
      '${_formatBytes(result.analyzeMaxRssBytes).padLeft(12)} '
      '${result.kernelMs.toString().padLeft(9)} '
      '${_formatBytes(result.kernelMaxRssBytes).padLeft(11)}',
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
