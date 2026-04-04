// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:io';

import 'package:ffigen/ffigen.dart';
import 'package:ffigen/src/config_provider/spec_utils.dart' as spec_utils;
import 'package:logging/logging.dart';

enum _GenerationProfile { full, lean }
enum _RootSurface { umbrella, coreOnly }

final class _ResolvedInvocation {
  const _ResolvedInvocation({
    required this.targets,
    required this.profile,
    required this.rootSurface,
  });

  final List<String> targets;
  final _GenerationProfile profile;
  final _RootSurface rootSurface;
}

final class _SplitUnit {
  const _SplitUnit({
    required this.key,
    required this.libraryStem,
    required this.includeDeclaration,
  });

  final String key;
  final String libraryStem;
  final bool Function(Declaration declaration) includeDeclaration;
}

final class _SplitPackageSpec {
  const _SplitPackageSpec({
    required this.packageDir,
    required this.packageName,
    required this.rootUnitKey,
    required this.units,
  });

  final String packageDir;
  final String packageName;
  final String rootUnitKey;
  final List<_SplitUnit> units;
}

final _frameworks = <String, _FrameworkSpec>{
  'foundation': const _FrameworkSpec(
    key: 'foundation',
    packageDir: 'objc-foundation',
    packageName: 'objc_foundation',
    framework: 'Foundation',
    umbrellaHeader: 'Foundation.h',
    dylibName: 'foundation_bindings.dylib',
    generatedBase: 'foundation',
    frameworkLoadOrder: ['Foundation'],
    sdk: _AppleSdk.macOS,
    runtimeFrameworkPaths: [
      '/System/Library/Frameworks/Foundation.framework/Versions/Current/Foundation',
    ],
  ),
  'appkit': const _FrameworkSpec(
    key: 'appkit',
    packageDir: 'objc-appkit',
    packageName: 'objc_appkit',
    framework: 'AppKit',
    umbrellaHeader: 'AppKit.h',
    dylibName: 'appkit_bindings.dylib',
    generatedBase: 'appkit',
    frameworkLoadOrder: ['Foundation', 'AppKit'],
    sdk: _AppleSdk.macOS,
    runtimeFrameworkPaths: [
      '/System/Library/Frameworks/Foundation.framework/Versions/Current/Foundation',
      '/System/Library/Frameworks/AppKit.framework/Versions/Current/AppKit',
    ],
  ),
  'uikit': const _FrameworkSpec(
    key: 'uikit',
    packageDir: 'objc-uikit',
    packageName: 'objc_uikit',
    framework: 'UIKit',
    umbrellaHeader: 'UIKit.h',
    dylibName: 'uikit_bindings.dylib',
    generatedBase: 'uikit',
    frameworkLoadOrder: ['Foundation', 'UIKit'],
    sdk: _AppleSdk.iOSSimulator,
    runtimeFrameworkPaths: [
      '/System/Library/Frameworks/Foundation.framework/Foundation',
      '/System/Library/Frameworks/UIKit.framework/UIKit',
    ],
  ),
  'metal': const _FrameworkSpec(
    key: 'metal',
    packageDir: 'objc-metal',
    packageName: 'objc_metal',
    framework: 'Metal',
    umbrellaHeader: 'Metal.h',
    dylibName: 'metal_bindings.dylib',
    generatedBase: 'metal',
    frameworkLoadOrder: ['Foundation', 'Metal'],
    sdk: _AppleSdk.macOS,
    runtimeFrameworkPaths: [
      '/System/Library/Frameworks/Foundation.framework/Versions/Current/Foundation',
      '/System/Library/Frameworks/Metal.framework/Versions/Current/Metal',
    ],
  ),
  'metalkit': const _FrameworkSpec(
    key: 'metalkit',
    packageDir: 'objc-metalkit',
    packageName: 'objc_metalkit',
    framework: 'MetalKit',
    umbrellaHeader: 'MetalKit.h',
    dylibName: 'metalkit_bindings.dylib',
    generatedBase: 'metalkit',
    frameworkLoadOrder: ['Foundation', 'Metal', 'MetalKit'],
    sdk: _AppleSdk.macOS,
    runtimeFrameworkPaths: [
      '/System/Library/Frameworks/Foundation.framework/Versions/Current/Foundation',
      '/System/Library/Frameworks/Metal.framework/Versions/Current/Metal',
      '/System/Library/Frameworks/MetalKit.framework/Versions/Current/MetalKit',
    ],
  ),
};

final _splitPackages = <String, _SplitPackageSpec>{
  'appkit': const _SplitPackageSpec(
    packageDir: 'objc-appkit',
    packageName: 'objc_appkit',
    rootUnitKey: 'core',
    units: _appkitSplitUnits,
  ),
  'metal': const _SplitPackageSpec(
    packageDir: 'objc-metal',
    packageName: 'objc_metal',
    rootUnitKey: 'core',
    units: _metalSplitUnits,
  ),
  'uikit': const _SplitPackageSpec(
    packageDir: 'objc-uikit',
    packageName: 'objc_uikit',
    rootUnitKey: 'core',
    units: _uikitSplitUnits,
  ),
};

Future<void> main(List<String> args) async {
  final invocation = _resolveInvocation(args);
  final rootDir = Directory.current.absolute;
  final packagesDir = Directory('${rootDir.path}/packages');
  await packagesDir.create(recursive: true);

  for (final key in invocation.targets) {
    final spec = _frameworks[key]!;
    final sdkPath = _sdkPathFor(spec.sdk);
    final packageDirName = _packageDirFor(spec);
    final packageName = _packageNameFor(spec);
    final pkgDir = Directory('${packagesDir.path}/$packageDirName');
    if (_usesSplitLayout(spec) && pkgDir.existsSync()) {
      _cleanSplitPackageOutputs(spec, pkgDir);
    }
    await _scaffoldPackage(
      spec,
      pkgDir,
      packageName: packageName,
    );
    _generateBindings(
      spec,
      pkgDir,
      sdkPath,
      invocation.profile,
      invocation.rootSurface,
      packageName: packageName,
    );
    stdout.writeln('Generated $packageName at ${pkgDir.path}');
  }
}

