import 'dart:convert';
import 'dart:io';

enum BenchmarkPhase { analyze, kernel, cli }

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.repoRoot,
    required this.outputDir,
    required this.runs,
    required this.warmups,
    required this.recreate,
  });

  final Directory repoRoot;
  final Directory outputDir;
  final int runs;
  final int warmups;
  final bool recreate;
}

final class Scenario {
  const Scenario({
    required this.key,
    required this.description,
    required this.packagePaths,
    required this.generatedBindingFiles,
    required this.source,
  });

  final String key;
  final String description;
  final Map<String, String> packagePaths;
  final List<String> generatedBindingFiles;
  final String source;
}

final class SourceFootprint {
  const SourceFootprint({required this.bytes, required this.lines});

  final int bytes;
  final int lines;

  Map<String, Object> toJson() => {'bytes': bytes, 'lines': lines};
}

final class PhaseResult {
  const PhaseResult({
    required this.phase,
    required this.runsMs,
    required this.outputSizeBytes,
    required this.outputPath,
  });

  final BenchmarkPhase phase;
  final List<int> runsMs;
  final int outputSizeBytes;
  final String outputPath;

  double get meanMs =>
      runsMs.isEmpty ? 0 : runsMs.reduce((a, b) => a + b) / runsMs.length;

  int get minMs => runsMs.reduce((a, b) => a < b ? a : b);

  int get maxMs => runsMs.reduce((a, b) => a > b ? a : b);

  Map<String, Object> toJson() => {
    'phase': phase.name,
    'runs_ms': runsMs,
    'mean_ms': meanMs,
    'min_ms': minMs,
    'max_ms': maxMs,
    'output_size_bytes': outputSizeBytes,
    'output_path': outputPath,
  };
}

final class ScenarioResult {
  const ScenarioResult({
    required this.scenario,
    required this.sourceFootprint,
    required this.phaseResults,
  });

  final Scenario scenario;
  final SourceFootprint sourceFootprint;
  final Map<BenchmarkPhase, PhaseResult> phaseResults;

  Map<String, Object> toJson() => {
    'scenario': scenario.key,
    'description': scenario.description,
    'source_footprint': sourceFootprint.toJson(),
    'phases': {
      for (final entry in phaseResults.entries)
        entry.key.name: entry.value.toJson(),
    },
  };
}

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  if (options.recreate && options.outputDir.existsSync()) {
    options.outputDir.deleteSync(recursive: true);
  }
  options.outputDir.createSync(recursive: true);

  final scenarios = _scenarios(options.repoRoot);
  final results = <ScenarioResult>[];

  for (final scenario in scenarios) {
    stdout.writeln('==> preparing ${scenario.key}');
    final projectDir = Directory('${options.outputDir.path}/${scenario.key}');
    await _prepareProject(
      repoRoot: options.repoRoot,
      scenario: scenario,
      projectDir: projectDir,
    );

    stdout.writeln('==> benchmarking ${scenario.key}');
    results.add(
      await _benchmarkScenario(
        scenario: scenario,
        projectDir: projectDir,
        options: options,
      ),
    );
  }

  final jsonPath = File('${options.outputDir.path}/report.json');
  final markdownPath = File('${options.outputDir.path}/report.md');
  final reportJson = {
    'generated_at': DateTime.now().toUtc().toIso8601String(),
    'repo_root': options.repoRoot.path,
    'runs': options.runs,
    'warmups': options.warmups,
    'results': results.map((r) => r.toJson()).toList(growable: false),
  };
  jsonPath.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(reportJson),
  );
  markdownPath.writeAsStringSync(_renderMarkdown(results));

  stdout.writeln('Wrote ${jsonPath.path}');
  stdout.writeln('Wrote ${markdownPath.path}');
}

