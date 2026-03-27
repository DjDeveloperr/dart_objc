import 'dart:io';

Future<void> main(List<String> args) async {
  final result = await Process.run(
    'dart',
    ['run', '../../tool/gen_objc_packages.dart', ...args, 'metal'],
    runInShell: true,
  );
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exitCode = result.exitCode;
}