void _cleanSplitPackageOutputs(_FrameworkSpec spec, Directory pkgDir) {
  final libDir = Directory('${pkgDir.path}/lib');
  if (libDir.existsSync()) {
    for (final entity in libDir.listSync(followLinks: false)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        entity.deleteSync();
      }
    }
  }

  final srcDir = Directory('${pkgDir.path}/lib/src');
  if (srcDir.existsSync()) {
    for (final entity in srcDir.listSync(followLinks: false)) {
      if (entity is! File) continue;
      final name = entity.uri.pathSegments.last;
      final isGeneratedBinding = name.startsWith('${spec.generatedBase}_') &&
          (name.endsWith('_bindings.dart') || name.endsWith('_symbols.yaml'));
      if (isGeneratedBinding) {
        entity.deleteSync();
      }
    }
  }

  final nativeDir = Directory('${pkgDir.path}/native');
  if (nativeDir.existsSync()) {
    for (final entity in nativeDir.listSync(followLinks: false)) {
      if (entity is! File) continue;
      final name = entity.uri.pathSegments.last;
      final isGeneratedObjc = name.startsWith('${spec.generatedBase}_') &&
          name.endsWith('_bindings.m');
      if (isGeneratedObjc) {
        entity.deleteSync();
      }
    }
  }
}

String _packageDirFor(_FrameworkSpec spec) =>
    _splitPackages[spec.key]?.packageDir ?? spec.packageDir;

String _packageNameFor(_FrameworkSpec spec) =>
    _splitPackages[spec.key]?.packageName ?? spec.packageName;

_ResolvedInvocation _resolveInvocation(List<String> args) {
  var profile = _GenerationProfile.full;
  var rootSurface = _RootSurface.coreOnly;
  final targets = <String>[];

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--help' || arg == '-h') {
      stdout.writeln('''
Usage: dart tool/gen_objc_packages.dart [--profile full|lean] [--root-surface umbrella|core-only] [targets...]

Targets:
  ${_frameworks.keys.join(', ')}

Profiles:
  full  Generate the current full transitive surface.
  lean  Generate a smaller, less-transitive surface for faster tooling.

Root surfaces:
  umbrella   Root library re-exports all generated family libraries via all.dart.
  core-only  Root library exports only core.dart; family APIs rely on direct imports or auto-import.
''');
      exit(0);
    }
    if (arg == '--profile') {
      if (i + 1 >= args.length) {
        stderr.writeln('Missing value for --profile. Use "full" or "lean".');
        exitCode = 64;
        exit(exitCode);
      }
      profile = _parseProfile(args[++i]);
      continue;
    }
    if (arg.startsWith('--profile=')) {
      profile = _parseProfile(arg.substring('--profile='.length));
      continue;
    }
    if (arg == '--root-surface' || arg == '--split-root') {
      if (i + 1 >= args.length) {
        stderr.writeln(
          'Missing value for --root-surface. Use "umbrella" or "core-only".',
        );
        exitCode = 64;
        exit(exitCode);
      }
      rootSurface = _parseRootSurface(args[++i]);
      continue;
    }
    if (arg.startsWith('--root-surface=')) {
      rootSurface = _parseRootSurface(
        arg.substring('--root-surface='.length),
      );
      continue;
    }
    if (arg.startsWith('--split-root=')) {
      rootSurface = _parseRootSurface(
        arg.substring('--split-root='.length),
      );
      continue;
    }
    targets.add(arg);
  }

  if (targets.isEmpty) {
    return _ResolvedInvocation(
      targets: _frameworks.keys.toList(growable: false),
      profile: profile,
      rootSurface: rootSurface,
    );
  }

  final lowered = targets.map((a) => a.toLowerCase()).toList(growable: false);
  for (final key in lowered) {
    if (!_frameworks.containsKey(key)) {
      stderr.writeln(
        'Unknown target "$key". Valid targets: ${_frameworks.keys.join(', ')}',
      );
      exitCode = 64;
      exit(exitCode);
    }
  }
  return _ResolvedInvocation(
    targets: lowered,
    profile: profile,
    rootSurface: rootSurface,
  );
}

_GenerationProfile _parseProfile(String value) {
  return switch (value.toLowerCase()) {
    'full' => _GenerationProfile.full,
    'lean' => _GenerationProfile.lean,
    _ => () {
      stderr.writeln('Unknown profile "$value". Valid profiles: full, lean');
      exitCode = 64;
      exit(exitCode);
    }(),
  };
}

_RootSurface _parseRootSurface(String value) {
  return switch (value.toLowerCase()) {
    'umbrella' => _RootSurface.umbrella,
    'core-only' => _RootSurface.coreOnly,
    _ => () {
      stderr.writeln(
        'Unknown root surface "$value". Valid values: umbrella, core-only',
      );
      exitCode = 64;
      exit(exitCode);
    }(),
  };
}

void _generateBindings(
  _FrameworkSpec spec,
  Directory pkgDir,
  String sdkPath,
  _GenerationProfile profile,
  _RootSurface rootSurface,
  {required String packageName}
) {
  if (_usesSplitLayout(spec)) {
    _generateSplitBindings(
      spec,
      pkgDir,
      sdkPath,
      profile,
      rootSurface: rootSurface,
      packageName: packageName,
    );
    return;
  }

  final header = Uri.file(
    '$sdkPath/System/Library/Frameworks/${spec.framework}.framework/Headers/${spec.umbrellaHeader}',
  );
  final dartOut = Uri.file(
    '${pkgDir.path}/lib/src/${spec.generatedBase}_bindings.dart',
  );
  final objcOut = Uri.file(
    '${pkgDir.path}/native/${spec.generatedBase}_bindings.m',
  );

  final generator = FfiGenerator(
    headers: Headers(
      entryPoints: [header],
      compilerOptions: _compilerOptionsFor(spec, sdkPath),
      ignoreSourceErrors: true,
    ),
    objectiveC: _objectiveCConfig(spec, profile),
    output: Output(
      dartFile: dartOut,
      objectiveCFile: objcOut,
      commentType: switch (profile) {
        _GenerationProfile.full => const CommentType.def(),
        _GenerationProfile.lean => const CommentType.none(),
      },
      preamble:
          '// ${profile.name} ${spec.framework} bindings generated by tool/gen_objc_packages.dart',
      style: _usesBundledBindingsAsset(spec)
          ? NativeExternalBindings(
              assetId: 'package:$packageName/${_bindingsAssetName(spec)}',
            )
          : const NativeExternalBindings(),
    ),
  );
  generator.generate();
}

