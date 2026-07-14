import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_c/src/cbuilder/compiler_resolver.dart';

const _objCFlags = ['-x', 'objective-c', '-fobjc-arc'];
const _assetName = 'objc_appkit_flutter_views.dylib';

final _logger = Logger('')
  ..level = Level.INFO
  ..onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) return;

    final codeConfig = input.config.code;
    if (codeConfig.targetOS != OS.macOS) return;
    if (codeConfig.linkModePreference == LinkModePreference.static) {
      throw UnsupportedError('LinkModePreference.static is not supported.');
    }

    final builder = await _Builder.create(
      input,
      input.packageRoot.toFilePath(),
    );
    final flags = <String>[
      '-isysroot',
      _sdkPath(codeConfig),
      '-target',
      _targetTriple(codeConfig),
      '-mmacos-version-min=${codeConfig.macOS.targetVersion}',
    ];
    final source = input.packageRoot
        .resolve('src/flutter_views.m')
        .toFilePath();
    final object = await builder.buildObject(source, [...flags, ..._objCFlags]);
    final asset = input.outputDirectory.resolve(_assetName);
    await builder.linkLibrary(object, asset.toFilePath(), [
      ...flags,
      '-framework',
      'Foundation',
      '-framework',
      'AppKit',
    ]);
    output.dependencies.add(Uri.file(source));
    output.assets.code.add(
      CodeAsset(
        package: input.packageName,
        name: _assetName,
        file: asset,
        linkMode: DynamicLoadingBundled(),
      ),
    );
  });
}

class _Builder {
  _Builder._(this._compiler, this._rootDirectory, this._outputDirectory);

  final String _compiler;
  final String _rootDirectory;
  final Uri _outputDirectory;

  static Future<_Builder> create(BuildInput input, String rootDirectory) async {
    final resolver = CompilerResolver(
      codeConfig: input.config.code,
      logger: _logger,
    );
    return _Builder._(
      (await resolver.resolveCompiler()).uri.toFilePath(),
      rootDirectory,
      input.outputDirectory.resolve('obj/'),
    );
  }

  Future<String> buildObject(String input, List<String> flags) async {
    assert(input.startsWith(_rootDirectory));
    final relativeInput = input.substring(_rootDirectory.length);
    final output = '${_outputDirectory.resolve(relativeInput).toFilePath()}.o';
    File(output).parent.createSync(recursive: true);
    await _compile([...flags, '-c', input, '-fpic'], output);
    return output;
  }

  Future<void> linkLibrary(String object, String output, List<String> flags) =>
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
    _logger.info('Running: $_compiler ${args.join(" ")}');
    final process = await Process.run(_compiler, args);
    _logger.info(process.stdout);
    _logger.info(process.stderr);
    if (process.exitCode != 0) {
      exitCode = process.exitCode;
      throw Exception('Command failed: $_compiler ${args.join(" ")}');
    }
  }
}

String _sdkPath(CodeConfig config) =>
    _firstLine('xcrun', ['--show-sdk-path', '--sdk', 'macosx']);

String _targetTriple(CodeConfig config) => switch (config.targetArchitecture) {
  Architecture.arm64 => 'arm64-apple-darwin',
  Architecture.x64 => 'x86_64-apple-darwin',
  _ => throw UnsupportedError(
    'Unsupported architecture: ${config.targetArchitecture}',
  ),
};

String _firstLine(String executable, List<String> arguments) {
  final result = Process.runSync(executable, arguments);
  if (result.exitCode != 0) {
    throw ProcessException(
      executable,
      arguments,
      '${result.stdout}${result.stderr}',
      result.exitCode,
    );
  }
  return (result.stdout as String)
      .split('\n')
      .firstWhere((line) => line.isNotEmpty);
}