BenchmarkOptions _parseArgs(List<String> args) {
  final repoRoot = Directory.current.absolute;
  var outputDir = Directory('${repoRoot.path}/build/proofs/framework_scale');
  var runs = 3;
  var warmups = 1;
  var recreate = true;

  for (final arg in args) {
    if (arg.startsWith('--output-dir=')) {
      outputDir = Directory(arg.substring('--output-dir='.length)).absolute;
      continue;
    }
    if (arg.startsWith('--runs=')) {
      runs = int.parse(arg.substring('--runs='.length));
      continue;
    }
    if (arg.startsWith('--warmups=')) {
      warmups = int.parse(arg.substring('--warmups='.length));
      continue;
    }
    if (arg == '--no-recreate') {
      recreate = false;
      continue;
    }
    if (arg == '--help') {
      stdout.writeln(
        'Usage: dart run tool/prove_framework_scale.dart '
        '[--runs=3] [--warmups=1] [--output-dir=PATH] [--no-recreate]',
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
    outputDir: outputDir,
    runs: runs,
    warmups: warmups,
    recreate: recreate,
  );
}

List<Scenario> _scenarios(Directory repoRoot) => [
  Scenario(
    key: 'foundation_only',
    description:
        'Imports only the minimal Objective-C runtime and Foundation bindings.',
    packagePaths: {
      'objc_foundation': '${repoRoot.path}/packages/objc-foundation',
      'objective_c': '${repoRoot.path}/ffigen/pkgs/objective_c',
      'ffi': '${repoRoot.path}/ffigen/pkgs/ffi',
    },
    generatedBindingFiles: [
      '${repoRoot.path}/packages/objc-foundation/lib/src/foundation_bindings.dart',
      '${repoRoot.path}/ffigen/pkgs/objective_c/lib/src/objective_c_bindings_generated.dart',
    ],
    source: '''
import 'dart:io';

import 'package:objc_foundation/objc_foundation.dart' as foundation;
import 'package:objective_c/objective_c.dart' as objc;

const bool _keepAllGeneratedTypes = bool.fromEnvironment('KEEP_ALL_GENERATED_TYPES');

List<Type> _touchGeneratedTypes() => const <Type>[
  foundation.NSAppleEventDescriptor,
  objc.NSString,
];

void main() {
  if (_keepAllGeneratedTypes) {
    stdout.writeln(_touchGeneratedTypes().length);
    return;
  }
  stdout.writeln('foundation-only');
}
''',
  ),
  Scenario(
    key: 'full_frameworks_available',
    description:
        'Keeps the same Foundation-only imports while all larger generated framework packages are present as dependencies.',
    packagePaths: {
      'objc_foundation': '${repoRoot.path}/packages/objc-foundation',
      'objc_metal': '${repoRoot.path}/packages/objc-metal',
      'objc_metalkit': '${repoRoot.path}/packages/objc-metalkit',
      'objective_c': '${repoRoot.path}/ffigen/pkgs/objective_c',
      'ffi': '${repoRoot.path}/ffigen/pkgs/ffi',
    },
    generatedBindingFiles: [
      '${repoRoot.path}/packages/objc-foundation/lib/src/foundation_bindings.dart',
      '${repoRoot.path}/packages/objc-metal/lib/src/metal_bindings.dart',
      '${repoRoot.path}/packages/objc-metalkit/lib/src/metalkit_bindings.dart',
      '${repoRoot.path}/ffigen/pkgs/objective_c/lib/src/objective_c_bindings_generated.dart',
    ],
    source: '''
import 'dart:io';

import 'package:objc_foundation/objc_foundation.dart' as foundation;
import 'package:objective_c/objective_c.dart' as objc;

const bool _keepAllGeneratedTypes = bool.fromEnvironment('KEEP_ALL_GENERATED_TYPES');

List<Type> _touchGeneratedTypes() => const <Type>[
  foundation.NSAppleEventDescriptor,
  objc.NSString,
];

void main() {
  if (_keepAllGeneratedTypes) {
    stdout.writeln(_touchGeneratedTypes().length);
    return;
  }
  stdout.writeln('full-frameworks-available');
}
''',
  ),
  Scenario(
    key: 'full_frameworks_imported',
    description:
        'Imports Foundation, Metal, and MetalKit bindings while keeping the runtime surface identical.',
    packagePaths: {
      'objc_foundation': '${repoRoot.path}/packages/objc-foundation',
      'objc_metal': '${repoRoot.path}/packages/objc-metal',
      'objc_metalkit': '${repoRoot.path}/packages/objc-metalkit',
      'objective_c': '${repoRoot.path}/ffigen/pkgs/objective_c',
      'ffi': '${repoRoot.path}/ffigen/pkgs/ffi',
    },
    generatedBindingFiles: [
      '${repoRoot.path}/packages/objc-foundation/lib/src/foundation_bindings.dart',
      '${repoRoot.path}/packages/objc-metal/lib/src/metal_bindings.dart',
      '${repoRoot.path}/packages/objc-metalkit/lib/src/metalkit_bindings.dart',
      '${repoRoot.path}/ffigen/pkgs/objective_c/lib/src/objective_c_bindings_generated.dart',
    ],
    source: '''
import 'dart:io';

import 'package:objc_foundation/objc_foundation.dart' as foundation;
import 'package:objc_metal/objc_metal.dart' as metal;
import 'package:objc_metalkit/objc_metalkit.dart' as metalkit;
import 'package:objective_c/objective_c.dart' as objc;

const bool _keepAllGeneratedTypes = bool.fromEnvironment('KEEP_ALL_GENERATED_TYPES');

List<Type> _touchGeneratedTypes() => const <Type>[
  foundation.NSAppleEventDescriptor,
  objc.NSString,
  metal.MTL4ArchiveSpec,
  metalkit.MTKViewDelegateSpec,
];

void main() {
  if (_keepAllGeneratedTypes) {
    stdout.writeln(_touchGeneratedTypes().length);
    return;
  }
  stdout.writeln('full-frameworks-imported');
}
''',
  ),
];

Future<void> _prepareProject({
  required Directory repoRoot,
  required Scenario scenario,
  required Directory projectDir,
}) async {
  if (projectDir.existsSync()) {
    projectDir.deleteSync(recursive: true);
  }
  Directory('${projectDir.path}/bin').createSync(recursive: true);
  Directory('${projectDir.path}/build').createSync(recursive: true);

  File(
    '${projectDir.path}/pubspec.yaml',
  ).writeAsStringSync(_pubspecFor(scenario));
  File('${projectDir.path}/analysis_options.yaml').writeAsStringSync('''
include: package:lints/recommended.yaml
''');
  File('${projectDir.path}/bin/main.dart').writeAsStringSync(scenario.source);

  await _runChecked(
    executable: Platform.environment['DART_BIN'] ?? 'dart',
    arguments: ['pub', 'get'],
    workingDirectory: projectDir.path,
  );
}

String _pubspecFor(Scenario scenario) {
  final buffer = StringBuffer()
    ..writeln('name: ${scenario.key}')
    ..writeln('publish_to: none')
    ..writeln('environment:')
    ..writeln("  sdk: ^3.11.0")
    ..writeln('dependencies:');

  final dependencies = Map<String, String>.from(scenario.packagePaths)
    ..remove('objective_c')
    ..remove('ffi');
  for (final entry in dependencies.entries) {
    buffer
      ..writeln('  ${entry.key}:')
      ..writeln("    path: '${entry.value}'");
  }

  buffer.writeln('dependency_overrides:');
  buffer
    ..writeln('  objective_c:')
    ..writeln("    path: '${scenario.packagePaths['objective_c']}'")
    ..writeln('  ffi:')
    ..writeln("    path: '${scenario.packagePaths['ffi']}'")
    ..writeln('dev_dependencies:')
    ..writeln('  lints: ^6.0.0');

  return buffer.toString();
}

Future<ScenarioResult> _benchmarkScenario({
  required Scenario scenario,
  required Directory projectDir,
  required BenchmarkOptions options,
}) async {
  final sourceFootprint = _measureSourceFootprint(
    scenario.generatedBindingFiles,
  );
  final phaseResults = <BenchmarkPhase, PhaseResult>{};
  final dart = Platform.environment['DART_BIN'] ?? 'dart';

  final phases = <BenchmarkPhase, List<String>>{
    BenchmarkPhase.analyze: ['analyze', 'bin/main.dart'],
    BenchmarkPhase.kernel: [
      'compile',
      'kernel',
      'bin/main.dart',
      '-o',
      'build/app.dill',
    ],
    BenchmarkPhase.cli: [
      'build',
      'cli',
      '--target=bin/main.dart',
      '--output=build/cli',
    ],
  };

  for (final entry in phases.entries) {
    final phase = entry.key;
    final args = entry.value;
    final outputPath = switch (phase) {
      BenchmarkPhase.analyze => '${projectDir.path}/analysis.txt',
      BenchmarkPhase.kernel => '${projectDir.path}/build/app.dill',
      BenchmarkPhase.cli => '${projectDir.path}/build/cli/bundle',
    };

    for (var i = 0; i < options.warmups; i++) {
      _clearPhaseOutput(phase, projectDir);
      await _runChecked(
        executable: dart,
        arguments: args,
        workingDirectory: projectDir.path,
      );
    }

    final durations = <int>[];
    for (var i = 0; i < options.runs; i++) {
      _clearPhaseOutput(phase, projectDir);
      final stopwatch = Stopwatch()..start();
      await _runChecked(
        executable: dart,
        arguments: args,
        workingDirectory: projectDir.path,
      );
      stopwatch.stop();
      durations.add(stopwatch.elapsedMilliseconds);
    }

    final outputSizeBytes = switch (phase) {
      BenchmarkPhase.analyze => 0,
      BenchmarkPhase.kernel =>
        File(outputPath).existsSync() ? File(outputPath).lengthSync() : 0,
      BenchmarkPhase.cli =>
        Directory(outputPath).existsSync()
            ? _directorySize(Directory(outputPath))
            : 0,
    };

    phaseResults[phase] = PhaseResult(
      phase: phase,
      runsMs: durations,
      outputSizeBytes: outputSizeBytes,
      outputPath: outputPath,
    );
  }

  return ScenarioResult(
    scenario: scenario,
    sourceFootprint: sourceFootprint,
    phaseResults: phaseResults,
  );
}

void _clearPhaseOutput(BenchmarkPhase phase, Directory projectDir) {
  Directory('${projectDir.path}/build').createSync(recursive: true);
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

int _directorySize(Directory directory) {
  var bytes = 0;
  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File) {
      bytes += entity.lengthSync();
    }
  }
  return bytes;
}

SourceFootprint _measureSourceFootprint(List<String> files) {
  var bytes = 0;
  var lines = 0;
  for (final path in files) {
    final file = File(path);
    if (!file.existsSync()) {
      throw StateError('Missing generated bindings file: $path');
    }
    final content = file.readAsStringSync();
    bytes += file.lengthSync();
    lines += const LineSplitter().convert(content).length;
  }
  return SourceFootprint(bytes: bytes, lines: lines);
}

Future<void> _runChecked({
  required String executable,
  required List<String> arguments,
  required String workingDirectory,
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
}

String _renderMarkdown(List<ScenarioResult> results) {
  final baseline = results.firstWhere(
    (r) => r.scenario.key == 'foundation_only',
  );
  final available = results.firstWhere(
    (r) => r.scenario.key == 'full_frameworks_available',
  );
  final imported = results.firstWhere(
    (r) => r.scenario.key == 'full_frameworks_imported',
  );

  final lines = <String>[
    '# Framework Scale Proof',
    '',
    'This report compares a minimal Objective-C binding app against the same app with much larger generated framework bindings imported but left unreachable at runtime.',
    '',
    '| Scenario | Generated source bytes | Generated source lines | Analyze mean (ms) | Kernel mean (ms) | Kernel size (bytes) | CLI bundle mean (ms) | CLI bundle size (bytes) |',
    '| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |',
    for (final result in results)
      '| ${result.scenario.key} | ${result.sourceFootprint.bytes} | ${result.sourceFootprint.lines} | ${result.phaseResults[BenchmarkPhase.analyze]!.meanMs.toStringAsFixed(1)} | ${result.phaseResults[BenchmarkPhase.kernel]!.meanMs.toStringAsFixed(1)} | ${result.phaseResults[BenchmarkPhase.kernel]!.outputSizeBytes} | ${result.phaseResults[BenchmarkPhase.cli]!.meanMs.toStringAsFixed(1)} | ${result.phaseResults[BenchmarkPhase.cli]!.outputSizeBytes} |',
    '',
    '## Delta vs baseline: full frameworks available, same small import surface',
    '',
    '| Metric | Delta | Percent |',
    '| --- | ---: | ---: |',
    _deltaLine(
      'Generated source bytes',
      baseline.sourceFootprint.bytes,
      available.sourceFootprint.bytes,
    ),
    _deltaLine(
      'Generated source lines',
      baseline.sourceFootprint.lines,
      available.sourceFootprint.lines,
    ),
    _deltaLine(
      'Analyze mean (ms)',
      baseline.phaseResults[BenchmarkPhase.analyze]!.meanMs,
      available.phaseResults[BenchmarkPhase.analyze]!.meanMs,
    ),
    _deltaLine(
      'Kernel mean (ms)',
      baseline.phaseResults[BenchmarkPhase.kernel]!.meanMs,
      available.phaseResults[BenchmarkPhase.kernel]!.meanMs,
    ),
    _deltaLine(
      'Kernel size (bytes)',
      baseline.phaseResults[BenchmarkPhase.kernel]!.outputSizeBytes,
      available.phaseResults[BenchmarkPhase.kernel]!.outputSizeBytes,
    ),
    _deltaLine(
      'CLI bundle mean (ms)',
      baseline.phaseResults[BenchmarkPhase.cli]!.meanMs,
      available.phaseResults[BenchmarkPhase.cli]!.meanMs,
    ),
    _deltaLine(
      'CLI bundle size (bytes)',
      baseline.phaseResults[BenchmarkPhase.cli]!.outputSizeBytes,
      available.phaseResults[BenchmarkPhase.cli]!.outputSizeBytes,
    ),
    '',
    '## Delta vs baseline: full frameworks imported',
    '',
    '| Metric | Delta | Percent |',
    '| --- | ---: | ---: |',
    _deltaLine(
      'Generated source bytes',
      baseline.sourceFootprint.bytes,
      imported.sourceFootprint.bytes,
    ),
    _deltaLine(
      'Generated source lines',
      baseline.sourceFootprint.lines,
      imported.sourceFootprint.lines,
    ),
    _deltaLine(
      'Analyze mean (ms)',
      baseline.phaseResults[BenchmarkPhase.analyze]!.meanMs,
      imported.phaseResults[BenchmarkPhase.analyze]!.meanMs,
    ),
    _deltaLine(
      'Kernel mean (ms)',
      baseline.phaseResults[BenchmarkPhase.kernel]!.meanMs,
      imported.phaseResults[BenchmarkPhase.kernel]!.meanMs,
    ),
    _deltaLine(
      'Kernel size (bytes)',
      baseline.phaseResults[BenchmarkPhase.kernel]!.outputSizeBytes,
      imported.phaseResults[BenchmarkPhase.kernel]!.outputSizeBytes,
    ),
    _deltaLine(
      'CLI bundle mean (ms)',
      baseline.phaseResults[BenchmarkPhase.cli]!.meanMs,
      imported.phaseResults[BenchmarkPhase.cli]!.meanMs,
    ),
    _deltaLine(
      'CLI bundle size (bytes)',
      baseline.phaseResults[BenchmarkPhase.cli]!.outputSizeBytes,
      imported.phaseResults[BenchmarkPhase.cli]!.outputSizeBytes,
    ),
    '',
    '## Notes',
    '',
    '- This proof is intentionally Dart-only. `objc_appkit` and `objc_uikit` are Flutter packages, so including them would measure Flutter/Xcode build cost rather than the Dart frontend and compiler cost the comparison is about.',
    '- The `full_frameworks_available` scenario measures dependency presence only; the `full_frameworks_imported` scenario measures the upper bound once those generated libraries are actually imported.',
    '- Both larger scenarios keep their extra generated types unreachable in the runtime entrypoint so tree shaking can remove them from the final CLI bundle.',
    '- Re-run with more samples if you want tighter numbers: `./tool/prove_framework_scale.sh --runs=10 --warmups=2`',
  ];

  return '${lines.join('\n')}\n';
}

String _deltaLine(String label, num baseline, num expanded) {
  final delta = expanded - baseline;
  final percent = baseline == 0 ? 0 : (delta / baseline) * 100;
  return '| $label | ${delta.toStringAsFixed(1)} | ${percent.toStringAsFixed(2)}% |';
}