void _generateSplitBindings(
  _FrameworkSpec spec,
  Directory pkgDir,
  String sdkPath,
  _GenerationProfile profile,
  {required _RootSurface rootSurface,
  required String packageName}
) {
  if (profile != _GenerationProfile.full) {
    throw UnsupportedError(
      'Split layout currently only supports the full profile.',
    );
  }
  final splitSpec = _splitPackages[spec.key];
  if (splitSpec == null) {
    throw UnsupportedError(
      'Split layout is currently implemented for: ${_splitPackages.keys.join(', ')}.',
    );
  }

  final logger = Logger('gen_objc_packages.split');
  Logger.root.level = Level.OFF;
  final importLibraries = <String, LibraryImport>{};
  final importedTypesByUsr = <String, ImportedType>{};
  final generatedFiles = <String, File>{};

  for (final unit in splitSpec.units) {
    final symbolFile = File('${pkgDir.path}/lib/src/${unit.libraryStem}_symbols.yaml');
    _makeSplitGenerator(
      spec: spec,
      pkgDir: pkgDir,
      sdkPath: sdkPath,
      packageName: packageName,
      libraryStem: unit.libraryStem,
      includeDeclaration: unit.includeDeclaration,
      importedTypesByUsr: Map<String, ImportedType>.from(importedTypesByUsr),
      libraryImports: importLibraries.values.toList(),
      symbolFile: SymbolFile(
        Uri.parse('package:$packageName/src/${unit.libraryStem}_bindings.dart'),
        symbolFile.uri,
      ),
    ).generate(logger: logger);

    generatedFiles[unit.key] = File(
      '${pkgDir.path}/lib/src/${unit.libraryStem}_bindings.dart',
    );

    final newlyImported = spec_utils.symbolFileImportExtractor(
      logger,
      [symbolFile.path],
      importLibraries,
      null,
      null,
    );
    importedTypesByUsr.addAll(newlyImported);
  }

  final owners = <String, String>{};
  final ownerIsStub = <String, bool>{};
  for (final unit in splitSpec.units) {
    final typeStates = _topLevelTypeStates(generatedFiles[unit.key]!);
    for (final entry in typeStates.entries) {
      final existingOwner = owners[entry.key];
      if (existingOwner == null) {
        owners[entry.key] = unit.key;
        ownerIsStub[entry.key] = entry.value;
        continue;
      }
      if (ownerIsStub[entry.key]! && !entry.value) {
        owners[entry.key] = unit.key;
        ownerIsStub[entry.key] = false;
      }
    }
  }

  for (final unit in splitSpec.units) {
    final hiddenNames =
        _topLevelTypeNames(generatedFiles[unit.key]!)
            .where((name) => owners[name] != unit.key)
            .toList()
          ..sort();
    final unitBuffer = StringBuffer()
      ..writeln(
        "export 'src/${unit.libraryStem}_bindings.dart'${_hideClause(hiddenNames)};",
      );
    if (spec.key == 'appkit' && unit.key == 'core') {
      unitBuffer.writeln("export 'src/target_action.dart';");
    }
    File('${pkgDir.path}/lib/${unit.key}.dart').writeAsStringSync(
      unitBuffer.toString(),
    );
  }

  final allBuffer = StringBuffer();
  for (final unit in splitSpec.units) {
    allBuffer.writeln("export '${unit.key}.dart';");
  }
  File('${pkgDir.path}/lib/all.dart').writeAsStringSync(allBuffer.toString());

  final rootLibrary = rootSurface == _RootSurface.coreOnly
      ? '${splitSpec.rootUnitKey}.dart'
      : 'all.dart';
  File('${pkgDir.path}/lib/$packageName.dart').writeAsStringSync(
    "export '$rootLibrary';\n",
  );
}

Set<String> _topLevelTypeNames(File file) {
  final text = file.readAsStringSync();
  final regex = RegExp(
    r'^\s*(?:extension type|extension|final class|abstract final class|sealed class|enum|typedef|mixin|abstract interface class|interface class)\s+([A-Za-z0-9_$]+)',
    multiLine: true,
  );
  return regex.allMatches(text).map((match) => match.group(1)!).toSet();
}

Map<String, bool> _topLevelTypeStates(File file) {
  final names = _topLevelTypeNames(file);
  final text = file.readAsStringSync();
  final stubRegex = RegExp(
    r'^/// WARNING: ([A-Za-z0-9_$]+) is a stub\.',
    multiLine: true,
  );
  final stubNames = stubRegex
      .allMatches(text)
      .map((match) => match.group(1)!)
      .toSet();
  return {
    for (final name in names) name: stubNames.contains(name),
  };
}

String _hideClause(List<String> names) =>
    names.isEmpty ? '' : ' hide ${names.join(', ')}';

FfiGenerator _makeSplitGenerator({
  required _FrameworkSpec spec,
  required Directory pkgDir,
  required String sdkPath,
  required String packageName,
  required String libraryStem,
  required bool Function(Declaration declaration) includeDeclaration,
  required Map<String, ImportedType> importedTypesByUsr,
  required List<LibraryImport> libraryImports,
  SymbolFile? symbolFile,
}) {
  return FfiGenerator(
    headers: Headers(
      entryPoints: [
        Uri.file(
          '$sdkPath/System/Library/Frameworks/${spec.framework}.framework/Headers/${spec.umbrellaHeader}',
        ),
      ],
      compilerOptions: _compilerOptionsFor(spec, sdkPath),
      ignoreSourceErrors: true,
    ),
    objectiveC: _splitObjectiveCConfig(spec, includeDeclaration),
    output: Output(
      dartFile: Uri.file('${pkgDir.path}/lib/src/${libraryStem}_bindings.dart'),
      objectiveCFile: Uri.file('${pkgDir.path}/native/${libraryStem}_bindings.m'),
      symbolFile: symbolFile,
      commentType: const CommentType.none(),
      preamble:
          '// split ${spec.framework} bindings generated by tool/gen_objc_packages.dart for $packageName/$libraryStem.',
      style: const NativeExternalBindings(),
    ),
    importedTypesByUsr: importedTypesByUsr,
    libraryImports: libraryImports,
  );
}

