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

final class _VariantSpec {
  const _VariantSpec({
    required this.key,
    required this.packageName,
    required this.stripImplHelpers,
  });

  final String key;
  final String packageName;
  final bool stripImplHelpers;
}

final class _VariantResult {
  const _VariantResult({
    required this.spec,
    required this.generatedBytes,
    required this.generatedLines,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
    required this.kernelMs,
    required this.kernelMaxRssBytes,
  });

  final _VariantSpec spec;
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

  final packagesDir = Directory('${options.workDir.path}/packages')
    ..createSync(recursive: true);
  final appsDir = Directory('${options.workDir.path}/apps')
    ..createSync(recursive: true);

  const variants = <_VariantSpec>[
    _VariantSpec(
      key: 'uikit_full_copy',
      packageName: 'objc_uikit_full_copy_tmp',
      stripImplHelpers: false,
    ),
    _VariantSpec(
      key: 'uikit_no_impl_helpers',
      packageName: 'objc_uikit_no_impl_helpers_tmp',
      stripImplHelpers: true,
    ),
  ];

  try {
    final results = <_VariantResult>[];
    for (final variant in variants) {
      final packageDir = Directory(
        '${packagesDir.path}/${variant.packageName}',
      );
      await _writePackageVariant(
        repoRoot: options.repoRoot,
        packageDir: packageDir,
        spec: variant,
      );
      results.add(
        await _benchmarkVariant(
          repoRoot: options.repoRoot,
          appsDir: appsDir,
          packageDir: packageDir,
          spec: variant,
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

  for (final arg in args) {
    switch (arg) {
      case '--keep-workdir':
        keepWorkDir = true;
      case '--help':
      case '-h':
        stdout.writeln(
          'Usage: dart run tool/benchmark_impl_helper_stripping.dart [--keep-workdir]',
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
      '${Directory.systemTemp.path}/dart_objc_impl_helper_stripping',
    ),
    keepWorkDir: keepWorkDir,
  );
}

Future<void> _writePackageVariant({
  required Directory repoRoot,
  required Directory packageDir,
  required _VariantSpec spec,
}) async {
  packageDir.createSync(recursive: true);
  Directory('${packageDir.path}/lib/src').createSync(recursive: true);
  Directory('${packageDir.path}/native').createSync(recursive: true);

  final sourceBindings = File(
    '${repoRoot.path}/packages/objc-uikit/lib/src/uikit_bindings.dart',
  );
  final sourceText = sourceBindings.readAsStringSync();
  final variantText = _transformBindings(
    sourceText,
    stripImplHelpers: spec.stripImplHelpers,
  );

  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: ${spec.packageName}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  code_assets: ^1.0.0
  hooks: ^1.0.0
  logging: ^1.3.0
  native_toolchain_c: ^0.17.4
  flutter:
    sdk: flutter
  ffi: ^2.2.0
  objective_c:
    path: ${repoRoot.path}/ffigen/pkgs/objective_c

dependency_overrides:
  code_assets:
    path: ${repoRoot.path}/ffigen/pkgs/code_assets
  hooks:
    path: ${repoRoot.path}/ffigen/pkgs/hooks
  native_toolchain_c:
    path: ${repoRoot.path}/ffigen/pkgs/native_toolchain_c
  ffi:
    path: ${repoRoot.path}/ffigen/pkgs/ffi
''');
  File('${packageDir.path}/analysis_options.yaml').writeAsStringSync('''
analyzer:
  exclude:
    - lib/src/*_bindings.dart
''');
  File(
    '${packageDir.path}/lib/${spec.packageName}.dart',
  ).writeAsStringSync("export 'src/uikit_bindings.dart';\n");
  File(
    '${packageDir.path}/lib/src/uikit_bindings.dart',
  ).writeAsStringSync(variantText);
  File('${packageDir.path}/native/uikit_bindings.m').writeAsStringSync(
    File(
      '${repoRoot.path}/packages/objc-uikit/native/uikit_bindings.m',
    ).readAsStringSync(),
  );

  await _runChecked(
    workingDirectory: packageDir.path,
    arguments: const ['pub', 'get'],
  );
}

String _transformBindings(String source, {required bool stripImplHelpers}) {
  if (!stripImplHelpers) {
    return source;
  }

  final lines = source.split('\n');
  final output = <String>[];

  var i = 0;
  while (i < lines.length) {
    final removal = _removalKindForLine(
      lines[i],
      stripImplHelpers: stripImplHelpers,
    );
    if (removal != null) {
      final start = _findRemovableBlockStart(output);
      final end = _findBlockEnd(lines, i);
      output.removeRange(start, output.length);
      i = end + 1;
      while (i < lines.length && lines[i].trim().isEmpty) {
        i++;
      }
      continue;
    }

    output.add(lines[i]);
    i++;
  }

  return output.join('\n');
}

String? _removalKindForLine(String line, {required bool stripImplHelpers}) {
  final trimmed = line.trimLeft();
  if (stripImplHelpers) {
    if (RegExp(r'^abstract interface class .+Spec \{$').hasMatch(trimmed)) {
      return 'spec';
    }
    if (RegExp(r'^abstract interface class .+Optional \{$').hasMatch(trimmed)) {
      return 'optional';
    }
    if (RegExp(r'^interface class .+\$Builder \{$').hasMatch(trimmed)) {
      return 'builder';
    }
    if (RegExp(r'^mixin .+Adapter \{$').hasMatch(trimmed)) {
      return 'adapter';
    }
    if (RegExp(r'^mixin .+Defaults\b').hasMatch(trimmed)) {
      return 'defaults';
    }
    if (RegExp(
      r'^abstract interface class .+Overrides \{$',
    ).hasMatch(trimmed)) {
      return 'overrides';
    }
    if (RegExp(
      r'^abstract final class .+OverrideSelectors \{$',
    ).hasMatch(trimmed)) {
      return 'override_selectors';
    }
    if (RegExp(r'^interface class .+SubclassBuilder \{$').hasMatch(trimmed)) {
      return 'subclass_builder';
    }
    if (RegExp(r'^mixin .+Subclass \{$').hasMatch(trimmed)) {
      return 'subclass_mixin';
    }
  }
  return null;
}

int _findRemovableBlockStart(List<String> output) {
  var start = output.length;
  while (start > 0) {
    final previous = output[start - 1].trimLeft();
    if (previous.startsWith('///') ||
        previous.startsWith('//') ||
        previous.isEmpty) {
      start--;
      continue;
    }
    break;
  }
  return start;
}

int _findBlockEnd(List<String> lines, int start) {
  var depth = 0;
  var seenOpeningBrace = false;
  for (var i = start; i < lines.length; i++) {
    final line = lines[i];
    for (final codeUnit in line.codeUnits) {
      if (codeUnit == 123) {
        depth++;
        seenOpeningBrace = true;
      } else if (codeUnit == 125) {
        depth--;
        if (seenOpeningBrace && depth == 0) {
          return i;
        }
      }
    }
  }
  throw StateError('Failed to find block end from line $start');
}

Future<_VariantResult> _benchmarkVariant({
  required Directory repoRoot,
  required Directory appsDir,
  required Directory packageDir,
  required _VariantSpec spec,
}) async {
  final bindingFile = File('${packageDir.path}/lib/src/uikit_bindings.dart');
  final bindingText = bindingFile.readAsStringSync();

  final appDir = Directory('${appsDir.path}/${spec.key}');
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
  Directory('${appDir.path}/bin').createSync(recursive: true);
  Directory('${appDir.path}/build').createSync(recursive: true);

  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: ${spec.key}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  ${spec.packageName}:
    path: ${packageDir.path}

dependency_overrides:
  ffi:
    path: ${repoRoot.path}/ffigen/pkgs/ffi
  objective_c:
    path: ${repoRoot.path}/ffigen/pkgs/objective_c
''');
  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
import 'package:${spec.packageName}/${spec.packageName}.dart' as ui;

void main() {
  final types = <Type>[
    ui.UIView,
    ui.UIViewController,
    ui.UIViewAnimating,
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

  return _VariantResult(
    spec: spec,
    generatedBytes: bindingFile.lengthSync(),
    generatedLines: '\n'.allMatches(bindingText).length + 1,
    analyzeMs: analyze.elapsedMs,
    analyzeMaxRssBytes: analyze.maxRssBytes,
    kernelMs: kernel.elapsedMs,
    kernelMaxRssBytes: kernel.maxRssBytes,
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

Future<_TimedCommand> _timeDartCommand({
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

  return _TimedCommand(
    elapsedMs: (double.parse(realMatch.group(1)!) * 1000).round(),
    maxRssBytes: int.parse(rssMatch.group(1)!),
  );
}

final class _TimedCommand {
  const _TimedCommand({required this.elapsedMs, required this.maxRssBytes});

  final int elapsedMs;
  final int maxRssBytes;
}

void _printResults(List<_VariantResult> results) {
  for (final result in results) {
    stdout.writeln(
      '${result.spec.key}: '
      '${_mib(result.generatedBytes)} MiB, ${result.generatedLines} lines, '
      'analyze ${result.analyzeMs} ms / ${_mib(result.analyzeMaxRssBytes)} MiB, '
      'kernel ${result.kernelMs} ms / ${_mib(result.kernelMaxRssBytes)} MiB',
    );
  }
}

String _mib(int bytes) => (bytes / (1024 * 1024)).toStringAsFixed(1);
