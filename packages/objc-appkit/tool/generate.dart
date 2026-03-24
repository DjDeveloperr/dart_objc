import 'dart:io';

Future<void> main() async {
  final result = await Process.run(
    'dart',
    ['run', '../../tool/gen_objc_packages.dart', 'appkit'],
    runInShell: true,
  );
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exitCode = result.exitCode;
}