ObjectiveC _splitObjectiveCConfig(
  _FrameworkSpec spec,
  bool Function(Declaration declaration) includeDeclaration,
) {
  if (spec.key == 'appkit') {
    bool includeSubclassHelpers(Declaration decl) =>
        decl.originalName == 'NSViewController';

    return ObjectiveC(
      interfaces: Interfaces(
        include: includeDeclaration,
        includeTransitive: false,
        includeSubclassHelpers: includeSubclassHelpers,
      ),
      protocols: Protocols(
        include: includeDeclaration,
        includeTransitive: false,
      ),
      categories: Categories(
        include: includeDeclaration,
        includeTransitive: false,
      ),
    );
  }
  if (spec.key == 'uikit') {
    bool includeSubclassHelpers(Declaration decl) =>
        decl.originalName == 'UIViewController';
    bool includeMember(Declaration decl, String member) {
      if (decl.originalName == 'UIViewController' &&
          member == 'preferredContainerBackgroundStyle') {
        return false;
      }
      if (decl.originalName == 'CIImageProcessorKernel' &&
          (member == 'outputIsOpaque' || member == 'synchronizeInputs')) {
        return false;
      }
      return true;
    }

    return ObjectiveC(
      interfaces: Interfaces(
        include: includeDeclaration,
        includeTransitive: false,
        includeSubclassHelpers: includeSubclassHelpers,
        includeMember: includeMember,
      ),
      protocols: Protocols(
        include: includeDeclaration,
        includeTransitive: false,
      ),
      categories: Categories(
        include: includeDeclaration,
        includeTransitive: false,
      ),
    );
  }

  return ObjectiveC(
    interfaces: Interfaces(
      include: includeDeclaration,
      includeTransitive: false,
    ),
    protocols: Protocols(
      include: includeDeclaration,
      includeTransitive: false,
    ),
    categories: Categories(
      include: includeDeclaration,
      includeTransitive: false,
    ),
  );
}

bool _isMetalArchiveDeclaration(Declaration declaration) =>
    declaration.originalName == 'MTL4Archive';

bool _isMetalArchiveBaseDeclaration(Declaration declaration) {
  final name = declaration.originalName;
  return name.startsWith('MTL4BinaryFunction') ||
      name == 'MTL4FunctionDescriptor' ||
      name.startsWith('MTL4ComputePipelineDescriptor') ||
      name == 'MTL4PipelineDescriptor' ||
      name == 'MTL4PipelineStageDynamicLinkingDescriptor' ||
      name == 'MTL4RenderPipelineDynamicLinkingDescriptor';
}

bool _isMetalCoreDeclaration(Declaration declaration) =>
    declaration.originalName.startsWith('MTL') &&
    !_isMetalArchiveBaseDeclaration(declaration) &&
    !_isMetalArchiveDeclaration(declaration);

const _metalSplitUnits = <_SplitUnit>[
  _SplitUnit(
    key: 'archive_base',
    libraryStem: 'metal_archive_base',
    includeDeclaration: _isMetalArchiveBaseDeclaration,
  ),
  _SplitUnit(
    key: 'archive',
    libraryStem: 'metal_archive',
    includeDeclaration: _isMetalArchiveDeclaration,
  ),
  _SplitUnit(
    key: 'core',
    libraryStem: 'metal_core',
    includeDeclaration: _isMetalCoreDeclaration,
  ),
];

const _appKitCoreExactNames = <String>{
  'NSApplication',
  'NSApplicationDelegate',
  'NSButton',
  'NSButtonTargetAction',
  'NSBox',
  'NSColor',
  'NSFont',
  'NSNotification',
  'NSResponder',
  'NSTextField',
  'NSView',
  'NSViewController',
  'NSVisualEffectView',
  'NSWindow',
};

const _appKitCorePrefixes = <String>[
  'NSApplicationActivationPolicy',
  'NSApplicationTerminateReply',
  'NSAutoresizing',
  'NSBacking',
  'NSBezel',
  'NSBoxType',
  'NSColor',
  'NSControl',
  'NSFont',
  'NSText',
  'NSTitle',
  'NSView',
  'NSVisualEffect',
  'NSWindow',
];

bool _isAppKitCoreDeclaration(Declaration declaration) {
  final name = declaration.originalName;
  return _matchesAnyExact(name, _appKitCoreExactNames) ||
      _matchesAnyPrefix(name, _appKitCorePrefixes);
}

bool _isAppKitMiscDeclaration(Declaration declaration) =>
    declaration.originalName.startsWith('NS') &&
    !_isAppKitCoreDeclaration(declaration);

const _appkitSplitUnits = <_SplitUnit>[
  _SplitUnit(
    key: 'core',
    libraryStem: 'appkit_core',
    includeDeclaration: _isAppKitCoreDeclaration,
  ),
  _SplitUnit(
    key: 'misc',
    libraryStem: 'appkit_misc',
    includeDeclaration: _isAppKitMiscDeclaration,
  ),
];

bool _isUiKitGestureBaseDeclaration(Declaration declaration) {
  final name = declaration.originalName;
  return name.startsWith('UIGestureRecognizer') &&
      !_isUiKitGestureDeclaration(declaration);
}

bool _isUiKitGestureDeclaration(Declaration declaration) {
  final name = declaration.originalName;
  return name == 'UILongPressGestureRecognizer' ||
      name == 'UIPanGestureRecognizer' ||
      name == 'UIPinchGestureRecognizer' ||
      name == 'UIRotationGestureRecognizer' ||
      name == 'UIScreenEdgePanGestureRecognizer' ||
      name == 'UISwipeGestureRecognizer' ||
      name.startsWith('UISwipeGestureRecognizerDirection') ||
      name == 'UITapGestureRecognizer';
}

bool _matchesAnyPrefix(String name, List<String> prefixes) =>
    prefixes.any(name.startsWith);

bool _matchesAnyExact(String name, Set<String> exactNames) =>
    exactNames.contains(name);

const _uiKitCoreExactNames = <String>{
  'UIAppearance',
  'UIAppearanceContainer',
  'UIApplicationShortcutItem',
  'UIApplicationShortcutWidget',
  'UIApplicationShortcutIcon',
  'UIContentContainer',
  'UICoordinateSpace',
  'UIDevice',
  'UIEvent',
  'UIPress',
  'UIResponder',
  'UIScreen',
  'UIScene',
  'UISceneActivationConditions',
  'UISceneActivationRequestOptions',
  'UISceneConfiguration',
  'UISceneConnectionOptions',
  'UISceneDestructionRequestOptions',
  'UISceneOpenExternalURLOptions',
  'UISceneSession',
  'UITimingCurveProvider',
  'UITouch',
  'UITraitCollection',
  'UIView',
  'UIViewController',
  'UIWindow',
  'UIWindowScene',
};

const _uiKitCorePrefixes = <String>[
  'UIApplication',
  'UIContent',
  'UIDevice',
  'UIEdgeInsets',
  'UIFocus',
  'UIInterfaceOrientation',
  'UILayout',
  'UIRect',
  'UIScene',
  'UIScreen',
  'UISpringTiming',
  'UITrait',
  'UIView',
  'UIWindow',
];

bool _isUiKitCoreDeclaration(Declaration declaration) {
  final name = declaration.originalName;
  return _matchesAnyExact(name, _uiKitCoreExactNames) ||
      _matchesAnyPrefix(name, _uiKitCorePrefixes);
}

const _uiKitScrollPrefixes = <String>[
  'UIScroll',
  'UIRefreshControl',
];

