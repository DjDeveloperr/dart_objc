import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_c/src/cbuilder/compiler_resolver.dart';

const objCFlags = ['-x', 'objective-c', '-fobjc-arc'];
const bindingsAssetName = 'objc_uikit_bindings.dylib';
const flutterViewsAssetName = 'objc_uikit_flutter_views.dylib';

final logger = Logger('')
  ..level = Level.INFO
  ..onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) {
      return;
    }

    final codeConfig = input.config.code;
    if (codeConfig.targetOS != OS.iOS) {
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

    final bindingsAssetPath = input.outputDirectory.resolve(bindingsAssetName);
    final bindingsSrc =
        input.packageRoot.resolve('native/uikit_bindings.m').toFilePath();
    final bindingsObject = await builder.buildObject(
      bindingsSrc,
      [...cFlags, ...objCFlags],
    );
    await builder.linkLib(bindingsObject, bindingsAssetPath.toFilePath(), [
      ...cFlags,
      '-framework',
      'Foundation',
      '-framework',
      'UIKit',
    ]);
    output.dependencies.add(Uri.file(bindingsSrc));
    output.assets.code.add(
      CodeAsset(
        package: input.packageName,
        name: bindingsAssetName,
        file: bindingsAssetPath,
        linkMode: DynamicLoadingBundled(),
      ),
    );


    final flutterViewsAssetPath = input.outputDirectory.resolve(flutterViewsAssetName);
    final flutterViewsSrc = input.packageRoot.resolve('src/flutter_views.m').toFilePath();
    final flutterViewsObject = await builder.buildObject(
      flutterViewsSrc,
      [...cFlags, ...objCFlags],
    );
    await builder.linkLib(flutterViewsObject, flutterViewsAssetPath.toFilePath(), [
      ...cFlags,
      '-framework',
      'Foundation',
      '-framework',
      'UIKit',
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
    final output = '${_tempOutDir.resolve(relativeInput).toFilePath()}.o';
    File(output).parent.createSync(recursive: true);
    await _compile([...flags, '-c', input, '-fpic'], output);
    return output;
  }

  Future<void> linkLib(String object, String output, List<String> flags) =>
      _compile([
        '-shared',
        '-Wl,-encryptable',
        '-undefined',
        'dynamic_lookup',
        ...flags,
        object,
      ], output);

  Future<void> _compile(List<String> flags, String output) async {
    final args = [...flags, '-o', output];
    logger.info('Running: $_compiler ${args.join(" ")}');
    final proc = await Process.run(_compiler, args);
    logger.info(proc.stdout);
    logger.info(proc.stderr);
    if (proc.exitCode != 0) {
      exitCode = proc.exitCode;
      throw Exception('Command failed: $_compiler ${args.join(" ")}');
    }
  }
}

String _sdkPath(CodeConfig codeConfig) {
  final sdk = switch (codeConfig.targetOS) {
    OS.iOS => codeConfig.iOS.targetSdk == IOSSdk.iPhoneOS
        ? 'iphoneos'
        : 'iphonesimulator',
    OS.macOS => 'macosx',
    _ => throw UnsupportedError('Unsupported target OS: ${codeConfig.targetOS}'),
  };
  return _firstLineOfStdout('xcrun', ['--show-sdk-path', '--sdk', sdk]);
}

String _firstLineOfStdout(String cmd, List<String> args) {
  final result = Process.runSync(cmd, args);
  assert(result.exitCode == 0);
  return (result.stdout as String)
      .split('\n')
      .where((line) => line.isNotEmpty)
      .first;
}

String _minOsVersion(CodeConfig codeConfig) => switch (codeConfig.targetOS) {
  OS.iOS => '-mios-version-min=${codeConfig.iOS.targetVersion}',
  OS.macOS => '-mmacos-version-min=${codeConfig.macOS.targetVersion}',
  _ => throw UnsupportedError('Unsupported target OS: ${codeConfig.targetOS}'),
};

String _toTargetTriple(CodeConfig codeConfig) => switch (codeConfig.targetOS) {
  OS.iOS => _appleClangIosTargetFlags[codeConfig.targetArchitecture]![codeConfig.iOS.targetSdk]!,
  OS.macOS => _appleClangMacosTargetFlags[codeConfig.targetArchitecture]!,
  _ => throw UnsupportedError('Unsupported target OS: ${codeConfig.targetOS}'),
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
