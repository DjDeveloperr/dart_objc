import 'dart:io';

import 'package:ffigen/ffigen.dart';

enum _AppleSdk { macOS, iOSSimulator }

enum _Profile { full, lean }

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.repoRoot,
    required this.workDir,
    required this.keepWorkDir,
    required this.targets,
  });

  final Directory repoRoot;
  final Directory workDir;
  final bool keepWorkDir;
  final List<String> targets;
}

final class _FrameworkSpec {
  const _FrameworkSpec({
    required this.key,
    required this.packageDir,
    required this.packageName,
    required this.framework,
    required this.umbrellaHeader,
    required this.generatedBase,
    required this.sdk,
    required this.sampleType,
    this.copyTargetAction = false,
    this.includeFlutterDeps = false,
  });

  final String key;
  final String packageDir;
  final String packageName;
  final String framework;
  final String umbrellaHeader;
  final String generatedBase;
  final _AppleSdk sdk;
  final String sampleType;
  final bool copyTargetAction;
  final bool includeFlutterDeps;
}

final class _Scenario {
  const _Scenario({
    required this.spec,
    required this.profile,
    required this.packageDir,
    required this.packageName,
    required this.bindingFile,
  });

  final _FrameworkSpec spec;
  final _Profile profile;
  final Directory packageDir;
  final String packageName;
  final File bindingFile;
}

final class _ScenarioResult {
  const _ScenarioResult({
    required this.scenario,
    required this.generatedBytes,
    required this.generatedLines,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
    required this.kernelMs,
    required this.kernelMaxRssBytes,
  });

  final _Scenario scenario;
  final int generatedBytes;
  final int generatedLines;
  final int analyzeMs;
  final int analyzeMaxRssBytes;
  final int kernelMs;
  final int kernelMaxRssBytes;
}