bool _isUiKitScrollDeclaration(Declaration declaration) =>
    _matchesAnyPrefix(declaration.originalName, _uiKitScrollPrefixes);

const _uiKitControlPrefixes = <String>[
  'UIAction',
  'UIButton',
  'UICommand',
  'UIControl',
  'UIDatePicker',
  'UIPageControl',
  'UIPicker',
  'UISegmentedControl',
  'UISlider',
  'UIStepper',
  'UISwitch',
];

bool _isUiKitControlDeclaration(Declaration declaration) =>
    _matchesAnyPrefix(declaration.originalName, _uiKitControlPrefixes);

const _uiKitTextPrefixes = <String>[
  'UIEditMenu',
  'UIFind',
  'UIFontPicker',
  'UILabel',
  'UIText',
];

bool _isUiKitTextDeclaration(Declaration declaration) =>
    _matchesAnyPrefix(declaration.originalName, _uiKitTextPrefixes);

const _uiKitTablePrefixes = <String>['UITable'];

bool _isUiKitTableDeclaration(Declaration declaration) =>
    _matchesAnyPrefix(declaration.originalName, _uiKitTablePrefixes);

const _uiKitCollectionPrefixes = <String>[
  'UICollection',
  'UICell',
  'UIList',
];

bool _isUiKitCollectionDeclaration(Declaration declaration) =>
    _matchesAnyPrefix(declaration.originalName, _uiKitCollectionPrefixes);

const _uiKitBarsPrefixes = <String>[
  'UIAlert',
  'UIBar',
  'UIContextMenu',
  'UIMenu',
  'UINavigation',
  'UIPopover',
  'UISearch',
  'UISheet',
  'UISplit',
  'UITab',
  'UIToolbar',
];

bool _isUiKitBarsDeclaration(Declaration declaration) =>
    _matchesAnyPrefix(declaration.originalName, _uiKitBarsPrefixes);

const _uiKitDrawingPrefixes = <String>[
  'UIBezier',
  'UIColor',
  'UIFont',
  'UIGraphics',
  'UIImage',
  'UISymbol',
];

bool _isUiKitDrawingDeclaration(Declaration declaration) =>
    _matchesAnyPrefix(declaration.originalName, _uiKitDrawingPrefixes);

const _uiKitInteractionPrefixes = <String>[
  'UIAccessibility',
  'UIActivity',
  'UICalendar',
  'UIDocument',
  'UIDrag',
  'UIDrop',
  'UIHover',
  'UIIndirect',
  'UIInput',
  'UIKey',
  'UIPaste',
  'UIPencil',
  'UIPointer',
  'UIPreview',
  'UIPrint',
  'UIScreenshot',
  'UIScribble',
  'UIUser',
  'UIWriting',
];

bool _isUiKitInteractionDeclaration(Declaration declaration) =>
    _matchesAnyPrefix(declaration.originalName, _uiKitInteractionPrefixes);

bool _isUiKitMiscDeclaration(Declaration declaration) =>
    !_isUiKitCoreDeclaration(declaration) &&
    !_isUiKitGestureBaseDeclaration(declaration) &&
    !_isUiKitGestureDeclaration(declaration) &&
    !_isUiKitScrollDeclaration(declaration) &&
    !_isUiKitControlDeclaration(declaration) &&
    !_isUiKitTextDeclaration(declaration) &&
    !_isUiKitTableDeclaration(declaration) &&
    !_isUiKitCollectionDeclaration(declaration) &&
    !_isUiKitBarsDeclaration(declaration) &&
    !_isUiKitDrawingDeclaration(declaration) &&
    !_isUiKitInteractionDeclaration(declaration);

const _uikitSplitUnits = <_SplitUnit>[
  _SplitUnit(
    key: 'core',
    libraryStem: 'uikit_core',
    includeDeclaration: _isUiKitCoreDeclaration,
  ),
  _SplitUnit(
    key: 'gesture_base',
    libraryStem: 'uikit_gesture_base',
    includeDeclaration: _isUiKitGestureBaseDeclaration,
  ),
  _SplitUnit(
    key: 'gestures',
    libraryStem: 'uikit_gestures',
    includeDeclaration: _isUiKitGestureDeclaration,
  ),
  _SplitUnit(
    key: 'scroll',
    libraryStem: 'uikit_scroll',
    includeDeclaration: _isUiKitScrollDeclaration,
  ),
  _SplitUnit(
    key: 'controls',
    libraryStem: 'uikit_controls',
    includeDeclaration: _isUiKitControlDeclaration,
  ),
  _SplitUnit(
    key: 'text',
    libraryStem: 'uikit_text',
    includeDeclaration: _isUiKitTextDeclaration,
  ),
  _SplitUnit(
    key: 'table',
    libraryStem: 'uikit_table',
    includeDeclaration: _isUiKitTableDeclaration,
  ),
  _SplitUnit(
    key: 'collection',
    libraryStem: 'uikit_collection',
    includeDeclaration: _isUiKitCollectionDeclaration,
  ),
  _SplitUnit(
    key: 'bars',
    libraryStem: 'uikit_bars',
    includeDeclaration: _isUiKitBarsDeclaration,
  ),
  _SplitUnit(
    key: 'drawing',
    libraryStem: 'uikit_drawing',
    includeDeclaration: _isUiKitDrawingDeclaration,
  ),
  _SplitUnit(
    key: 'interaction',
    libraryStem: 'uikit_interaction',
    includeDeclaration: _isUiKitInteractionDeclaration,
  ),
  _SplitUnit(
    key: 'misc',
    libraryStem: 'uikit_misc',
    includeDeclaration: _isUiKitMiscDeclaration,
  ),
];

List<String> _compilerOptionsFor(_FrameworkSpec spec, String sdkPath) {
  return ['-isysroot', sdkPath, '-F$sdkPath/System/Library/Frameworks'];
}

String _sdkPathFor(_AppleSdk sdk) {
  switch (sdk) {
    case _AppleSdk.macOS:
      return macSdkPath;
    case _AppleSdk.iOSSimulator:
      return _firstLineOfStdout('xcrun', [
        '--show-sdk-path',
        '--sdk',
        'iphonesimulator',
      ]);
  }
}

String _firstLineOfStdout(String command, List<String> args) {
  final result = Process.runSync(command, args);
  if (result.exitCode != 0) {
    throw ProcessException(
      command,
      args,
      '${result.stdout}${result.stderr}',
      result.exitCode,
    );
  }
  return (result.stdout as String)
      .split('\n')
      .firstWhere((line) => line.trim().isNotEmpty);
}

