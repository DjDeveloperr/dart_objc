import 'dart:convert';
import 'dart:io';

const _controlSource = r'''
import 'package:flutter/material.dart';

Widget buildControl() {
  return const MaterialApp(home: Text('Hello World'));
}
''';

const _appKitSource = r'''
import 'package:flutter/material.dart';
import 'package:objc_appkit/objc_appkit.dart';

Widget buildControlWithAppKit() {
  final NSView view = NSView.alloc().init();
  return MaterialApp(home: Text('Native view: $view'));
}
''';

Future<void> main(List<String> arguments) async {
  final runs = _readRuns(arguments);
  final root = Directory.current.absolute;
  final packageConfig = File(
    '${root.path}/examples/flutter/.dart_tool/package_config.json',
  );
  if (!packageConfig.existsSync()) {
    stderr.writeln(
      'Missing ${packageConfig.path}. Run `flutter pub get` in '
      '`examples/flutter` first.',
    );
    exitCode = 66;
    return;
  }
  if (!File('/usr/bin/time').existsSync()) {
    stderr.writeln('This benchmark requires the macOS /usr/bin/time tool.');
    exitCode = 69;
    return;
  }

  final workspace = Directory.systemTemp.createTempSync(
    'dart_objc_appkit_analyzer_',
  );
  try {
    final scenarios = <_Scenario>[
      _Scenario('control', _controlSource),
      _Scenario('appkit', _appKitSource),
    ];
    final measurements = <String, List<_Measurement>>{
      for (final scenario in scenarios) scenario.name: [],
    };

    for (var run = 1; run <= runs; run++) {
      for (final scenario in scenarios) {
        final sourceFile = File('${workspace.path}/${scenario.name}.dart')
          ..writeAsStringSync(scenario.source);
        final cache = Directory.systemTemp.createTempSync(
          'dart_objc_${scenario.name}_cache_',
        );
        try {
          final measurement = await _measure(
            sourceFile: sourceFile,
            packageConfig: packageConfig,
            cache: cache,
          );
          measurements[scenario.name]!.add(measurement);
          stdout.writeln(
            jsonEncode({
              'scenario': scenario.name,
              'run': run,
              'peakRssBytes': measurement.peakRssBytes,
              'wallSeconds': measurement.wallSeconds,
            }),
          );
        } finally {
          cache.deleteSync(recursive: true);
        }
      }
    }

    final controlRss = _medianInt(
      measurements['control']!.map((value) => value.peakRssBytes).toList(),
    );
    final appKitRss = _medianInt(
      measurements['appkit']!.map((value) => value.peakRssBytes).toList(),
    );
    final controlSeconds = _medianDouble(
      measurements['control']!.map((value) => value.wallSeconds).toList(),
    );
    final appKitSeconds = _medianDouble(
      measurements['appkit']!.map((value) => value.wallSeconds).toList(),
    );

    stdout.writeln(
      jsonEncode({
        'summary': {
          'runs': runs,
          'controlPeakRssBytes': controlRss,
          'appKitPeakRssBytes': appKitRss,
          'appKitPeakRssDeltaBytes': appKitRss - controlRss,
          'controlWallSeconds': controlSeconds,
          'appKitWallSeconds': appKitSeconds,
          'appKitWallDeltaSeconds': appKitSeconds - controlSeconds,
        },
      }),
    );
  } finally {
    workspace.deleteSync(recursive: true);
  }
}

int _readRuns(List<String> arguments) {
  if (arguments.contains('--help')) {
    stdout.writeln(
      'Usage: dart run tool/benchmark_appkit_analyzer.dart [--runs=N]',
    );
    exit(0);
  }
  final option = arguments
      .where((value) => value.startsWith('--runs='))
      .firstOrNull;
  final runs = option == null
      ? 3
      : int.tryParse(option.substring('--runs='.length));
  if (runs == null || runs < 1) {
    stderr.writeln('--runs must be a positive integer.');
    exit(64);
  }
  return runs;
}

Future<_Measurement> _measure({
  required File sourceFile,
  required File packageConfig,
  required Directory cache,
}) async {
  final result = await Process.run('/usr/bin/time', [
    '-l',
    Platform.resolvedExecutable,
    'analyze',
    '--format=json',
    '--memory',
    '--packages=${packageConfig.absolute.path}',
    '--cache=${cache.absolute.path}',
    sourceFile.absolute.path,
  ]);
  if (result.exitCode != 0) {
    throw ProcessException(
      '/usr/bin/time',
      const [],
      '${result.stdout}\n${result.stderr}',
      result.exitCode,
    );
  }

  final timing = result.stderr as String;
  final rssMatch = RegExp(
    r'^\s*(\d+)\s+maximum resident set size$',
    multiLine: true,
  ).firstMatch(timing);
  final wallMatch = RegExp(
    r'^\s*([0-9.]+)\s+real\s',
    multiLine: true,
  ).firstMatch(timing);
  if (rssMatch == null || wallMatch == null) {
    throw FormatException('Could not parse /usr/bin/time output', timing);
  }

  return _Measurement(
    peakRssBytes: int.parse(rssMatch.group(1)!),
    wallSeconds: double.parse(wallMatch.group(1)!),
  );
}

int _medianInt(List<int> values) {
  values.sort();
  final middle = values.length ~/ 2;
  return values.length.isOdd
      ? values[middle]
      : (values[middle - 1] + values[middle]) ~/ 2;
}

double _medianDouble(List<double> values) {
  values.sort();
  final middle = values.length ~/ 2;
  return values.length.isOdd
      ? values[middle]
      : (values[middle - 1] + values[middle]) / 2;
}

class _Scenario {
  const _Scenario(this.name, this.source);

  final String name;
  final String source;
}

class _Measurement {
  const _Measurement({required this.peakRssBytes, required this.wallSeconds});

  final int peakRssBytes;
  final double wallSeconds;
}
