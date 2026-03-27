import 'dart:io';

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
    required this.packageName,
    required this.libraryImport,
    required this.symbol,
  });

  final String key;
  final String packageName;
  final String libraryImport;
  final String symbol;
}

final class _ScenarioResult {
  const _ScenarioResult({
    required this.scenario,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
  });

  final _Scenario scenario;
  final int analyzeMs;
  final int analyzeMaxRssBytes;
}

const _scenarios = <_Scenario>[
  _Scenario(
    key: 'uikit_root',
    packageName: 'objc_uikit',
    libraryImport: "import 'package:objc_uikit/objc_uikit.dart' as pkg;",
    symbol: 'pkg.UIViewController',
  ),
  _Scenario(
    key: 'uikit_root_show',
    packageName: 'objc_uikit',
    libraryImport:
        "import 'package:objc_uikit/objc_uikit.dart' show UIViewController;",
    symbol: 'UIViewController',
  ),
  _Scenario(
    key: 'uikit_flutter_views',
    packageName: 'objc_uikit',
    libraryImport:
        "import 'package:objc_uikit/flutter_views.dart' show ObjCUiKitHostView;",
    symbol: 'ObjCUiKitHostView',
  ),
  _Scenario(
    key: 'appkit_root',
    packageName: 'objc_appkit',
    libraryImport: "import 'package:objc_appkit/objc_appkit.dart' as pkg;",
    symbol: 'pkg.NSViewController',
  ),
  _Scenario(
    key: 'appkit_root_show',
    packageName: 'objc_appkit',
    libraryImport:
        "import 'package:objc_appkit/objc_appkit.dart' show NSViewController;",
    symbol: 'NSViewController',
  ),
  _Scenario(
    key: 'appkit_target_action',
    packageName: 'objc_appkit',
    libraryImport:
        "import 'package:objc_appkit/objc_appkit.dart' show NSButtonTargetAction;",
    symbol: 'NSButtonTargetAction',
  ),
  _Scenario(
    key: 'appkit_flutter_views',
    packageName: 'objc_appkit',
    libraryImport:
        "import 'package:objc_appkit/flutter_views.dart' show ObjCAppKitHostView;",
    symbol: 'ObjCAppKitHostView',
  ),
];

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  if (options.workDir.existsSync()) {
    options.workDir.deleteSync(recursive: true);
  }
  options.workDir.createSync(recursive: true);

  try {
    final results = <_ScenarioResult>[];
    for (final scenario in _scenarios) {
      final appDir = await _prepareHarness(
        repoRoot: options.repoRoot,
        workDir: options.workDir,
        scenario: scenario,
      );
      final analyze = await _timeDartCommand(
        workingDirectory: appDir.path,
        arguments: const ['analyze', 'bin/main.dart'],
      );
      results.add(
        _ScenarioResult(
          scenario: scenario,
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
  for (final arg in args) {
    switch (arg) {
      case '--keep-workdir':
        keepWorkDir = true;
      case '--help':
      case '-h':
        stdout.writeln(
          'Usage: dart run tool/benchmark_consumer_imports.dart [--keep-workdir]',
        );
        exit(0);
      default:
        stderr.writeln('Unknown argument: $arg');
        exit(64);
    }
  }

  return BenchmarkOptions(
    repoRoot: Directory.current.absolute,
    workDir: Directory(
      '${Directory.systemTemp.path}/dart_objc_import_benchmarks',
    ),
    keepWorkDir: keepWorkDir,
  );
}

Future<Directory> _prepareHarness({
  required Directory repoRoot,
  required Directory workDir,
  required _Scenario scenario,
}) async {
  final appDir = Directory('${workDir.path}/${scenario.key}');
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
  Directory('${appDir.path}/bin').createSync(recursive: true);
  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: ${scenario.key}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  ${scenario.packageName}:
    path: ${repoRoot.path}/packages/${scenario.packageName.replaceAll('_', '-')}

dependency_overrides:
  objective_c:
    path: ${repoRoot.path}/ffigen/pkgs/objective_c
  ffi:
    path: ${repoRoot.path}/ffigen/pkgs/ffi
''');
  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
${scenario.libraryImport}

void main() {
  ${scenario.symbol}? value;
  print(value);
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
  stdout.writeln('scenario               analyze_ms  analyze_rss');
  for (final result in results) {
    stdout.writeln(
      '${result.scenario.key.padRight(22)} '
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
