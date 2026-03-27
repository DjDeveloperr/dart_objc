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

enum _Framework { uikit, metal }

enum _Shape { original, deduped }

final class _ScenarioResult {
  const _ScenarioResult({
    required this.framework,
    required this.shape,
    required this.generatedLines,
    required this.generatedBytes,
    required this.wrapperCount,
    required this.uniqueWrapperCount,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
    required this.kernelMs,
    required this.kernelMaxRssBytes,
  });

  final _Framework framework;
  final _Shape shape;
  final int generatedLines;
  final int generatedBytes;
  final int wrapperCount;
  final int uniqueWrapperCount;
  final int analyzeMs;
  final int analyzeMaxRssBytes;
  final int kernelMs;
  final int kernelMaxRssBytes;
}

final class _TimedRunResult {
  const _TimedRunResult({required this.elapsedMs, required this.maxRssBytes});

  final int elapsedMs;
  final int maxRssBytes;
}

final class _RewriteResult {
  const _RewriteResult({
    required this.content,
    required this.wrapperCount,
    required this.uniqueWrapperCount,
  });

  final String content;
  final int wrapperCount;
  final int uniqueWrapperCount;
}

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  if (options.workDir.existsSync()) {
    options.workDir.deleteSync(recursive: true);
  }
  options.workDir.createSync(recursive: true);

  try {
    final results = <_ScenarioResult>[];
    for (final framework in _Framework.values) {
      for (final shape in _Shape.values) {
        final packageDir = Directory(
          '${options.workDir.path}/${framework.name}_${shape.name}',
        );
        final rewritten = await _preparePackage(
          repoRoot: options.repoRoot,
          packageDir: packageDir,
          framework: framework,
          shape: shape,
        );
        final appDir = await _writeHarness(
          workDir: options.workDir,
          packageDir: packageDir,
          framework: framework,
          shape: shape,
          repoRoot: options.repoRoot,
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
            framework: framework,
            shape: shape,
            generatedLines: '\n'.allMatches(rewritten.content).length + 1,
            generatedBytes: rewritten.content.length,
            wrapperCount: rewritten.wrapperCount,
            uniqueWrapperCount: rewritten.uniqueWrapperCount,
            analyzeMs: analyze.elapsedMs,
            analyzeMaxRssBytes: analyze.maxRssBytes,
            kernelMs: kernel.elapsedMs,
            kernelMaxRssBytes: kernel.maxRssBytes,
          ),
        );
      }
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
    if (arg == '--keep-workdir') {
      keepWorkDir = true;
      continue;
    }
    if (arg == '--help' || arg == '-h') {
      stdout.writeln('''
Usage: dart run tool/benchmark_generated_wrapper_dedup.dart [options]

Options:
  --keep-workdir
''');
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  return BenchmarkOptions(
    repoRoot: Directory.current.absolute,
    workDir: Directory('${Directory.systemTemp.path}/dart_generated_wrapper_dedup'),
    keepWorkDir: keepWorkDir,
  );
}

Future<_RewriteResult> _preparePackage({
  required Directory repoRoot,
  required Directory packageDir,
  required _Framework framework,
  required _Shape shape,
}) async {
  final sourcePackageDir = Directory(
    '${repoRoot.path}/packages/objc-${framework.name}',
  );
  await _copyDirectory(sourcePackageDir, packageDir);
  _rewriteCopiedPackagePubspec(repoRoot: repoRoot, packageDir: packageDir);
  final bindingFile = File('${packageDir.path}/lib/src/${framework.name}_bindings.dart');
  final original = bindingFile.readAsStringSync();
  final rewritten = switch (shape) {
    _Shape.original => _analyzeWrapperDecls(original),
    _Shape.deduped => _dedupeWrapperDecls(original),
  };
  bindingFile.writeAsStringSync(rewritten.content);
  return rewritten;
}

void _rewriteCopiedPackagePubspec({
  required Directory repoRoot,
  required Directory packageDir,
}) {
  final pubspec = File('${packageDir.path}/pubspec.yaml');
  var text = pubspec.readAsStringSync();
  text = text.replaceAll(
    RegExp(r'path:\s+\.\./\.\./ffigen/pkgs/objective_c'),
    'path: ${repoRoot.path}/ffigen/pkgs/objective_c',
  );
  text = text.replaceAll(
    RegExp(r'path:\s+\.\./\.\./ffigen/pkgs/ffi'),
    'path: ${repoRoot.path}/ffigen/pkgs/ffi',
  );
  text = text.replaceAll(
    RegExp(r'path:\s+\.\./\.\./ffigen/pkgs/code_assets'),
    'path: ${repoRoot.path}/ffigen/pkgs/code_assets',
  );
  text = text.replaceAll(
    RegExp(r'path:\s+\.\./\.\./ffigen/pkgs/hooks'),
    'path: ${repoRoot.path}/ffigen/pkgs/hooks',
  );
  text = text.replaceAll(
    RegExp(r'path:\s+\.\./\.\./ffigen/pkgs/native_toolchain_c'),
    'path: ${repoRoot.path}/ffigen/pkgs/native_toolchain_c',
  );
  pubspec.writeAsStringSync(text);
}

_RewriteResult _analyzeWrapperDecls(String source) {
  final decls = _parseWrapperDecls(source);
  final uniqueKeys = {
    for (final decl in decls) decl.normalizedBody,
  };
  return _RewriteResult(
    content: source,
    wrapperCount: decls.length,
    uniqueWrapperCount: uniqueKeys.length,
  );
}

_RewriteResult _dedupeWrapperDecls(String source) {
  final decls = _parseWrapperDecls(source);
  final keepNameByBody = <String, String>{};
  final removeRanges = <_Range>[];
  final rename = <String, String>{};

  for (final decl in decls) {
    final existing = keepNameByBody[decl.normalizedBody];
    if (existing == null) {
      keepNameByBody[decl.normalizedBody] = decl.name;
    } else {
      rename[decl.name] = existing;
      removeRanges.add(_Range(decl.start, decl.end));
    }
  }

  final keptContent = _removeRanges(source, removeRanges);
  final rewritten = _renameIdentifiers(keptContent, rename);
  return _RewriteResult(
    content: rewritten,
    wrapperCount: decls.length,
    uniqueWrapperCount: keepNameByBody.length,
  );
}

final class _WrapperDecl {
  const _WrapperDecl({
    required this.name,
    required this.start,
    required this.end,
    required this.normalizedBody,
  });

  final String name;
  final int start;
  final int end;
  final String normalizedBody;
}

List<_WrapperDecl> _parseWrapperDecls(String source) {
  final lines = source.split('\n');
  final decls = <_WrapperDecl>[];
  var offset = 0;
  var i = 0;

  while (i < lines.length) {
    final line = lines[i];
    final nameMatch = RegExp(r'^final (_objc_msgSend_[A-Za-z0-9_]+) = ').firstMatch(line);
    if (nameMatch == null) {
      offset += line.length + 1;
      i++;
      continue;
    }

    final start = offset;
    final name = nameMatch.group(1)!;
    final block = <String>[line];
    var endOffset = offset + line.length + 1;
    i++;
    while (i < lines.length) {
      final next = lines[i];
      block.add(next);
      endOffset += next.length + 1;
      i++;
      if (next.trim() == '>();') {
        break;
      }
    }

    final normalized = block
        .join('\n')
        .replaceFirst(name, '_objc_msgSend_SHARED')
        .trimRight();
    decls.add(
      _WrapperDecl(
        name: name,
        start: start,
        end: endOffset,
        normalizedBody: normalized,
      ),
    );
    offset = endOffset;
  }

  return decls;
}

String _removeRanges(String source, List<_Range> ranges) {
  if (ranges.isEmpty) {
    return source;
  }
  ranges.sort((a, b) => a.start.compareTo(b.start));
  final buffer = StringBuffer();
  var cursor = 0;
  for (final range in ranges) {
    buffer.write(source.substring(cursor, range.start));
    cursor = range.end;
  }
  buffer.write(source.substring(cursor));
  return buffer.toString();
}

String _renameIdentifiers(String source, Map<String, String> rename) {
  var rewritten = source;
  final orderedNames = rename.keys.toList()
    ..sort((a, b) => b.length.compareTo(a.length));
  for (final oldName in orderedNames) {
    final newName = rename[oldName]!;
    rewritten = rewritten.replaceAllMapped(
      RegExp('\\b${RegExp.escape(oldName)}\\b'),
      (_) => newName,
    );
  }
  return rewritten;
}

final class _Range {
  const _Range(this.start, this.end);

  final int start;
  final int end;
}

Future<Directory> _writeHarness({
  required Directory workDir,
  required Directory packageDir,
  required _Framework framework,
  required _Shape shape,
  required Directory repoRoot,
}) async {
  final appDir = Directory(
    '${workDir.path}/app_${framework.name}_${shape.name}',
  );
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
  Directory('${appDir.path}/bin').createSync(recursive: true);
  Directory('${appDir.path}/build').createSync(recursive: true);

  final ffiPath = '${repoRoot.path}/ffigen/pkgs/ffi';
  final codeAssetsPath = '${repoRoot.path}/ffigen/pkgs/code_assets';
  final hooksPath = '${repoRoot.path}/ffigen/pkgs/hooks';
  final nativeToolchainCPath =
      '${repoRoot.path}/ffigen/pkgs/native_toolchain_c';

  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: app_${framework.name}_${shape.name}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  objc_${framework.name}:
    path: ${packageDir.path}

dependency_overrides:
  ffi:
    path: $ffiPath
  code_assets:
    path: $codeAssetsPath
  hooks:
    path: $hooksPath
  native_toolchain_c:
    path: $nativeToolchainCPath
''');

  final sample = switch (framework) {
    _Framework.metal => '''
import 'dart:ffi' as ffi;
import 'package:objective_c/objective_c.dart' as objc;
import 'package:objc_metal/objc_metal.dart';

void main() {
  final descriptor = MTLAccelerationStructureBoundingBoxGeometryDescriptor.fromPointer(
    ffi.Pointer<objc.ObjCObjectImpl>.fromAddress(1),
    retain: false,
    release: false,
  );
  print(descriptor.boundingBoxCount);
}
''',
    _Framework.uikit => '''
import 'dart:ffi' as ffi;
import 'package:objective_c/objective_c.dart' as objc;
import 'package:objc_uikit/objc_uikit.dart';

void main() {
  final label = UILabel.fromPointer(
    ffi.Pointer<objc.ObjCObjectImpl>.fromAddress(1),
    retain: false,
    release: false,
  );
  print(label.tag);
}
''',
  };

  File('${appDir.path}/bin/main.dart').writeAsStringSync(sample);
  await _runChecked(
    workingDirectory: appDir.path,
    arguments: const ['pub', 'get'],
  );
  return appDir;
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

Future<void> _copyDirectory(Directory source, Directory destination) async {
  await for (final entity in source.list(recursive: true)) {
    final relative = entity.path.substring(source.path.length + 1);
    final targetPath = '${destination.path}/$relative';
    if (entity is Directory) {
      Directory(targetPath).createSync(recursive: true);
    } else if (entity is File) {
      final target = File(targetPath)..parent.createSync(recursive: true);
      await entity.copy(target.path);
    }
  }
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
    '| Framework | Shape | Size | Lines | Wrappers | Unique wrappers | Analyze | Analyze RSS | Kernel | Kernel RSS |',
  );
  stdout.writeln(
    '| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |',
  );
  for (final result in results) {
    stdout.writeln(
      '| `${result.framework.name}` | '
      '`${result.shape.name}` | '
      '${_formatBytes(result.generatedBytes)} | '
      '${result.generatedLines} | '
      '${result.wrapperCount} | '
      '${result.uniqueWrapperCount} | '
      '${result.analyzeMs} ms | '
      '${_formatMib(result.analyzeMaxRssBytes)} MiB | '
      '${result.kernelMs} ms | '
      '${_formatMib(result.kernelMaxRssBytes)} MiB |',
    );
  }
}
