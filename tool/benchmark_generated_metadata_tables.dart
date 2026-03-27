import 'dart:io';

final class _BenchmarkOptions {
  const _BenchmarkOptions({
    required this.repoRoot,
    required this.workDir,
    required this.keepWorkDir,
    required this.frameworks,
    required this.shapes,
    required this.includeKernel,
  });

  final Directory repoRoot;
  final Directory workDir;
  final bool keepWorkDir;
  final List<_Framework> frameworks;
  final List<_Shape> shapes;
  final bool includeKernel;
}

enum _Framework { uikit, metal }

enum _Shape { original, selectorTable, allMetadataTables }

final class _ScenarioResult {
  const _ScenarioResult({
    required this.framework,
    required this.shape,
    required this.generatedLines,
    required this.generatedBytes,
    required this.selectorCount,
    required this.classCount,
    required this.protocolCount,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
    required this.kernelMs,
    required this.kernelMaxRssBytes,
  });

  final _Framework framework;
  final _Shape shape;
  final int generatedLines;
  final int generatedBytes;
  final int selectorCount;
  final int classCount;
  final int protocolCount;
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
    required this.selectorCount,
    required this.classCount,
    required this.protocolCount,
  });

  final String content;
  final int selectorCount;
  final int classCount;
  final int protocolCount;
}

enum _MetadataKind { selector, clazz, protocol }

final class _MetadataDecl {
  const _MetadataDecl({
    required this.kind,
    required this.name,
    required this.value,
    required this.start,
    required this.end,
  });

  final _MetadataKind kind;
  final String name;
  final String value;
  final int start;
  final int end;
}

final class _Range {
  const _Range(this.start, this.end);

  final int start;
  final int end;
}

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  if (options.workDir.existsSync()) {
    options.workDir.deleteSync(recursive: true);
  }
  options.workDir.createSync(recursive: true);

  try {
    final results = <_ScenarioResult>[];
    for (final framework in options.frameworks) {
      for (final shape in options.shapes) {
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
        final kernel =
            options.includeKernel
                ? await _timeDartCommand(
                  workingDirectory: appDir.path,
                  arguments: const [
                    'compile',
                    'kernel',
                    'bin/main.dart',
                    '-o',
                    'build/app.dill',
                  ],
                )
                : const _TimedRunResult(elapsedMs: 0, maxRssBytes: 0);
        results.add(
          _ScenarioResult(
            framework: framework,
            shape: shape,
            generatedLines: '\n'.allMatches(rewritten.content).length + 1,
            generatedBytes: rewritten.content.length,
            selectorCount: rewritten.selectorCount,
            classCount: rewritten.classCount,
            protocolCount: rewritten.protocolCount,
            analyzeMs: analyze.elapsedMs,
            analyzeMaxRssBytes: analyze.maxRssBytes,
            kernelMs: kernel.elapsedMs,
            kernelMaxRssBytes: kernel.maxRssBytes,
          ),
        );
      }
    }

    _printResults(results);
    if (options.keepWorkDir) {
      final keptPath = options.workDir.path;
      stdout.writeln('\nKept workdir: $keptPath');
    }
  } finally {
    if (!options.keepWorkDir && options.workDir.existsSync()) {
      options.workDir.deleteSync(recursive: true);
    }
  }
}

