import 'dart:io';

Future<void> main(List<String> args) async {
  final result = await Process.run(
    'dart',
    ['../../tool/gen_objc_packages.dart', '--layout', 'split', ...args, 'metal'],
    runInShell: true,
  );
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exitCode = result.exitCode;
}