const _frameworks = <String, _FrameworkSpec>{
  'foundation': _FrameworkSpec(
    key: 'foundation',
    packageDir: 'objc-foundation',
    packageName: 'objc_foundation',
    framework: 'Foundation',
    umbrellaHeader: 'Foundation.h',
    generatedBase: 'foundation',
    sdk: _AppleSdk.macOS,
    sampleType: 'NSAppleScript',
  ),
  'appkit': _FrameworkSpec(
    key: 'appkit',
    packageDir: 'objc-appkit',
    packageName: 'objc_appkit',
    framework: 'AppKit',
    umbrellaHeader: 'AppKit.h',
    generatedBase: 'appkit',
    sdk: _AppleSdk.macOS,
    sampleType: 'NSViewController',
    copyTargetAction: true,
    includeFlutterDeps: true,
  ),
  'uikit': _FrameworkSpec(
    key: 'uikit',
    packageDir: 'objc-uikit',
    packageName: 'objc_uikit',
    framework: 'UIKit',
    umbrellaHeader: 'UIKit.h',
    generatedBase: 'uikit',
    sdk: _AppleSdk.iOSSimulator,
    sampleType: 'UIViewController',
    includeFlutterDeps: true,
  ),
  'metal': _FrameworkSpec(
    key: 'metal',
    packageDir: 'objc-metal',
    packageName: 'objc_metal',
    framework: 'Metal',
    umbrellaHeader: 'Metal.h',
    generatedBase: 'metal',
    sdk: _AppleSdk.macOS,
    sampleType: 'MTLCaptureManager',
  ),
  'metalkit': _FrameworkSpec(
    key: 'metalkit',
    packageDir: 'objc-metalkit',
    packageName: 'objc_metalkit',
    framework: 'MetalKit',
    umbrellaHeader: 'MetalKit.h',
    generatedBase: 'metalkit',
    sdk: _AppleSdk.macOS,
    sampleType: 'MTKView',
  ),
};

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  if (options.workDir.existsSync()) {
    options.workDir.deleteSync(recursive: true);
  }
  options.workDir.createSync(recursive: true);

  final tempPackagesDir = Directory('${options.workDir.path}/packages')
    ..createSync(recursive: true);
  final appsDir = Directory('${options.workDir.path}/apps')
    ..createSync(recursive: true);

  try {
    final results = <_ScenarioResult>[];
    for (final key in options.targets) {
      final spec = _frameworks[key]!;
      final currentPackageDir = Directory(
        '${options.repoRoot.path}/packages/${spec.packageDir}',
      );
      final currentBindingFile = File(
        '${currentPackageDir.path}/lib/src/${spec.generatedBase}_bindings.dart',
      );
      results.add(
        await _measureScenario(
          repoRoot: options.repoRoot,
          appsDir: appsDir,
          scenario: _Scenario(
            spec: spec,
            profile: _Profile.full,
            packageDir: currentPackageDir,
            packageName: spec.packageName,
            bindingFile: currentBindingFile,
          ),
        ),
      );

      final leanPackageDir = Directory('${tempPackagesDir.path}/${spec.key}');
      await _generateLeanPackage(
        repoRoot: options.repoRoot,
        spec: spec,
        packageDir: leanPackageDir,
      );
      results.add(
        await _measureScenario(
          repoRoot: options.repoRoot,
          appsDir: appsDir,
          scenario: _Scenario(
            spec: spec,
            profile: _Profile.lean,
            packageDir: leanPackageDir,
            packageName: '${spec.packageName}_lean_tmp',
            bindingFile: File(
              '${leanPackageDir.path}/lib/src/${spec.generatedBase}_bindings.dart',
            ),
          ),
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
  final targets = <String>[];

  for (final arg in args) {
    if (arg == '--keep-workdir') {
      keepWorkDir = true;
      continue;
    }
    if (arg == '--help' || arg == '-h') {
      stdout.writeln('''
Usage: dart run tool/benchmark_objc_profiles.dart [--keep-workdir] [targets...]

Targets:
  ${_frameworks.keys.join(', ')}
''');
      exit(0);
    }
    final key = arg.toLowerCase();
    if (!_frameworks.containsKey(key)) {
      stderr.writeln(
        'Unknown target "$arg". Valid targets: ${_frameworks.keys.join(', ')}',
      );
      exit(64);
    }
    targets.add(key);
  }

  return BenchmarkOptions(
    repoRoot: repoRoot,
    workDir: Directory(
      '${Directory.systemTemp.path}/dart_objc_profile_benchmarks',
    ),
    keepWorkDir: keepWorkDir,
    targets: targets.isEmpty
        ? _frameworks.keys.toList(growable: false)
        : targets,
  );
}

Future<void> _generateLeanPackage({
  required Directory repoRoot,
  required _FrameworkSpec spec,
  required Directory packageDir,
}) async {
  packageDir.createSync(recursive: true);
  Directory('${packageDir.path}/lib/src').createSync(recursive: true);
  Directory('${packageDir.path}/native').createSync(recursive: true);

  final packageName = '${spec.packageName}_lean_tmp';
  await _writePackageScaffold(
    repoRoot: repoRoot,
    spec: spec,
    packageDir: packageDir,
    packageName: packageName,
  );

  if (spec.copyTargetAction) {
    File(
      '${repoRoot.path}/packages/${spec.packageDir}/lib/src/target_action.dart',
    ).copySync('${packageDir.path}/lib/src/target_action.dart');
  }

  final sdkPath = _sdkPathFor(spec.sdk);
  final generator = FfiGenerator(
    headers: Headers(
      entryPoints: [
        Uri.file(
          '$sdkPath/System/Library/Frameworks/${spec.framework}.framework/Headers/${spec.umbrellaHeader}',
        ),
      ],
      compilerOptions: [
        '-isysroot',
        sdkPath,
        '-F$sdkPath/System/Library/Frameworks',
      ],
      ignoreSourceErrors: true,
    ),
    objectiveC: _leanObjectiveCConfig(spec),
    output: Output(
      dartFile: Uri.file(
        '${packageDir.path}/lib/src/${spec.generatedBase}_bindings.dart',
      ),
      objectiveCFile: Uri.file(
        '${packageDir.path}/native/${spec.generatedBase}_bindings.m',
      ),
      commentType: const CommentType.none(),
      preamble: '// Lean ${spec.framework} benchmark package.',
      style: const NativeExternalBindings(),
    ),
  );
  generator.generate();
  await _runChecked(
    workingDirectory: packageDir.path,
    arguments: const ['pub', 'get'],
  );
}

ObjectiveC _leanObjectiveCConfig(_FrameworkSpec spec) {
  if (spec.key == 'foundation' || spec.key == 'appkit') {
    return _fullObjectiveCConfig(spec);
  }
  if (spec.key == 'metal') {
    bool includeMtl(Declaration declaration) =>
        declaration.originalName.startsWith('MTL');
    return ObjectiveC(
      interfaces: Interfaces(include: includeMtl, includeTransitive: false),
      protocols: Protocols(include: includeMtl, includeTransitive: false),
      categories: Categories(include: includeMtl, includeTransitive: false),
    );
  }
  if (spec.key == 'metalkit') {
    bool includeMtk(Declaration declaration) =>
        declaration.originalName.startsWith('MTK');
    return ObjectiveC(
      interfaces: Interfaces(include: includeMtk, includeTransitive: false),
      protocols: Protocols(include: includeMtk, includeTransitive: false),
      categories: Categories(include: includeMtk, includeTransitive: false),
    );
  }
  if (spec.key == 'uikit') {
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

    return ObjectiveC(
      interfaces: Interfaces(
        include: includeUi,
        includeTransitive: false,
        includeSubclassHelpers: includeSubclassHelpers,
        includeMember: includeMember,
      ),
      protocols: Protocols(include: includeUi, includeTransitive: false),
      categories: Categories(include: includeUi, includeTransitive: false),
    );
  }
  throw StateError('Unsupported lean benchmark target: ${spec.key}');
}

ObjectiveC _fullObjectiveCConfig(_FrameworkSpec spec) {
  if (spec.key == 'metalkit') {
    bool includeMtk(Declaration declaration) =>
        declaration.originalName.startsWith('MTK');
    return ObjectiveC(
      interfaces: Interfaces(include: includeMtk, includeTransitive: false),
      protocols: Protocols(include: includeMtk, includeTransitive: false),
      categories: Categories(include: includeMtk, includeTransitive: false),
    );
  }
  if (spec.key == 'appkit') {
    bool includeSubclassHelpers(Declaration declaration) =>
        declaration.originalName == 'NSViewController';
    return ObjectiveC(
      interfaces: Interfaces(
        include: Declarations.includeAll,
        includeTransitive: true,
        includeSubclassHelpers: includeSubclassHelpers,
      ),
      protocols: Protocols(
        include: Declarations.includeAll,
        includeTransitive: true,
      ),
      categories: Categories(
        include: Declarations.includeAll,
        includeTransitive: true,
      ),
    );
  }
  if (spec.key == 'uikit') {
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

    return ObjectiveC(
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
    );
  }
  return const ObjectiveC(
    interfaces: Interfaces(
      include: Declarations.includeAll,
      includeTransitive: true,
    ),
    protocols: Protocols(
      include: Declarations.includeAll,
      includeTransitive: true,
    ),
    categories: Categories(
      include: Declarations.includeAll,
      includeTransitive: true,
    ),
  );
}

Future<void> _writePackageScaffold({
  required Directory repoRoot,
  required _FrameworkSpec spec,
  required Directory packageDir,
  required String packageName,
}) async {
  final extraDeps = spec.includeFlutterDeps
      ? '''
  code_assets: ^1.0.0
  hooks: ^1.0.0
  logging: ^1.3.0
  native_toolchain_c: ^0.17.4
  flutter:
    sdk: flutter
'''
      : '';
  final overrides = spec.includeFlutterDeps
      ? '''
  code_assets:
    path: ${repoRoot.path}/ffigen/pkgs/code_assets
  hooks:
    path: ${repoRoot.path}/ffigen/pkgs/hooks
  native_toolchain_c:
    path: ${repoRoot.path}/ffigen/pkgs/native_toolchain_c
'''
      : '';

  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: $packageName
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
$extraDeps  ffi: ^2.2.0
  objective_c:
    path: ${repoRoot.path}/ffigen/pkgs/objective_c

dependency_overrides:
$overrides  ffi:
    path: ${repoRoot.path}/ffigen/pkgs/ffi
''');

  final libraryExports = StringBuffer()
    ..writeln("export 'src/${spec.generatedBase}_bindings.dart';");
  if (spec.copyTargetAction) {
    libraryExports.writeln("export 'src/target_action.dart';");
  }
  File(
    '${packageDir.path}/lib/$packageName.dart',
  ).writeAsStringSync(libraryExports.toString());
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
    scenario: scenario,
    generatedBytes: scenario.bindingFile.lengthSync(),
    generatedLines: '\n'.allMatches(bindingText).length + 1,
    analyzeMs: analyze.elapsedMs,
    analyzeMaxRssBytes: analyze.maxRssBytes,
    kernelMs: kernel.elapsedMs,
    kernelMaxRssBytes: kernel.maxRssBytes,
  );
}

Future<Directory> _prepareHarness({
  required Directory repoRoot,
  required Directory appsDir,
  required _Scenario scenario,
}) async {
  final appDir = Directory(
    '${appsDir.path}/${scenario.spec.key}_${scenario.profile.name}',
  );
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
  Directory('${appDir.path}/bin').createSync(recursive: true);
  Directory('${appDir.path}/build').createSync(recursive: true);

  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: ${scenario.spec.key}_${scenario.profile.name}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  ${scenario.packageName}:
    path: ${scenario.packageDir.path}

dependency_overrides:
  objective_c:
    path: ${repoRoot.path}/ffigen/pkgs/objective_c
  ffi:
    path: ${repoRoot.path}/ffigen/pkgs/ffi
''');

  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
import 'package:${scenario.packageName}/${scenario.packageName}.dart' as objc;

void main() {
  objc.${scenario.spec.sampleType}? value;
  print(value);
}
''');

  await _runChecked(
    workingDirectory: appDir.path,
    arguments: const ['pub', 'get'],
  );
  return appDir;
}

String _sdkPathFor(_AppleSdk sdk) {
  final sdkName = switch (sdk) {
    _AppleSdk.macOS => 'macosx',
    _AppleSdk.iOSSimulator => 'iphonesimulator',
  };
  final result = Process.runSync('xcrun', [
    '--show-sdk-path',
    '--sdk',
    sdkName,
  ]);
  if (result.exitCode != 0) {
    throw ProcessException(
      'xcrun',
      ['--show-sdk-path', '--sdk', sdkName],
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
    'framework   profile  gen_size   gen_lines  analyze_ms  analyze_rss  kernel_ms  kernel_rss',
  );
  for (final result in results) {
    stdout.writeln(
      '${result.scenario.spec.key.padRight(11)} '
      '${result.scenario.profile.name.padRight(7)} '
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
