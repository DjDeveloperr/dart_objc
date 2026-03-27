import 'dart:io';

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.workDir,
    required this.keepWorkDir,
    required this.familyCount,
  });

  final Directory workDir;
  final bool keepWorkDir;
  final int familyCount;
}

enum _Variant { currentAll, currentSplit, thinRuntime }

enum _HarnessKind { consumer, implementer }

enum _DependencyMode { path, git }

final class _BenchmarkResult {
  const _BenchmarkResult({
    required this.variant,
    required this.harnessKind,
    required this.dependencyMode,
    required this.generatedLines,
    required this.generatedBytes,
    required this.analyzeMs,
    required this.analyzeMaxRssBytes,
    required this.kernelMs,
    required this.kernelMaxRssBytes,
  });

  final _Variant variant;
  final _HarnessKind harnessKind;
  final _DependencyMode dependencyMode;
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
    final packagesDir = Directory('${options.workDir.path}/packages')
      ..createSync(recursive: true);
    final appsDir = Directory('${options.workDir.path}/apps')
      ..createSync(recursive: true);

    final results = <_BenchmarkResult>[];
    for (final variant in _Variant.values) {
      final packageDir = Directory('${packagesDir.path}/${variant.name}');
      final generatedContent = await _writePackage(
        packageDir: packageDir,
        variant: variant,
        familyCount: options.familyCount,
      );
      await _initializeGitRepo(packageDir);
      for (final harnessKind in _harnessKindsFor(variant)) {
        for (final dependencyMode in _DependencyMode.values) {
          final appDir = await _writeHarness(
            appsDir: appsDir,
            packageDir: packageDir,
            variant: variant,
            harnessKind: harnessKind,
            dependencyMode: dependencyMode,
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
            _BenchmarkResult(
              variant: variant,
              harnessKind: harnessKind,
              dependencyMode: dependencyMode,
              generatedLines: '\n'.allMatches(generatedContent).length + 1,
              generatedBytes: generatedContent.length,
              analyzeMs: analyze.elapsedMs,
              analyzeMaxRssBytes: analyze.maxRssBytes,
              kernelMs: kernel.elapsedMs,
              kernelMaxRssBytes: kernel.maxRssBytes,
            ),
          );
        }
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
  var familyCount = 250;

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
Usage: dart run tool/benchmark_objc_pattern_shapes.dart [options]

Options:
  --families N   Number of generated ObjC-style families. Default: 250
  --keep-workdir
''');
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  return BenchmarkOptions(
    workDir: Directory('${Directory.systemTemp.path}/dart_objc_pattern_shapes'),
    keepWorkDir: keepWorkDir,
    familyCount: familyCount,
  );
}

List<_HarnessKind> _harnessKindsFor(_Variant variant) {
  switch (variant) {
    case _Variant.currentAll:
    case _Variant.currentSplit:
      return const [_HarnessKind.consumer, _HarnessKind.implementer];
    case _Variant.thinRuntime:
      return const [_HarnessKind.consumer];
  }
}

Future<String> _writePackage({
  required Directory packageDir,
  required _Variant variant,
  required int familyCount,
}) async {
  packageDir.createSync(recursive: true);
  final libDir = Directory('${packageDir.path}/lib')
    ..createSync(recursive: true);
  Directory('${libDir.path}/src').createSync(recursive: true);

  File('${packageDir.path}/pubspec.yaml').writeAsStringSync('''
name: objc_pattern_${variant.name}
publish_to: none

environment:
  sdk: ^3.11.0
''');

  final support = _runtimeSupportSource();
  File('${libDir.path}/src/runtime_support.dart').writeAsStringSync(support);

  late final String generatedContent;
  switch (variant) {
    case _Variant.currentAll:
      generatedContent = _currentAllSource(familyCount);
      File(
        '${libDir.path}/objc_pattern_${variant.name}.dart',
      ).writeAsStringSync(
        "export 'src/runtime_support.dart';\nexport 'src/bindings.dart';\n",
      );
      File(
        '${libDir.path}/src/bindings.dart',
      ).writeAsStringSync(generatedContent);
    case _Variant.currentSplit:
      final bindings = _currentBindingsOnlySource(familyCount);
      final impl = _currentImplOnlySource(familyCount);
      generatedContent = '$bindings\n$impl';
      File(
        '${libDir.path}/objc_pattern_${variant.name}.dart',
      ).writeAsStringSync(
        "export 'src/runtime_support.dart';\nexport 'src/bindings.dart';\n",
      );
      File('${libDir.path}/impl.dart').writeAsStringSync(
        "export 'src/runtime_support.dart';\nexport 'src/bindings.dart';\nexport 'src/impl.dart';\n",
      );
      File('${libDir.path}/src/bindings.dart').writeAsStringSync(bindings);
      File('${libDir.path}/src/impl.dart').writeAsStringSync(impl);
    case _Variant.thinRuntime:
      generatedContent = _thinRuntimeSource(familyCount);
      File(
        '${libDir.path}/objc_pattern_${variant.name}.dart',
      ).writeAsStringSync(
        "export 'src/runtime_support.dart';\nexport 'src/bindings.dart';\n",
      );
      File(
        '${libDir.path}/src/bindings.dart',
      ).writeAsStringSync(generatedContent);
  }

  return '$support\n$generatedContent';
}

Future<Directory> _writeHarness({
  required Directory appsDir,
  required Directory packageDir,
  required _Variant variant,
  required _HarnessKind harnessKind,
  required _DependencyMode dependencyMode,
}) async {
  final appDir = Directory(
    '${appsDir.path}/${variant.name}_${harnessKind.name}_${dependencyMode.name}',
  );
  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
  Directory('${appDir.path}/bin').createSync(recursive: true);
  Directory('${appDir.path}/build').createSync(recursive: true);

  File('${appDir.path}/pubspec.yaml').writeAsStringSync('''
name: ${variant.name}_${harnessKind.name}
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
${_dependencySpec(packageName: 'objc_pattern_${variant.name}', packageDir: packageDir, dependencyMode: dependencyMode)}
''');

  File('${appDir.path}/bin/main.dart').writeAsStringSync(
    _harnessSource(variant: variant, harnessKind: harnessKind),
  );

  await _runChecked(
    workingDirectory: appDir.path,
    arguments: const ['pub', 'get'],
  );
  return appDir;
}

String _dependencySpec({
  required String packageName,
  required Directory packageDir,
  required _DependencyMode dependencyMode,
}) {
  switch (dependencyMode) {
    case _DependencyMode.path:
      return '''
  $packageName:
    path: ${packageDir.path}''';
    case _DependencyMode.git:
      return '''
  $packageName:
    git:
      url: file://${packageDir.path}''';
  }
}

Future<void> _initializeGitRepo(Directory packageDir) async {
  await _runProcessChecked(
    executable: 'git',
    arguments: const ['init', '-q'],
    workingDirectory: packageDir.path,
  );
  await _runProcessChecked(
    executable: 'git',
    arguments: const ['config', 'user.email', 'bench@example.com'],
    workingDirectory: packageDir.path,
  );
  await _runProcessChecked(
    executable: 'git',
    arguments: const ['config', 'user.name', 'benchmark'],
    workingDirectory: packageDir.path,
  );
  await _runProcessChecked(
    executable: 'git',
    arguments: const ['add', '.'],
    workingDirectory: packageDir.path,
  );
  await _runProcessChecked(
    executable: 'git',
    arguments: const ['commit', '-q', '-m', 'init'],
    workingDirectory: packageDir.path,
  );
}

String _runtimeSupportSource() => '''
library runtime_support;

abstract interface class ObjCObject {
  ObjCRef get ref;
}

abstract interface class NSObjectProtocol {}

abstract interface class ObjCProtocol implements ObjCObject, NSObjectProtocol {}

final class ObjCRef {
  const ObjCRef(this.pointer);

  final int pointer;

  int retainAndReturnPointer() => pointer;
}

final class ObjCObjectBox implements ObjCObject {
  const ObjCObjectBox(this.ref);

  @override
  final ObjCRef ref;
}

final class ObjCProtocolBox extends ObjCObjectBox implements ObjCProtocol {
  const ObjCProtocolBox(super.ref);
}

final class Protocol {
  const Protocol(this.pointer);

  final int pointer;

  factory Protocol.fromPointer(int pointer) => Protocol(pointer);
}

final class NSStringBox extends ObjCObjectBox {
  const NSStringBox(super.ref);
}

extension type NSString._(ObjCObject object\$) implements ObjCObject {
  NSString.as(ObjCObject other) : object\$ = other;

  NSString.fromPointer(int other) : object\$ = ObjCObjectBox(ObjCRef(other));
}

ObjCObject objectFromInt(int value) => ObjCObjectBox(ObjCRef(value));

ObjCProtocol protocolFromInt(int value) => ObjCProtocolBox(ObjCRef(value));

int registerName(String name) => name.hashCode;

int getClass(String name) => name.hashCode;

int getProtocol(String name) => name.hashCode;

bool respondsToSelector(int pointer, int selector) =>
    pointer >= 0 && selector >= 0;

int invokeInt(ObjCObject object, int selectorIndex, int seed) =>
    object.ref.pointer + selectorIndex + seed;

ObjCObject? invokeObject(ObjCObject object, int selectorIndex, int seed) {
  final value = object.ref.pointer + selectorIndex + seed;
  return value.isEven ? null : ObjCObjectBox(ObjCRef(value));
}

void invokeVoid(ObjCObject object, int selectorIndex, int seed) {
  final _ = object.ref.pointer + selectorIndex + seed;
}

final class ObjCProtocolBuilder {
  const ObjCProtocolBuilder({required this.debugName});

  final String debugName;

  void addProtocol(Protocol protocol) {}

  ObjCObject build({bool keepIsolateAlive = true}) =>
      ObjCProtocolBox(ObjCRef(debugName.hashCode));
}

class ObjCProtocolMethod<T> {
  const ObjCProtocolMethod(this.name);

  final String name;

  bool get isAvailable => true;

  void implement(ObjCProtocolBuilder builder, T? implementation) {}

  void implementAsListener(ObjCProtocolBuilder builder, T? implementation) {}

  void implementAsBlocking(ObjCProtocolBuilder builder, T? implementation) {}
}

final class ObjCProtocolListenableMethod<T> extends ObjCProtocolMethod<T> {
  const ObjCProtocolListenableMethod(super.name);
}
''';

String _currentAllSource(int familyCount) {
  final out = StringBuffer()
    ..writeln("import 'runtime_support.dart' as objc;")
    ..writeln();
  for (var i = 0; i < familyCount; i++) {
    _writeFamilyBindings(out, i);
    _writeFamilyImpl(out, i);
  }
  _writeCurrentBottomMatter(out, familyCount);
  return out.toString();
}

String _currentBindingsOnlySource(int familyCount) {
  final out = StringBuffer()
    ..writeln("import 'runtime_support.dart' as objc;")
    ..writeln();
  for (var i = 0; i < familyCount; i++) {
    _writeFamilyBindings(out, i);
  }
  _writeCurrentBottomMatter(out, familyCount);
  return out.toString();
}

String _currentImplOnlySource(int familyCount) {
  final out = StringBuffer()
    ..writeln("import 'runtime_support.dart' as objc;")
    ..writeln("import 'bindings.dart';")
    ..writeln();
  for (var i = 0; i < familyCount; i++) {
    _writeFamilyImpl(out, i);
  }
  return out.toString();
}

String _thinRuntimeSource(int familyCount) {
  final out = StringBuffer()
    ..writeln("import 'runtime_support.dart' as objc;")
    ..writeln();
  out
    ..writeln('const _selectorSlots = <int>[')
    ..writeln('  // 7 slots per family: 4 protocol, 3 descriptor.')
    ..writeln();
  for (var i = 0; i < familyCount * 7; i++) {
    out.writeln('  $i,');
  }
  out.writeln('];');
  out.writeln();

  for (var i = 0; i < familyCount; i++) {
    final base = i * 7;
    out
      ..writeln('/// MTL4CommandAllocatorFamily$i')
      ..writeln(
        'extension type MTL4CommandAllocatorFamily$i._(objc.ObjCProtocol object\$)',
      )
      ..writeln('    implements objc.ObjCProtocol, objc.NSObjectProtocol {')
      ..writeln(
        '  MTL4CommandAllocatorFamily$i.as(objc.ObjCObject other) : object\$ = objc.protocolFromInt(other.ref.pointer);',
      )
      ..writeln(
        '  MTL4CommandAllocatorFamily$i.fromPointer(int other) : object\$ = objc.protocolFromInt(other);',
      )
      ..writeln('}')
      ..writeln()
      ..writeln(
        'extension MTL4CommandAllocatorFamily$i\$Methods on MTL4CommandAllocatorFamily$i {',
      )
      ..writeln(
        '  int get allocatedSize => objc.invokeInt(object\$, _selectorSlots[$base], $i);',
      )
      ..writeln(
        '  objc.ObjCObject? get device => objc.invokeObject(object\$, _selectorSlots[${base + 1}], $i);',
      )
      ..writeln(
        '  objc.NSString? get label => switch (objc.invokeObject(object\$, _selectorSlots[${base + 2}], $i)) {',
      )
      ..writeln('    null => null,')
      ..writeln('    final value => objc.NSString.as(value),')
      ..writeln('  };')
      ..writeln(
        '  void reset() => objc.invokeVoid(object\$, _selectorSlots[${base + 3}], $i);',
      )
      ..writeln('}')
      ..writeln()
      ..writeln('/// MTL4CommandAllocatorDescriptorFamily$i')
      ..writeln(
        'extension type MTL4CommandAllocatorDescriptorFamily$i._(objc.ObjCObject object\$)',
      )
      ..writeln('    implements objc.ObjCObject {')
      ..writeln(
        '  MTL4CommandAllocatorDescriptorFamily$i.as(objc.ObjCObject other) : object\$ = other;',
      )
      ..writeln(
        '  MTL4CommandAllocatorDescriptorFamily$i.fromPointer(int other) : object\$ = objc.objectFromInt(other);',
      )
      ..writeln(
        '  static MTL4CommandAllocatorDescriptorFamily$i alloc() => MTL4CommandAllocatorDescriptorFamily$i.fromPointer($i);',
      )
      ..writeln(
        '  static MTL4CommandAllocatorDescriptorFamily$i new\$() => MTL4CommandAllocatorDescriptorFamily$i.fromPointer(${i + 1});',
      )
      ..writeln('}')
      ..writeln()
      ..writeln(
        'extension MTL4CommandAllocatorDescriptorFamily$i\$Methods on MTL4CommandAllocatorDescriptorFamily$i {',
      )
      ..writeln(
        '  MTL4CommandAllocatorDescriptorFamily$i init() => MTL4CommandAllocatorDescriptorFamily$i.fromPointer(objc.invokeInt(object\$, _selectorSlots[${base + 4}], $i));',
      )
      ..writeln(
        '  objc.NSString? get label => switch (objc.invokeObject(object\$, _selectorSlots[${base + 5}], $i)) {',
      )
      ..writeln('    null => null,')
      ..writeln('    final value => objc.NSString.as(value),')
      ..writeln('  };')
      ..writeln(
        '  set label\$1(objc.NSString? value) => objc.invokeVoid(object\$, _selectorSlots[${base + 6}], value?.ref.pointer ?? 0);',
      )
      ..writeln('}')
      ..writeln();
  }
  return out.toString();
}

void _writeFamilyBindings(StringBuffer out, int i) {
  out
    ..writeln('/// MTL4CommandAllocatorFamily$i')
    ..writeln(
      'extension type MTL4CommandAllocatorFamily$i._(objc.ObjCProtocol object\$)',
    )
    ..writeln('    implements objc.ObjCProtocol, objc.NSObjectProtocol {')
    ..writeln(
      '  MTL4CommandAllocatorFamily$i.as(objc.ObjCObject other) : object\$ = objc.protocolFromInt(other.ref.pointer);',
    )
    ..writeln(
      '  MTL4CommandAllocatorFamily$i.fromPointer(int other) : object\$ = objc.protocolFromInt(other);',
    )
    ..writeln(
      '  static bool conformsTo(objc.ObjCObject obj) => objc.respondsToSelector(obj.ref.pointer, _sel_family${i}_allocatedSize);',
    )
    ..writeln('}')
    ..writeln()
    ..writeln(
      'extension MTL4CommandAllocatorFamily$i\$Methods on MTL4CommandAllocatorFamily$i {',
    )
    ..writeln(
      '  int get allocatedSize => _objc_msgSend_int(object\$.ref.pointer, _sel_family${i}_allocatedSize);',
    )
    ..writeln(
      '  objc.ObjCObject? get device => _objOrNull(_objc_msgSend_object(object\$.ref.pointer, _sel_family${i}_device));',
    )
    ..writeln(
      '  objc.NSString? get label => _stringOrNull(_objc_msgSend_object(object\$.ref.pointer, _sel_family${i}_label));',
    )
    ..writeln(
      '  void reset() => _objc_msgSend_void(object\$.ref.pointer, _sel_family${i}_reset);',
    )
    ..writeln('}')
    ..writeln()
    ..writeln('/// MTL4CommandAllocatorDescriptorFamily$i')
    ..writeln(
      'extension type MTL4CommandAllocatorDescriptorFamily$i._(objc.ObjCObject object\$)',
    )
    ..writeln('    implements objc.ObjCObject {')
    ..writeln(
      '  MTL4CommandAllocatorDescriptorFamily$i.as(objc.ObjCObject other) : object\$ = other;',
    )
    ..writeln(
      '  MTL4CommandAllocatorDescriptorFamily$i.fromPointer(int other) : object\$ = objc.objectFromInt(other);',
    )
    ..writeln(
      '  static bool isA(objc.ObjCObject? obj) => obj != null && obj.ref.pointer >= 0;',
    )
    ..writeln(
      '  static MTL4CommandAllocatorDescriptorFamily$i alloc() => MTL4CommandAllocatorDescriptorFamily$i.fromPointer(_objc_msgSend_object(_class_family${i}_descriptor, _sel_family${i}_alloc));',
    )
    ..writeln(
      '  static MTL4CommandAllocatorDescriptorFamily$i new\$() => MTL4CommandAllocatorDescriptorFamily$i.fromPointer(_objc_msgSend_object(_class_family${i}_descriptor, _sel_family${i}_new));',
    )
    ..writeln('}')
    ..writeln()
    ..writeln(
      'extension MTL4CommandAllocatorDescriptorFamily$i\$Methods on MTL4CommandAllocatorDescriptorFamily$i {',
    )
    ..writeln(
      '  MTL4CommandAllocatorDescriptorFamily$i init() => MTL4CommandAllocatorDescriptorFamily$i.fromPointer(_objc_msgSend_object(object\$.ref.retainAndReturnPointer(), _sel_family${i}_init));',
    )
    ..writeln(
      '  objc.NSString? get label => _stringOrNull(_objc_msgSend_object(object\$.ref.pointer, _sel_family${i}_descriptorLabel));',
    )
    ..writeln(
      '  set label\$1(objc.NSString? value) => _objc_msgSend_setObject(object\$.ref.pointer, _sel_family${i}_setDescriptorLabel, value?.ref.pointer ?? 0);',
    )
    ..writeln('}')
    ..writeln();
}

void _writeFamilyImpl(StringBuffer out, int i) {
  out
    ..writeln('abstract interface class MTL4CommandAllocatorFamily${i}Spec {')
    ..writeln('  int get allocatedSize;')
    ..writeln('  objc.ObjCObject? get device;')
    ..writeln('  objc.NSString? get label;')
    ..writeln('  void reset();')
    ..writeln('}')
    ..writeln()
    ..writeln(
      'abstract interface class MTL4CommandAllocatorFamily${i}Optional {}',
    )
    ..writeln()
    ..writeln('interface class MTL4CommandAllocatorFamily$i\$Builder {')
    ..writeln(
      "  static objc.Protocol get \$protocol => objc.Protocol.fromPointer(objc.getProtocol('MTL4CommandAllocatorFamily$i'));",
    )
    ..writeln('  static MTL4CommandAllocatorFamily$i implement({')
    ..writeln('    required int Function() allocatedSize,')
    ..writeln('    required objc.ObjCObject? Function() device,')
    ..writeln('    required objc.NSString? Function() label,')
    ..writeln('    required void Function() reset,')
    ..writeln('    bool \$keepIsolateAlive = true,')
    ..writeln('  }) {')
    ..writeln(
      "    final builder = objc.ObjCProtocolBuilder(debugName: 'MTL4CommandAllocatorFamily$i');",
    )
    ..writeln(
      '    MTL4CommandAllocatorFamily$i\$Builder.allocatedSize.implement(builder, allocatedSize);',
    )
    ..writeln(
      '    MTL4CommandAllocatorFamily$i\$Builder.device.implement(builder, device);',
    )
    ..writeln(
      '    MTL4CommandAllocatorFamily$i\$Builder.label.implement(builder, label);',
    )
    ..writeln(
      '    MTL4CommandAllocatorFamily$i\$Builder.reset.implement(builder, reset);',
    )
    ..writeln('    builder.addProtocol(\$protocol);')
    ..writeln(
      '    return MTL4CommandAllocatorFamily$i.as(builder.build(keepIsolateAlive: \$keepIsolateAlive));',
    )
    ..writeln('  }')
    ..writeln()
    ..writeln(
      '  static MTL4CommandAllocatorFamily$i implementFrom(MTL4CommandAllocatorFamily${i}Spec implementation, {bool \$keepIsolateAlive = true}) => implement(',
    )
    ..writeln('    allocatedSize: () => implementation.allocatedSize,')
    ..writeln('    device: () => implementation.device,')
    ..writeln('    label: () => implementation.label,')
    ..writeln('    reset: implementation.reset,')
    ..writeln('    \$keepIsolateAlive: \$keepIsolateAlive,')
    ..writeln('  );')
    ..writeln()
    ..writeln(
      "  static const allocatedSize = objc.ObjCProtocolMethod<int Function()>('allocatedSize');",
    )
    ..writeln(
      "  static const device = objc.ObjCProtocolMethod<objc.ObjCObject? Function()>('device');",
    )
    ..writeln(
      "  static const label = objc.ObjCProtocolMethod<objc.NSString? Function()>('label');",
    )
    ..writeln(
      "  static const reset = objc.ObjCProtocolListenableMethod<void Function()>('reset');",
    )
    ..writeln('}')
    ..writeln()
    ..writeln('mixin MTL4CommandAllocatorFamily${i}Adapter {')
    ..writeln(
      '  late final MTL4CommandAllocatorFamily$i asMTL4CommandAllocatorFamily$i =',
    )
    ..writeln(
      '      MTL4CommandAllocatorFamily$i\$Builder.implementFrom(this as MTL4CommandAllocatorFamily${i}Spec);',
    )
    ..writeln('}')
    ..writeln();
}

void _writeCurrentBottomMatter(StringBuffer out, int familyCount) {
  out
    ..writeln(
      'int _objc_msgSend_int(int object, int selector) => object + selector;',
    )
    ..writeln(
      'int _objc_msgSend_object(int object, int selector) => object + selector + 1;',
    )
    ..writeln('void _objc_msgSend_void(int object, int selector) {')
    ..writeln('  final _ = object + selector;')
    ..writeln('}')
    ..writeln(
      'void _objc_msgSend_setObject(int object, int selector, int value) {',
    )
    ..writeln('  final _ = object + selector + value;')
    ..writeln('}')
    ..writeln()
    ..writeln(
      'objc.ObjCObject? _objOrNull(int value) => value.isEven ? null : objc.objectFromInt(value);',
    )
    ..writeln(
      'objc.NSString? _stringOrNull(int value) => value.isEven ? null : objc.NSString.fromPointer(value);',
    )
    ..writeln();

  for (var i = 0; i < familyCount; i++) {
    out
      ..writeln(
        'late final _protocol_family${i}_allocator = objc.getProtocol("MTL4CommandAllocatorFamily$i");',
      )
      ..writeln(
        'late final _class_family${i}_descriptor = objc.getClass("MTL4CommandAllocatorDescriptorFamily$i");',
      )
      ..writeln(
        'late final _sel_family${i}_allocatedSize = objc.registerName("allocatedSize");',
      )
      ..writeln(
        'late final _sel_family${i}_device = objc.registerName("device");',
      )
      ..writeln(
        'late final _sel_family${i}_label = objc.registerName("label");',
      )
      ..writeln(
        'late final _sel_family${i}_reset = objc.registerName("reset");',
      )
      ..writeln(
        'late final _sel_family${i}_alloc = objc.registerName("alloc");',
      )
      ..writeln('late final _sel_family${i}_new = objc.registerName("new");')
      ..writeln('late final _sel_family${i}_init = objc.registerName("init");')
      ..writeln(
        'late final _sel_family${i}_descriptorLabel = objc.registerName("label");',
      )
      ..writeln(
        'late final _sel_family${i}_setDescriptorLabel = objc.registerName("setLabel:");',
      )
      ..writeln();
  }
}

String _harnessSource({
  required _Variant variant,
  required _HarnessKind harnessKind,
}) {
  final packageName = 'objc_pattern_${variant.name}';
  final importPath =
      harnessKind == _HarnessKind.implementer &&
          variant == _Variant.currentSplit
      ? 'package:$packageName/impl.dart'
      : 'package:$packageName/$packageName.dart';
  switch (harnessKind) {
    case _HarnessKind.consumer:
      return '''
import '$importPath';

void main() {
  final allocator = MTL4CommandAllocatorFamily0.fromPointer(1);
  final descriptor = MTL4CommandAllocatorDescriptorFamily0.fromPointer(2);
  final values = <Object?>[
    allocator.allocatedSize,
    allocator.device,
    allocator.label,
    descriptor.init(),
    descriptor.label,
  ];
  print(values.length);
}
''';
    case _HarnessKind.implementer:
      return '''
import '$importPath';

final class AllocatorImpl with MTL4CommandAllocatorFamily0Adapter implements MTL4CommandAllocatorFamily0Spec {
  @override
  int get allocatedSize => 1;

  @override
  ObjCObject? get device => null;

  @override
  NSString? get label => null;

  @override
  void reset() {}
}

void main() {
  final impl = AllocatorImpl();
  print(impl.asMTL4CommandAllocatorFamily0.ref.pointer);
}
''';
  }
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
  await _runProcessChecked(
    executable: 'dart',
    arguments: arguments,
    workingDirectory: workingDirectory,
  );
}

Future<void> _runProcessChecked({
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

void _printResults(List<_BenchmarkResult> results) {
  for (final result in results) {
    stdout.writeln(
      '${result.variant.name}_${result.harnessKind.name}_${result.dependencyMode.name}: '
      '${_mib(result.generatedBytes)} MiB, ${result.generatedLines} lines, '
      'analyze ${result.analyzeMs} ms / ${_mib(result.analyzeMaxRssBytes)} MiB, '
      'kernel ${result.kernelMs} ms / ${_mib(result.kernelMaxRssBytes)} MiB',
    );
  }
}

String _mib(int bytes) => (bytes / (1024 * 1024)).toStringAsFixed(1);