ObjectiveC _objectiveCConfig(_FrameworkSpec spec, _GenerationProfile profile) {
  if (profile == _GenerationProfile.full) {
    return _fullObjectiveCConfig(spec);
  }
  if (spec.key == 'metalkit') {
    bool includeMtk(Declaration decl) => decl.originalName.startsWith('MTK');
    return ObjectiveC(
      interfaces: Interfaces(include: includeMtk, includeTransitive: false),
      protocols: Protocols(include: includeMtk, includeTransitive: false),
      categories: Categories(include: includeMtk, includeTransitive: false),
    );
  }
  if (spec.key == 'metal') {
    bool includeMtl(Declaration decl) => decl.originalName.startsWith('MTL');
    return ObjectiveC(
      interfaces: Interfaces(include: includeMtl, includeTransitive: false),
      protocols: Protocols(include: includeMtl, includeTransitive: false),
      categories: Categories(include: includeMtl, includeTransitive: false),
    );
  }
  if (spec.key == 'foundation') {
    return _fullObjectiveCConfig(spec);
  }
  if (spec.key == 'appkit') {
    return _fullObjectiveCConfig(spec);
  }
  if (spec.key == 'uikit') {
    bool includeUi(Declaration decl) => decl.originalName.startsWith('UI');
    bool includeSubclassHelpers(Declaration decl) =>
        decl.originalName == 'UIViewController';
    bool includeMember(Declaration decl, String member) {
      if (decl.originalName == 'UIViewController' &&
          member == 'preferredContainerBackgroundStyle') {
        return false;
      }
      if (decl.originalName == 'CIImageProcessorKernel' &&
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
  throw StateError('Unsupported generation profile for ${spec.key}');
}

ObjectiveC _fullObjectiveCConfig(_FrameworkSpec spec) {
  if (spec.key == 'metalkit') {
    bool includeMtk(Declaration decl) => decl.originalName.startsWith('MTK');
    return ObjectiveC(
      interfaces: Interfaces(include: includeMtk, includeTransitive: false),
      protocols: Protocols(include: includeMtk, includeTransitive: false),
      categories: Categories(include: includeMtk, includeTransitive: false),
    );
  }
  if (spec.key == 'appkit') {
    bool includeSubclassHelpers(Declaration decl) =>
        decl.originalName == 'NSViewController';
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
    bool includeSubclassHelpers(Declaration decl) =>
        decl.originalName == 'UIViewController';
    bool includeMember(Declaration decl, String member) {
      if (decl.originalName == 'UIViewController' &&
          member == 'preferredContainerBackgroundStyle') {
        return false;
      }
      if (decl.originalName == 'CIImageProcessorKernel' &&
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

Future<void> _scaffoldPackage(
  _FrameworkSpec spec,
  Directory pkgDir, {
  required String packageName,
}) async {
  final usesSplitLayout = _usesSplitLayout(spec);
  await Directory('${pkgDir.path}/lib/src').create(recursive: true);
  await Directory('${pkgDir.path}/native').create(recursive: true);
  await Directory('${pkgDir.path}/tool').create(recursive: true);
  if (_needsBuildHook(spec)) {
    await Directory('${pkgDir.path}/hook').create(recursive: true);
  }

  await File(
    '${pkgDir.path}/pubspec.yaml',
  ).writeAsString(_pubspecFor(spec, packageName: packageName));
  await File(
    '${pkgDir.path}/analysis_options.yaml',
  ).writeAsString(_analysisOptions);
  await File(
    '${pkgDir.path}/README.md',
  ).writeAsString(_readmeFor(spec, packageName: packageName));
  await File('${pkgDir.path}/.gitignore').writeAsString(_gitIgnore);
  if (usesSplitLayout && spec.key == 'appkit') {
    await File(
      '${pkgDir.path}/lib/src/target_action.dart',
    ).writeAsString(_appKitTargetActionSource('appkit_core_bindings.dart'));
  }
  if (!usesSplitLayout) {
    await File(
      '${pkgDir.path}/lib/$packageName.dart',
    ).writeAsString(_libraryExports(spec));
  }
  if (_hasFlutterViews(spec)) {
    await File(
      '${pkgDir.path}/lib/flutter_views.dart',
    ).writeAsString(_flutterViewsLibraryExports());
  }
  await File(
    '${pkgDir.path}/tool/generate.dart',
  ).writeAsString(
    _packageGenerateTool(spec, packageName: packageName),
  );
  if (_needsBuildHook(spec)) {
    await File(
      '${pkgDir.path}/hook/build.dart',
    ).writeAsString(_buildHookFor(spec, packageName: packageName));
  }
}

String _pubspecFor(
  _FrameworkSpec spec, {
  required String packageName,
}) {
  final includeFlutterHelpers = _hasFlutterViews(spec);
  final includeBuildHookDeps = _needsBuildHook(spec);
  final description = _usesSplitLayout(spec)
      ? 'Split Objective-C bindings for ${spec.framework}.'
      : 'Full Objective-C bindings for ${spec.framework}.';
  final extraDeps = includeBuildHookDeps
      ? '''
  code_assets: ^1.0.0
  hooks: ^1.0.0
  logging: ^1.3.0
  native_toolchain_c: ^0.17.4
${includeFlutterHelpers ? "  flutter:\n    sdk: flutter\n" : ''}'''
      : '';
  final dependencyOverrides = includeBuildHookDeps
      ? '''

dependency_overrides:
  code_assets:
    path: ../../ffigen/pkgs/code_assets
  hooks:
    path: ../../ffigen/pkgs/hooks
  native_toolchain_c:
    path: ../../ffigen/pkgs/native_toolchain_c
'''
      : '';
  return '''
name: $packageName
description: $description
version: 0.1.0
publish_to: none

environment:
  sdk: ^3.11.0

dependencies:
$extraDeps  ffi: ^2.2.0
  objective_c:
    path: ../../ffigen/pkgs/objective_c

dev_dependencies:
  ffigen:
    path: ../../ffigen/pkgs/ffigen
  lints: ^6.0.0
$dependencyOverrides''';
}

const _analysisOptions = '''
include: package:lints/recommended.yaml

analyzer:
  exclude:
    - lib/src/*_bindings.dart
''';

String _libraryExports(_FrameworkSpec spec) {
  final buffer = StringBuffer()
    ..writeln("export 'src/${spec.generatedBase}_bindings.dart';");
  if (spec.key == 'appkit') {
    buffer.writeln("export 'src/target_action.dart';");
  }
  return buffer.toString();
}

String _flutterViewsLibraryExports() => "export 'src/flutter_views.dart';\n";

String _readmeFor(
  _FrameworkSpec spec, {
  required String packageName,
}) {
  final flutterHelpers = !_hasFlutterViews(spec)
      ? ''
      : switch (spec.key) {
    'appkit' =>
      '''

This package also bundles the Flutter platform-view transfer shim used by the
demo app:

- import `package:${spec.packageName}/flutter_views.dart`
- `registerObjCAppKitViewType(...)`
- `ObjCAppKitHostView`
''',
    'uikit' =>
      '''

This package also bundles the Flutter platform-view transfer shim used by the
demo app:

- import `package:${spec.packageName}/flutter_views.dart`
- `registerObjCUiKitViewType(...)`
- `ObjCUiKitHostView`
''',
    _ => '',
  };
  final regenerateCommand = 'dart tool/gen_objc_packages.dart ${spec.key}';
  final scopeDescription = _usesSplitLayout(spec)
      ? 'split-family'
      : 'generated';
  return '''
# $packageName

${scopeDescription[0].toUpperCase()}${scopeDescription.substring(1)} Objective-C bindings for `${spec.framework}` using the local
`ffigen` fork in `../ffigen`.$flutterHelpers

## Regenerate

From the repository root:

```bash
$regenerateCommand
```

To generate the smaller tooling-focused profile instead:

```bash
dart tool/gen_objc_packages.dart --profile lean ${spec.key}
```

${_usesSplitLayout(spec) ? '''To regenerate the package with an umbrella root surface:

```bash
dart tool/gen_objc_packages.dart --root-surface umbrella ${spec.key}
```

This package also emits:

- `all.dart` for the full umbrella export
- `${_splitPackages[spec.key]?.rootUnitKey ?? 'core'}.dart` as the cheap default root surface
''' : ''} 

To regenerate all packages used by the demos:

```bash
dart tool/gen_objc_packages.dart foundation appkit uikit metal metalkit
```
''';
}

String _packageGenerateTool(
  _FrameworkSpec spec, {
  required String packageName,
}) {
  return '''
import 'dart:io';

Future<void> main(List<String> args) async {
  final result = await Process.run(
    'dart',
    ['../../tool/gen_objc_packages.dart', ...args, '${spec.key}'],
    runInShell: true,
  );
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exitCode = result.exitCode;
}
''';
}

const _gitIgnore = '''
.dart_tool/
build/
pubspec.lock
''';

String _appKitTargetActionSource(String bindingsImport) => '''
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:objective_c/objective_c.dart' as objc;

import '$bindingsImport';

/// A small helper for wiring AppKit target/action callbacks from Dart.
final class NSButtonTargetAction {
  NSButtonTargetAction._(this.target, this.action);

  final objc.NSObject target;
  final Pointer<objc.ObjCSelector> action;

  factory NSButtonTargetAction.listener(
    void Function() onPressed, {
    String selectorName = 'handlePress:',
    String debugName = 'NSButtonTargetAction',
  }) {
    final action = objc.registerName(selectorName);
    final builder = objc.ObjCSubclassBuilder(
      superclassName: 'NSObject',
      debugName: debugName,
    );
    final signature = 'v@:@'.toNativeUtf8();
    builder.implementMethod(
      action,
      signature.cast(),
      ObjCBlock_ffiVoid_ffiVoid_objcObjCObjectImpl.protocolTrampoline,
      ObjCBlock_ffiVoid_ffiVoid_objcObjCObjectImpl.listener((
        Pointer<Void> _,
        objc.ObjCObject? sender,
      ) {
        if (sender == null) {
          return;
        }
        onPressed();
      }),
    );
    calloc.free(signature);
    return NSButtonTargetAction._(objc.NSObject.as(builder.build()), action);
  }
}
''';

bool _usesSplitLayout(_FrameworkSpec spec) => _splitPackages.containsKey(spec.key);

bool _hasFlutterViews(_FrameworkSpec spec) =>
    spec.key == 'appkit' || spec.key == 'uikit';

bool _needsBuildHook(_FrameworkSpec spec) => _hasFlutterViews(spec);

bool _usesBundledBindingsAsset(_FrameworkSpec spec) =>
    spec.key == 'appkit' || spec.key == 'uikit';

String _bindingsAssetName(_FrameworkSpec spec) =>
    '${spec.packageName}_bindings.dylib';

List<String> _bindingsSourcePaths(_FrameworkSpec spec) {
  if (_usesSplitLayout(spec)) {
    return [
      for (final unit in _splitPackages[spec.key]!.units)
        'native/${unit.libraryStem}_bindings.m',
    ];
  }
  return ['native/${spec.generatedBase}_bindings.m'];
}

String _bindingsSourcesLiteral(_FrameworkSpec spec) => _bindingsSourcePaths(spec)
    .map((path) => "      '$path',")
    .join('\n');

String _supportedOsCheck(_FrameworkSpec spec) => switch (spec.key) {
  'appkit' => 'codeConfig.targetOS != OS.macOS',
  'uikit' => 'codeConfig.targetOS != OS.iOS',
  _ => 'true',
};

String _frameworkLinkFlags(_FrameworkSpec spec) => spec.frameworkLoadOrder
    .map((framework) => "      '-framework',\n      '$framework',")
    .join('\n');

String _buildHookFor(
  _FrameworkSpec spec, {
  required String packageName,
}) {
  final includeFlutterViews = spec.key == 'appkit' || spec.key == 'uikit';
  final includeBindingsAsset = _usesBundledBindingsAsset(spec);
  final bindingsBlock = includeBindingsAsset
      ? '''

    final bindingsSources = <String>[
${_bindingsSourcesLiteral(spec)}
    ]
        .map((relativePath) => input.packageRoot.resolve(relativePath).toFilePath())
        .where((path) => File(path).existsSync())
        .toList();
    if (bindingsSources.isNotEmpty) {
      final bindingsAssetPath = input.outputDirectory.resolve(bindingsAssetName);
      final bindingsObjects = <String>[];
      for (final bindingsSrc in bindingsSources) {
        final bindingsObject = await builder.buildObject(
          bindingsSrc,
          [...cFlags, ...objCFlags],
        );
        bindingsObjects.add(bindingsObject);
        output.dependencies.add(Uri.file(bindingsSrc));
      }
      await builder.linkLib(bindingsObjects, bindingsAssetPath.toFilePath(), [
        ...cFlags,
${_frameworkLinkFlags(spec)}
      ]);
      output.assets.code.add(
        CodeAsset(
          package: input.packageName,
          name: bindingsAssetName,
          file: bindingsAssetPath,
          linkMode: DynamicLoadingBundled(),
        ),
      );
    }
'''
      : '';
  final flutterViewsBlock = includeFlutterViews
      ? '''

    final flutterViewsAssetPath = input.outputDirectory.resolve(flutterViewsAssetName);
    final flutterViewsSrc = input.packageRoot.resolve('src/flutter_views.m').toFilePath();
    final flutterViewsObject = await builder.buildObject(
      flutterViewsSrc,
      [...cFlags, ...objCFlags],
    );
    await builder.linkLib([flutterViewsObject], flutterViewsAssetPath.toFilePath(), [
      ...cFlags,
${_frameworkLinkFlags(spec)}
    ]);
    output.dependencies.add(Uri.file(flutterViewsSrc));
    output.assets.code.add(
      CodeAsset(
        package: input.packageName,
        name: flutterViewsAssetName,
        file: flutterViewsAssetPath,
        linkMode: DynamicLoadingBundled(),
      ),
    );
'''
      : '';

  return '''
import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_c/src/cbuilder/compiler_resolver.dart';

const objCFlags = ['-x', 'objective-c', '-fobjc-arc'];
${includeBindingsAsset ? "const bindingsAssetName = '${_bindingsAssetName(spec)}';" : ''}
${includeFlutterViews ? "const flutterViewsAssetName = '${packageName}_flutter_views.dylib';" : ''}

final logger = Logger('')
  ..level = Level.INFO
  ..onRecord.listen((record) {
    print('\${record.level.name}: \${record.time}: \${record.message}');
  });

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) {
      return;
    }

    final codeConfig = input.config.code;
    if (${_supportedOsCheck(spec)}) {
      return;
    }

    if (codeConfig.linkModePreference == LinkModePreference.static) {
      throw UnsupportedError('LinkModePreference.static is not supported.');
    }

    final builder = await _Builder.create(
      input,
      input.packageRoot.toFilePath(),
    );
    final cFlags = <String>[
      '-isysroot',
      _sdkPath(codeConfig),
      '-target',
      _toTargetTriple(codeConfig),
      _minOsVersion(codeConfig),
    ];
$bindingsBlock
$flutterViewsBlock
  });
}

class _Builder {
  final String _compiler;
  final String _rootDir;
  final Uri _tempOutDir;

  _Builder._(this._compiler, this._rootDir, this._tempOutDir);

  static Future<_Builder> create(BuildInput input, String rootDir) async {
    final resolver = CompilerResolver(
      codeConfig: input.config.code,
      logger: logger,
    );
    return _Builder._(
      (await resolver.resolveCompiler()).uri.toFilePath(),
      rootDir,
      input.outputDirectory.resolve('obj/'),
    );
  }

  Future<String> buildObject(String input, List<String> flags) async {
    assert(input.startsWith(_rootDir));
    final relativeInput = input.substring(_rootDir.length);
    final output = '\${_tempOutDir.resolve(relativeInput).toFilePath()}.o';
    File(output).parent.createSync(recursive: true);
    await _compile([...flags, '-c', input, '-fpic'], output);
    return output;
  }

  Future<void> linkLib(List<String> objects, String output, List<String> flags) =>
      _compile([
        '-shared',
        '-Wl,-encryptable',
        '-undefined',
        'dynamic_lookup',
        ...flags,
        ...objects,
      ], output);

  Future<void> _compile(List<String> flags, String output) async {
    final args = [...flags, '-o', output];
    logger.info('Running: \$_compiler \${args.join(" ")}');
    final proc = await Process.run(_compiler, args);
    logger.info(proc.stdout);
    logger.info(proc.stderr);
    if (proc.exitCode != 0) {
      exitCode = proc.exitCode;
      throw Exception('Command failed: \$_compiler \${args.join(" ")}');
    }
  }
}

String _sdkPath(CodeConfig codeConfig) {
  final sdk = switch (codeConfig.targetOS) {
    OS.iOS => codeConfig.iOS.targetSdk == IOSSdk.iPhoneOS
        ? 'iphoneos'
        : 'iphonesimulator',
    OS.macOS => 'macosx',
    _ => throw UnsupportedError('Unsupported target OS: \${codeConfig.targetOS}'),
  };
  return _firstLineOfStdout('xcrun', ['--show-sdk-path', '--sdk', sdk]);
}

String _firstLineOfStdout(String cmd, List<String> args) {
  final result = Process.runSync(cmd, args);
  assert(result.exitCode == 0);
  return (result.stdout as String)
      .split('\\n')
      .where((line) => line.isNotEmpty)
      .first;
}

String _minOsVersion(CodeConfig codeConfig) => switch (codeConfig.targetOS) {
  OS.iOS => '-mios-version-min=\${codeConfig.iOS.targetVersion}',
  OS.macOS => '-mmacos-version-min=\${codeConfig.macOS.targetVersion}',
  _ => throw UnsupportedError('Unsupported target OS: \${codeConfig.targetOS}'),
};

String _toTargetTriple(CodeConfig codeConfig) => switch (codeConfig.targetOS) {
  OS.iOS => _appleClangIosTargetFlags[codeConfig.targetArchitecture]![codeConfig.iOS.targetSdk]!,
  OS.macOS => _appleClangMacosTargetFlags[codeConfig.targetArchitecture]!,
  _ => throw UnsupportedError('Unsupported target OS: \${codeConfig.targetOS}'),
};

const _appleClangMacosTargetFlags = {
  Architecture.arm64: 'arm64-apple-darwin',
  Architecture.x64: 'x86_64-apple-darwin',
};

const _appleClangIosTargetFlags = {
  Architecture.arm64: {
    IOSSdk.iPhoneOS: 'arm64-apple-ios',
    IOSSdk.iPhoneSimulator: 'arm64-apple-ios-simulator',
  },
  Architecture.x64: {IOSSdk.iPhoneSimulator: 'x86_64-apple-ios-simulator'},
};
''';
}

class _FrameworkSpec {
  const _FrameworkSpec({
    required this.key,
    required this.packageDir,
    required this.packageName,
    required this.framework,
    required this.umbrellaHeader,
    required this.generatedBase,
    required this.dylibName,
    required this.frameworkLoadOrder,
    required this.sdk,
    required this.runtimeFrameworkPaths,
  });

  final String key;
  final String packageDir;
  final String packageName;
  final String framework;
  final String umbrellaHeader;
  final String generatedBase;
  final String dylibName;
  final List<String> frameworkLoadOrder;
  final _AppleSdk sdk;
  final List<String> runtimeFrameworkPaths;
}

enum _AppleSdk { macOS, iOSSimulator }