_BenchmarkOptions _parseArgs(List<String> args) {
  var keepWorkDir = false;
  var includeKernel = true;
  final frameworks = <_Framework>[];
  final shapes = <_Shape>[];
  String? workDirPath;
  for (final arg in args) {
    if (arg == '--keep-workdir') {
      keepWorkDir = true;
      continue;
    }
    if (arg == '--no-kernel') {
      includeKernel = false;
      continue;
    }
    if (arg.startsWith('--framework=')) {
      frameworks.add(_parseFramework(arg.substring('--framework='.length)));
      continue;
    }
    if (arg.startsWith('--shape=')) {
      shapes.add(_parseShape(arg.substring('--shape='.length)));
      continue;
    }
    if (arg.startsWith('--workdir=')) {
      workDirPath = arg.substring('--workdir='.length);
      continue;
    }
    if (arg == '--help' || arg == '-h') {
      stdout.writeln('''
Usage: dart run tool/benchmark_generated_metadata_tables.dart [options]

Options:
  --keep-workdir
  --no-kernel
  --framework=uikit|metal
  --shape=original|selectorTable|allMetadataTables
  --workdir=/tmp/custom-dir
''');
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  final defaultWorkDir = Directory(
    '${Directory.systemTemp.path}/dart_generated_metadata_tables_${DateTime.now().microsecondsSinceEpoch}_$pid',
  );

  return _BenchmarkOptions(
    repoRoot: Directory.current.absolute,
    workDir: workDirPath == null ? defaultWorkDir : Directory(workDirPath),
    keepWorkDir: keepWorkDir,
    frameworks: frameworks.isEmpty ? _Framework.values.toList() : frameworks,
    shapes: shapes.isEmpty ? _Shape.values.toList() : shapes,
    includeKernel: includeKernel,
  );
}

_Framework _parseFramework(String raw) {
  for (final framework in _Framework.values) {
    if (framework.name == raw) {
      return framework;
    }
  }
  stderr.writeln('Unknown framework: $raw');
  exit(64);
}

_Shape _parseShape(String raw) {
  for (final shape in _Shape.values) {
    if (shape.name == raw) {
      return shape;
    }
  }
  stderr.writeln('Unknown shape: $raw');
  exit(64);
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
  final bindingFile = File(
    '${packageDir.path}/lib/src/${framework.name}_bindings.dart',
  );
  final original = bindingFile.readAsStringSync();
  final rewritten = switch (shape) {
    _Shape.original => _analyzeMetadataDecls(original),
    _Shape.selectorTable => _rewriteMetadataDecls(
      original,
      selectors: true,
      classes: false,
      protocols: false,
    ),
    _Shape.allMetadataTables => _rewriteMetadataDecls(
      original,
      selectors: true,
      classes: true,
      protocols: true,
    ),
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

_RewriteResult _analyzeMetadataDecls(String source) {
  final decls = _parseMetadataDecls(source);
  return _RewriteResult(
    content: source,
    selectorCount: decls.where((d) => d.kind == _MetadataKind.selector).length,
    classCount: decls.where((d) => d.kind == _MetadataKind.clazz).length,
    protocolCount: decls.where((d) => d.kind == _MetadataKind.protocol).length,
  );
}

_RewriteResult _rewriteMetadataDecls(
  String source, {
  required bool selectors,
  required bool classes,
  required bool protocols,
}) {
  final decls = _parseMetadataDecls(source);
  final removeRanges = <_Range>[];
  final rename = <String, String>{};

  final selectedSelectors = <_MetadataDecl>[];
  final selectedClasses = <_MetadataDecl>[];
  final selectedProtocols = <_MetadataDecl>[];

  for (final decl in decls) {
    final shouldRewrite = switch (decl.kind) {
      _MetadataKind.selector => selectors,
      _MetadataKind.clazz => classes,
      _MetadataKind.protocol => protocols,
    };
    if (!shouldRewrite) {
      continue;
    }
    removeRanges.add(_Range(decl.start, decl.end));
    switch (decl.kind) {
      case _MetadataKind.selector:
        rename[decl.name] = '_selectorAt(${selectedSelectors.length})';
        selectedSelectors.add(decl);
      case _MetadataKind.clazz:
        rename[decl.name] = '_classAt(${selectedClasses.length})';
        selectedClasses.add(decl);
      case _MetadataKind.protocol:
        rename[decl.name] = '_protocolAt(${selectedProtocols.length})';
        selectedProtocols.add(decl);
    }
  }

  var rewritten = _removeRanges(source, removeRanges);
  rewritten = _renameIdentifiers(rewritten, rename);
  rewritten = '$rewritten\n${_helperBlock(selectedSelectors, selectedClasses, selectedProtocols)}';

  return _RewriteResult(
    content: rewritten,
    selectorCount: decls.where((d) => d.kind == _MetadataKind.selector).length,
    classCount: decls.where((d) => d.kind == _MetadataKind.clazz).length,
    protocolCount: decls.where((d) => d.kind == _MetadataKind.protocol).length,
  );
}

List<_MetadataDecl> _parseMetadataDecls(String source) {
  final lines = source.split('\n');
  final decls = <_MetadataDecl>[];
  var offset = 0;
  var i = 0;

  while (i < lines.length) {
    final line = lines[i];
    final selectorMatch =
        RegExp(r'^late final (_sel_[A-Za-z0-9_]+) = objc\.registerName\(')
            .firstMatch(line);
    final classMatch =
        RegExp(r'^late final (_class_[A-Za-z0-9_$]+) = objc\.getClass\(')
            .firstMatch(line);
    final protocolMatch =
        RegExp(r'^late final (_protocol_[A-Za-z0-9_$]+) = objc\.getProtocol\(')
            .firstMatch(line);

    final match = selectorMatch ?? classMatch ?? protocolMatch;
    if (match == null) {
      offset += line.length + 1;
      i++;
      continue;
    }

    final kind = switch (match.group(1)!) {
      final name when name.startsWith('_sel_') => _MetadataKind.selector,
      final name when name.startsWith('_class_') => _MetadataKind.clazz,
      _ => _MetadataKind.protocol,
    };

    final start = offset;
    final name = match.group(1)!;
    final block = <String>[line];
    var endOffset = offset + line.length + 1;
    i++;
    if (!line.trim().endsWith(');')) {
      while (i < lines.length) {
        final next = lines[i];
        block.add(next);
        endOffset += next.length + 1;
        i++;
        if (next.trim() == ');') {
          break;
        }
      }
    }

    final blockText = block.join('\n');
    final valueMatch = RegExp(r'"((?:[^"\\]|\\.)*)"').firstMatch(blockText);
    if (valueMatch == null) {
      throw StateError('Unable to parse metadata value for $name');
    }

    decls.add(
      _MetadataDecl(
        kind: kind,
        name: name,
        value: valueMatch.group(1)!,
        start: start,
        end: endOffset,
      ),
    );
    offset = endOffset;
  }

  return decls;
}

String _helperBlock(
  List<_MetadataDecl> selectors,
  List<_MetadataDecl> classes,
  List<_MetadataDecl> protocols,
) {
  final buffer = StringBuffer();

  if (selectors.isNotEmpty) {
    buffer
      ..writeln('const _selectorNames = <String>[')
      ..writeln(
        selectors.map((d) => "  '${_escapeString(d.value)}',").join('\n'),
      )
      ..writeln('];')
      ..writeln(
        'final _selectorCache = List<ffi.Pointer<objc.ObjCSelector>?>.filled(_selectorNames.length, null);',
      )
      ..writeln('ffi.Pointer<objc.ObjCSelector> _selectorAt(int slot) =>')
      ..writeln(
        '    _selectorCache[slot] ??= objc.registerName(_selectorNames[slot]);',
      )
      ..writeln();
  }

  if (classes.isNotEmpty) {
    buffer
      ..writeln('const _classNames = <String>[')
      ..writeln(classes.map((d) => "  '${_escapeString(d.value)}',").join('\n'))
      ..writeln('];')
      ..writeln(
        'final _classCache = List<ffi.Pointer<objc.ObjCObjectImpl>?>.filled(_classNames.length, null);',
      )
      ..writeln('ffi.Pointer<objc.ObjCObjectImpl> _classAt(int slot) =>')
      ..writeln('    _classCache[slot] ??= objc.getClass(_classNames[slot]);')
      ..writeln();
  }

  if (protocols.isNotEmpty) {
    buffer
      ..writeln('const _protocolNames = <String>[')
      ..writeln(
        protocols.map((d) => "  '${_escapeString(d.value)}',").join('\n'),
      )
      ..writeln('];')
      ..writeln(
        'final _protocolCache = List<ffi.Pointer<objc.ObjCProtocolImpl>?>.filled(_protocolNames.length, null);',
      )
      ..writeln(
        'ffi.Pointer<objc.ObjCProtocolImpl> _protocolAt(int slot) =>',
      )
      ..writeln(
        '    _protocolCache[slot] ??= objc.getProtocol(_protocolNames[slot]);',
      )
      ..writeln();
  }

  return buffer.toString();
}

String _escapeString(String value) =>
    value.replaceAll(r'\', r'\\').replaceAll("'", r"\'");

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
    '| Framework | Shape | Size | Lines | Selectors | Classes | Protocols | Analyze | Analyze RSS | Kernel | Kernel RSS |',
  );
  stdout.writeln(
    '| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |',
  );
  for (final result in results) {
    stdout.writeln(
      '| `${result.framework.name}` | '
      '`${result.shape.name}` | '
      '${_formatBytes(result.generatedBytes)} | '
      '${result.generatedLines} | '
      '${result.selectorCount} | '
      '${result.classCount} | '
      '${result.protocolCount} | '
      '${result.analyzeMs} ms | '
      '${_formatMib(result.analyzeMaxRssBytes)} MiB | '
      '${result.kernelMs} ms | '
      '${_formatMib(result.kernelMaxRssBytes)} MiB |',
    );
  }
}
