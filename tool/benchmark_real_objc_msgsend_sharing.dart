import 'dart:io';

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.repoRoot,
    required this.workDir,
    required this.keepWorkDir,
    required this.familyCount,
  });

  final Directory repoRoot;
  final Directory workDir;
  final bool keepWorkDir;
  final int familyCount;
}

enum _Shape { duplicatedWrappers, sharedWrappers, sharedWrappersTable }

final class _ScenarioResult {
  const _ScenarioResult({
    required this.shape,
    required this.generatedLines,
    required this.generatedBytes,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
    required this.kernelMs,
    required this.kernelMaxRssBytes,
  });

  final _Shape shape;
  final int generatedLines;
  final int generatedBytes;
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

  try {
    final results = <_ScenarioResult>[];
    for (final shape in _Shape.values) {
      final packageDir = Directory('${options.workDir.path}/${shape.name}');
      final dartSource = await _writeScenarioPackage(
        repoRoot: options.repoRoot,
        packageDir: packageDir,
        shape: shape,
        familyCount: options.familyCount,
      );
      final appDir = await _writeHarness(
        workDir: options.workDir,
        packageDir: packageDir,
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
          shape: shape,
          generatedLines: '\n'.allMatches(dartSource).length + 1,
          generatedBytes: dartSource.length,
          analyzeMs: analyze.elapsedMs,
          analyzeMaxRssBytes: analyze.maxRssBytes,
          kernelMs: kernel.elapsedMs,
          kernelMaxRssBytes: kernel.maxRssBytes,
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
  var familyCount = 1000;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--keep-workdir') {
      keepWorkDir = true;
      continue;
    }
    if (arg == '--families') {
      familyCount = int.parse(args[++i]);
      continue;
    }
    if (arg == '--help' || arg == '-h') {
      stdout.writeln('''
Usage: dart run tool/benchmark_real_objc_msgsend_sharing.dart [options]

Options:
  --families N   Number of synthetic ObjC families. Default: 1000
  --keep-workdir
''');
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  return BenchmarkOptions(
    repoRoot: Directory.current.absolute,
    workDir: Directory(
      '${Directory.systemTemp.path}/dart_real_objc_msgsend_sharing',
    ),
    keepWorkDir: keepWorkDir,
    familyCount: familyCount,
  );
}

Future<String> _writeScenarioPackage({
  required Directory repoRoot,
  required Directory packageDir,
  required _Shape shape,
  required int familyCount,
}) async {
  packageDir.createSync(recursive: true);
  final libDir = Directory('${packageDir.path}/lib')
    ..createSync(recursive: true);
  final srcDir = Directory('${libDir.path}/src')..createSync(recursive: true);
  final objectiveCPath = '${repoRoot.path}/ffigen/pkgs/objective_c';
  final ffiPath = '${repoRoot.path}/ffigen/pkgs/ffi';
  final codeAssetsPath = '${repoRoot.path}/ffigen/pkgs/code_assets';
  final hooksPath = '${repoRoot.path}/ffigen/pkgs/hooks';
  final nativeToolchainCPath =
      '${repoRoot.path}/ffigen/pkgs/native_toolchain_c';

  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: real_objc_msgsend_${shape.name}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  ffi: ^2.2.0
  objective_c:
    path: $objectiveCPath

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

  final source = _bindingsSource(shape, familyCount);
  File(
    '${libDir.path}/real_objc_msgsend_${shape.name}.dart',
  ).writeAsStringSync("export 'src/bindings.dart';\n");
  File('${srcDir.path}/bindings.dart').writeAsStringSync(source);
  return source;
}

String _bindingsSource(_Shape shape, int familyCount) {
  final buffer = StringBuffer()
    ..writeln("import 'dart:ffi' as ffi;")
    ..writeln("import 'package:objective_c/objective_c.dart' as objc;")
    ..writeln()
    ..writeln('ffi.Pointer<objc.ObjCObjectImpl> _ptr(int address) =>')
    ..writeln('    ffi.Pointer<objc.ObjCObjectImpl>.fromAddress(address);')
    ..writeln()
    ..writeln('objc.ObjCObject _wrap(ffi.Pointer<objc.ObjCObjectImpl> ptr) =>')
    ..writeln('    objc.ObjCObject(ptr, retain: false, release: false);')
    ..writeln()
    ..writeln(
      'objc.ObjCObject? _wrapOrNull(ffi.Pointer<objc.ObjCObjectImpl> ptr) =>',
    )
    ..writeln('    ptr == ffi.nullptr ? null : _wrap(ptr);')
    ..writeln()
    ..writeln(
      'objc.NSString? _stringOrNull(ffi.Pointer<objc.ObjCObjectImpl> ptr) =>',
    )
    ..writeln('    ptr == ffi.nullptr ? null : objc.NSString.as(_wrap(ptr));')
    ..writeln();

  if (shape != _Shape.duplicatedWrappers) {
    _writeSharedWrappers(buffer);
  }
  if (shape == _Shape.sharedWrappersTable) {
    buffer.writeln('const _selectorNames = <String>[');
    for (var i = 0; i < familyCount; i++) {
      for (final selectorName in _selectorNamesForFamily(i)) {
        buffer.writeln("  '$selectorName',");
      }
    }
    buffer
      ..writeln('];')
      ..writeln(
        'final _selectorCache = List<ffi.Pointer<objc.ObjCSelector>?>.filled(_selectorNames.length, null);',
      )
      ..writeln()
      ..writeln('ffi.Pointer<objc.ObjCSelector> _selector(int slot) =>')
      ..writeln(
        '    _selectorCache[slot] ??= objc.registerName(_selectorNames[slot]);',
      )
      ..writeln();
  } else {
    for (var i = 0; i < familyCount; i++) {
      for (final selectorName in _selectorNamesForFamily(i)) {
        final fieldName = _selectorFieldName(selectorName);
        buffer.writeln(
          "late final _sel_$fieldName = objc.registerName('$selectorName');",
        );
      }
      buffer.writeln();
    }
  }

  for (var i = 0; i < familyCount; i++) {
    _writeFamily(buffer, shape, i);
  }
  return '${buffer.toString()}\n';
}

void _writeSharedWrappers(StringBuffer buffer) {
  buffer
    ..writeln(
      'typedef _MsgSendObject0Native = ffi.Pointer<objc.ObjCObjectImpl>',
    )
    ..writeln('    Function(')
    ..writeln('      ffi.Pointer<objc.ObjCObjectImpl>,')
    ..writeln('      ffi.Pointer<objc.ObjCSelector>,')
    ..writeln('    );')
    ..writeln('typedef _MsgSendObject0Dart = ffi.Pointer<objc.ObjCObjectImpl>')
    ..writeln('    Function(')
    ..writeln('      ffi.Pointer<objc.ObjCObjectImpl>,')
    ..writeln('      ffi.Pointer<objc.ObjCSelector>,')
    ..writeln('    );')
    ..writeln('typedef _MsgSendInt0Native = ffi.Long Function(')
    ..writeln('  ffi.Pointer<objc.ObjCObjectImpl>,')
    ..writeln('  ffi.Pointer<objc.ObjCSelector>,')
    ..writeln(');')
    ..writeln('typedef _MsgSendInt0Dart = int Function(')
    ..writeln('  ffi.Pointer<objc.ObjCObjectImpl>,')
    ..writeln('  ffi.Pointer<objc.ObjCSelector>,')
    ..writeln(');')
    ..writeln('typedef _MsgSendVoid0Native = ffi.Void Function(')
    ..writeln('  ffi.Pointer<objc.ObjCObjectImpl>,')
    ..writeln('  ffi.Pointer<objc.ObjCSelector>,')
    ..writeln(');')
    ..writeln('typedef _MsgSendVoid0Dart = void Function(')
    ..writeln('  ffi.Pointer<objc.ObjCObjectImpl>,')
    ..writeln('  ffi.Pointer<objc.ObjCSelector>,')
    ..writeln(');')
    ..writeln('typedef _MsgSendVoid1ObjectNative = ffi.Void Function(')
    ..writeln('  ffi.Pointer<objc.ObjCObjectImpl>,')
    ..writeln('  ffi.Pointer<objc.ObjCSelector>,')
    ..writeln('  ffi.Pointer<objc.ObjCObjectImpl>,')
    ..writeln(');')
    ..writeln('typedef _MsgSendVoid1ObjectDart = void Function(')
    ..writeln('  ffi.Pointer<objc.ObjCObjectImpl>,')
    ..writeln('  ffi.Pointer<objc.ObjCSelector>,')
    ..writeln('  ffi.Pointer<objc.ObjCObjectImpl>,')
    ..writeln(');')
    ..writeln()
    ..writeln('final _msgSendObject0 = objc.msgSendPointer')
    ..writeln('    .cast<ffi.NativeFunction<_MsgSendObject0Native>>()')
    ..writeln('    .asFunction<_MsgSendObject0Dart>();')
    ..writeln('final _msgSendInt0 = objc.msgSendPointer')
    ..writeln('    .cast<ffi.NativeFunction<_MsgSendInt0Native>>()')
    ..writeln('    .asFunction<_MsgSendInt0Dart>();')
    ..writeln('final _msgSendVoid0 = objc.msgSendPointer')
    ..writeln('    .cast<ffi.NativeFunction<_MsgSendVoid0Native>>()')
    ..writeln('    .asFunction<_MsgSendVoid0Dart>();')
    ..writeln('final _msgSendVoid1Object = objc.msgSendPointer')
    ..writeln('    .cast<ffi.NativeFunction<_MsgSendVoid1ObjectNative>>()')
    ..writeln('    .asFunction<_MsgSendVoid1ObjectDart>();')
    ..writeln();
}

void _writeFamily(StringBuffer buffer, _Shape shape, int familyIndex) {
  final allocatorPrefix = 'Family${familyIndex}Allocator';
  final descriptorPrefix = 'Family${familyIndex}Descriptor';
  final selectorNames = _selectorNamesForFamily(familyIndex);
  final selectorFields = selectorNames.map(_selectorFieldName).toList();
  final selectorBase = familyIndex * _selectorCountPerFamily;

  if (shape == _Shape.duplicatedWrappers) {
    _writeDuplicatedWrapperDeclarations(buffer, familyIndex);
  }

  buffer
    ..writeln('extension type $allocatorPrefix._(objc.ObjCObject object\$)')
    ..writeln('    implements objc.ObjCObject {')
    ..writeln(
      '  $allocatorPrefix.fromAddress(int address) : object\$ = _wrap(_ptr(address));',
    )
    ..writeln('}')
    ..writeln()
    ..writeln('extension $allocatorPrefix\$Methods on $allocatorPrefix {');

  switch (shape) {
    case _Shape.duplicatedWrappers:
      buffer
        ..writeln(
          '  int get allocatedSize => _objc_msgSend_${familyIndex}_allocatedSize(object\$.ref.pointer, _sel_${selectorFields[0]});',
        )
        ..writeln(
          '  objc.ObjCObject? get device => _wrapOrNull(_objc_msgSend_${familyIndex}_device(object\$.ref.pointer, _sel_${selectorFields[1]}));',
        )
        ..writeln(
          '  objc.NSString? get label => _stringOrNull(_objc_msgSend_${familyIndex}_label(object\$.ref.pointer, _sel_${selectorFields[2]}));',
        )
        ..writeln(
          '  void reset() => _objc_msgSend_${familyIndex}_reset(object\$.ref.pointer, _sel_${selectorFields[3]});',
        );
    case _Shape.sharedWrappers:
      buffer
        ..writeln(
          '  int get allocatedSize => _msgSendInt0(object\$.ref.pointer, _sel_${selectorFields[0]});',
        )
        ..writeln(
          '  objc.ObjCObject? get device => _wrapOrNull(_msgSendObject0(object\$.ref.pointer, _sel_${selectorFields[1]}));',
        )
        ..writeln(
          '  objc.NSString? get label => _stringOrNull(_msgSendObject0(object\$.ref.pointer, _sel_${selectorFields[2]}));',
        )
        ..writeln(
          '  void reset() => _msgSendVoid0(object\$.ref.pointer, _sel_${selectorFields[3]});',
        );
    case _Shape.sharedWrappersTable:
      buffer
        ..writeln(
          '  int get allocatedSize => _msgSendInt0(object\$.ref.pointer, _selector($selectorBase));',
        )
        ..writeln(
          '  objc.ObjCObject? get device => _wrapOrNull(_msgSendObject0(object\$.ref.pointer, _selector(${selectorBase + 1})));',
        )
        ..writeln(
          '  objc.NSString? get label => _stringOrNull(_msgSendObject0(object\$.ref.pointer, _selector(${selectorBase + 2})));',
        )
        ..writeln(
          '  void reset() => _msgSendVoid0(object\$.ref.pointer, _selector(${selectorBase + 3}));',
        );
  }
  buffer
    ..writeln('}')
    ..writeln()
    ..writeln('extension type $descriptorPrefix._(objc.ObjCObject object\$)')
    ..writeln('    implements objc.ObjCObject {')
    ..writeln(
      '  $descriptorPrefix.fromAddress(int address) : object\$ = _wrap(_ptr(address));',
    )
    ..writeln('}')
    ..writeln()
    ..writeln('extension $descriptorPrefix\$Methods on $descriptorPrefix {');

  switch (shape) {
    case _Shape.duplicatedWrappers:
      buffer
        ..writeln(
          '  objc.NSString? get label => _stringOrNull(_objc_msgSend_${familyIndex}_descriptorLabel(object\$.ref.pointer, _sel_${selectorFields[4]}));',
        )
        ..writeln(
          '  void setLabel(objc.NSString? value) => _objc_msgSend_${familyIndex}_setDescriptorLabel(object\$.ref.pointer, _sel_${selectorFields[5]}, value?.ref.pointer ?? ffi.nullptr);',
        );
    case _Shape.sharedWrappers:
      buffer
        ..writeln(
          '  objc.NSString? get label => _stringOrNull(_msgSendObject0(object\$.ref.pointer, _sel_${selectorFields[4]}));',
        )
        ..writeln(
          '  void setLabel(objc.NSString? value) => _msgSendVoid1Object(object\$.ref.pointer, _sel_${selectorFields[5]}, value?.ref.pointer ?? ffi.nullptr);',
        );
    case _Shape.sharedWrappersTable:
      buffer
        ..writeln(
          '  objc.NSString? get label => _stringOrNull(_msgSendObject0(object\$.ref.pointer, _selector(${selectorBase + 4})));',
        )
        ..writeln(
          '  void setLabel(objc.NSString? value) => _msgSendVoid1Object(object\$.ref.pointer, _selector(${selectorBase + 5}), value?.ref.pointer ?? ffi.nullptr);',
        );
  }
  buffer
    ..writeln('}')
    ..writeln();
}

void _writeDuplicatedWrapperDeclarations(StringBuffer buffer, int familyIndex) {
  void writeObject0(String name) {
    buffer
      ..writeln(
        'final _objc_msgSend_${familyIndex}_$name = objc.msgSendPointer',
      )
      ..writeln(
        '    .cast<ffi.NativeFunction<ffi.Pointer<objc.ObjCObjectImpl> Function(ffi.Pointer<objc.ObjCObjectImpl>, ffi.Pointer<objc.ObjCSelector>)>>()',
      )
      ..writeln(
        '    .asFunction<ffi.Pointer<objc.ObjCObjectImpl> Function(ffi.Pointer<objc.ObjCObjectImpl>, ffi.Pointer<objc.ObjCSelector>)>();',
      );
  }

  buffer
    ..writeln(
      'final _objc_msgSend_${familyIndex}_allocatedSize = objc.msgSendPointer',
    )
    ..writeln(
      '    .cast<ffi.NativeFunction<ffi.Long Function(ffi.Pointer<objc.ObjCObjectImpl>, ffi.Pointer<objc.ObjCSelector>)>>()',
    )
    ..writeln(
      '    .asFunction<int Function(ffi.Pointer<objc.ObjCObjectImpl>, ffi.Pointer<objc.ObjCSelector>)>();',
    );
  writeObject0('device');
  writeObject0('label');
  buffer
    ..writeln('final _objc_msgSend_${familyIndex}_reset = objc.msgSendPointer')
    ..writeln(
      '    .cast<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<objc.ObjCObjectImpl>, ffi.Pointer<objc.ObjCSelector>)>>()',
    )
    ..writeln(
      '    .asFunction<void Function(ffi.Pointer<objc.ObjCObjectImpl>, ffi.Pointer<objc.ObjCSelector>)>();',
    );
  writeObject0('descriptorLabel');
  buffer
    ..writeln(
      'final _objc_msgSend_${familyIndex}_setDescriptorLabel = objc.msgSendPointer',
    )
    ..writeln(
      '    .cast<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<objc.ObjCObjectImpl>, ffi.Pointer<objc.ObjCSelector>, ffi.Pointer<objc.ObjCObjectImpl>)>>()',
    )
    ..writeln(
      '    .asFunction<void Function(ffi.Pointer<objc.ObjCObjectImpl>, ffi.Pointer<objc.ObjCSelector>, ffi.Pointer<objc.ObjCObjectImpl>)>();',
    )
    ..writeln();
}

const _selectorCountPerFamily = 6;

List<String> _selectorNamesForFamily(int familyIndex) => [
  'family${familyIndex}_allocatedSize',
  'family${familyIndex}_device',
  'family${familyIndex}_label',
  'family${familyIndex}_reset',
  'family${familyIndex}_descriptorLabel',
  'family${familyIndex}_setDescriptorLabel:',
];

String _selectorFieldName(String selectorName) =>
    selectorName.replaceAll(':', '_');

Future<Directory> _writeHarness({
  required Directory workDir,
  required Directory packageDir,
  required _Shape shape,
  required Directory repoRoot,
}) async {
  final appDir = Directory('${workDir.path}/app_${shape.name}');
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
name: app_${shape.name}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
  real_objc_msgsend_${shape.name}:
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
  File('${appDir.path}/bin/main.dart').writeAsStringSync('''
import 'package:real_objc_msgsend_${shape.name}/real_objc_msgsend_${shape.name}.dart';

void main() {
  final allocator = Family0Allocator.fromAddress(1);
  final descriptor = Family0Descriptor.fromAddress(2);
  final values = <Object?>[
    allocator.allocatedSize,
    allocator.device,
    allocator.label,
    descriptor.label,
  ];
  allocator.reset();
  descriptor.setLabel(null);
  print(values.length);
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
  for (final result in results) {
    stdout.writeln(
      '${result.shape.name}: '
      '${_mib(result.generatedBytes)} MiB, ${result.generatedLines} lines, '
      'analyze ${result.analyzeMs} ms / ${_mib(result.analyzeMaxRssBytes)} MiB, '
      'kernel ${result.kernelMs} ms / ${_mib(result.kernelMaxRssBytes)} MiB',
    );
  }
}

String _mib(int bytes) => (bytes / (1024 * 1024)).toStringAsFixed(1);
