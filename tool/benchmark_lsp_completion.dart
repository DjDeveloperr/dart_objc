import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

final class BenchmarkOptions {
  const BenchmarkOptions({
    required this.workDir,
    required this.timeout,
    required this.filter,
    required this.printItems,
    required this.coreOnly,
  });

  final Directory workDir;
  final Duration timeout;
  final String? filter;
  final bool printItems;
  final bool coreOnly;
}

final class _ScenarioResult {
  const _ScenarioResult({
    required this.label,
    required this.coldCompletionMs,
    required this.warmCompletionMs,
    required this.suggestionCount,
    required this.hasMethod0,
    required this.method0HasImportEdit,
  });

  final String label;
  final int coldCompletionMs;
  final int warmCompletionMs;
  final int suggestionCount;
  final bool hasMethod0;
  final bool method0HasImportEdit;
}

final class _CompletionResult {
  const _CompletionResult({
    required this.count,
    required this.hasMethod0,
    required this.method0HasImportEdit,
    required this.labels,
    required this.method0Item,
  });

  final int count;
  final bool hasMethod0;
  final bool method0HasImportEdit;
  final List<String> labels;
  final Map<String, Object?>? method0Item;
}

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  final appDirs = options.workDir
      .listSync()
      .whereType<Directory>()
      .where((dir) => pathBasename(dir.path).startsWith('app_'))
      .where(
        (dir) =>
            options.filter == null ||
            pathBasename(dir.path).contains(options.filter!),
      )
      .toList()
    ..sort((a, b) => pathBasename(a.path).compareTo(pathBasename(b.path)));
  if (appDirs.isEmpty) {
    stderr.writeln('No app_* directories found in ${options.workDir.path}.');
    exit(64);
  }

  final results = <_ScenarioResult>[];
  for (final appDir in appDirs) {
    final label = pathBasename(appDir.path).replaceFirst('app_', '');
    final importLine = _readImportLine(appDir, coreOnly: options.coreOnly);
    final source = '''
$importLine

void main() {
  final family = ApiFamily0(1);
  print(family.met);
}
''';
    final completionLine = 4;
    final completionCharacter = '  print(family.met'.length;
    final result = await _benchmarkWorkspace(
      workspaceDir: appDir,
      source: source,
      completionLine: completionLine,
      completionCharacter: completionCharacter,
      timeout: options.timeout,
      label: label,
      printItems: options.printItems,
    );
    results.add(result);
  }

  stdout.writeln(
    '| Shape | First completion | Second completion | Suggestions | `method0` | Auto-import edit |',
  );
  stdout.writeln('| --- | ---: | ---: | ---: | --- | --- |');
  for (final result in results) {
    stdout.writeln(
      '| `${result.label}` | '
      '${result.coldCompletionMs} ms | '
      '${result.warmCompletionMs} ms | '
      '${result.suggestionCount} | '
      '${result.hasMethod0 ? 'yes' : 'no'} | '
      '${result.method0HasImportEdit ? 'yes' : 'no'} |',
    );
  }
}

BenchmarkOptions _parseArgs(List<String> args) {
  var timeout = const Duration(seconds: 20);
  var workDir = Directory('${Directory.systemTemp.path}/dart_member_topology');
  String? filter;
  var printItems = false;
  var coreOnly = false;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--workdir') {
      workDir = Directory(args[++i]);
      continue;
    }
    if (arg == '--timeout-ms') {
      timeout = Duration(milliseconds: int.parse(args[++i]));
      continue;
    }
    if (arg == '--filter') {
      filter = args[++i];
      continue;
    }
    if (arg == '--print-items') {
      printItems = true;
      continue;
    }
    if (arg == '--core-only') {
      coreOnly = true;
      continue;
    }
    if (arg == '--help' || arg == '-h') {
      stdout.writeln('''
Usage: dart run tool/benchmark_lsp_completion.dart [options]

Options:
  --workdir PATH     Workdir containing app_* benchmark harnesses.
                     Default: ${Directory.systemTemp.path}/dart_member_topology
  --timeout-ms N     Timeout per request. Default: 20000
  --filter TEXT      Only run app_* directories containing TEXT.
  --print-items      Print the first completion labels for each scenario.
  --core-only        Replace imports with src/core.dart when the package has one.
''');
      exit(0);
    }
    stderr.writeln('Unknown argument: $arg');
    exit(64);
  }

  return BenchmarkOptions(
    workDir: workDir,
    timeout: timeout,
    filter: filter,
    printItems: printItems,
    coreOnly: coreOnly,
  );
}

String _readImportLine(Directory appDir, {required bool coreOnly}) {
  final source = File('${appDir.path}/bin/main.dart').readAsStringSync();
  final match = RegExp(r"^import\s+'.+';$", multiLine: true).firstMatch(source);
  if (match == null) {
    throw StateError('Unable to find import in ${appDir.path}/bin/main.dart');
  }
  final importLine = match.group(0)!;
  if (!coreOnly) {
    return importLine;
  }

  final packageMatch =
      RegExp(r"^import\s+'package:([^/]+)/.+';$").firstMatch(importLine);
  if (packageMatch == null) {
    return importLine;
  }
  final packageName = packageMatch.group(1)!;
  final packageDirName = pathBasename(appDir.path).replaceFirst('app_', '');
  final packageDir = Directory('${appDir.parent.path}/$packageDirName');
  final coreFile = File('${packageDir.path}/lib/src/core.dart');
  if (!coreFile.existsSync()) {
    return importLine;
  }

  return "import 'package:$packageName/src/core.dart';";
}

Future<_ScenarioResult> _benchmarkWorkspace({
  required Directory workspaceDir,
  required String source,
  required int completionLine,
  required int completionCharacter,
  required Duration timeout,
  required String label,
  required bool printItems,
}) async {
  final server = await _LspServer.start(
    workspaceDir: workspaceDir,
    timeout: timeout,
  );
  try {
    final fileUri = Uri.file('${workspaceDir.path}/bin/main.dart').toString();
    await server.initialize(
      rootUri: Uri.directory(workspaceDir.path).toString(),
      workspaceName: pathBasename(workspaceDir.path),
    );
    await server.waitForAnalysisComplete();
    await server.didOpen(
      uri: fileUri,
      text: source,
    );
    await Future<void>.delayed(const Duration(milliseconds: 500));
    await server.waitForAnalysisComplete();

    final cold = Stopwatch()..start();
    final coldResult = await server.completion(
      uri: fileUri,
      line: completionLine,
      character: completionCharacter,
    );
    cold.stop();

    final warm = Stopwatch()..start();
    final warmResult = await server.completion(
      uri: fileUri,
      line: completionLine,
      character: completionCharacter,
    );
    warm.stop();
    final method0Item = coldResult.method0Item ?? warmResult.method0Item;
    final resolvedMethod0 =
        method0Item == null
            ? null
            : await server.resolveCompletionItem(method0Item);

    if (printItems) {
      stdout.writeln(
        '$label items: ${coldResult.labels.take(12).join(', ')}',
      );
    }

    return _ScenarioResult(
      label: label,
      coldCompletionMs: cold.elapsedMilliseconds,
      warmCompletionMs: warm.elapsedMilliseconds,
      suggestionCount: coldResult.count > warmResult.count
          ? coldResult.count
          : warmResult.count,
      hasMethod0: coldResult.hasMethod0 || warmResult.hasMethod0,
      method0HasImportEdit:
          coldResult.method0HasImportEdit ||
          warmResult.method0HasImportEdit ||
          _completionItemHasImportEdit(resolvedMethod0),
    );
  } finally {
    await server.shutdown();
  }
}

final class _LspServer {
  _LspServer._({
    required this.process,
    required this.timeout,
  }) {
    _stdoutSub = process.stdout.listen(_handleStdout, onDone: _handleDone);
    _stderrSub = process.stderr
        .transform(utf8.decoder)
        .listen((chunk) => stderr.write(chunk));
  }

  final Process process;
  final Duration timeout;
  late final StreamSubscription<List<int>> _stdoutSub;
  late final StreamSubscription<String> _stderrSub;
  final BytesBuilder _stdoutBuffer = BytesBuilder(copy: false);
  final Map<int, Completer<Map<String, Object?>>> _pending =
      <int, Completer<Map<String, Object?>>>{};
  int _nextRequestId = 1;
  Completer<void>? _analysisDone;
  bool _isAnalyzing = false;

  static Future<_LspServer> start({
    required Directory workspaceDir,
    required Duration timeout,
  }) async {
    final process = await Process.start(
      'dart',
      const ['language-server', '--protocol=lsp'],
      workingDirectory: workspaceDir.path,
    );
    return _LspServer._(process: process, timeout: timeout);
  }

  Future<void> initialize({
    required String rootUri,
    required String workspaceName,
  }) async {
    await _sendRequest('initialize', {
      'processId': pid,
      'clientInfo': {'name': 'codex-benchmark', 'version': '1'},
      'rootUri': rootUri,
      'initializationOptions': {
        'onlyAnalyzeProjectsWithOpenFiles': true,
        'suggestFromUnimportedLibraries': true,
      },
      'capabilities': {
        'workspace': {
          'applyEdit': true,
          'configuration': true,
        },
        'window': {'workDoneProgress': false},
        'textDocument': {
          'completion': {
            'completionItem': {'snippetSupport': false},
          },
        },
      },
      'workspaceFolders': [
        {'uri': rootUri, 'name': workspaceName},
      ],
    });
    _sendNotification('initialized', <String, Object?>{});
  }

  Future<void> didOpen({
    required String uri,
    required String text,
  }) async {
    _sendNotification('textDocument/didOpen', {
      'textDocument': {
        'uri': uri,
        'languageId': 'dart',
        'version': 1,
        'text': text,
      },
    });
  }

  Future<void> waitForAnalysisComplete() {
    if (!_isAnalyzing) {
      return Future.value();
    }
    final completer = Completer<void>();
    _analysisDone = completer;
    return completer.future.timeout(timeout);
  }

  Future<_CompletionResult> completion({
    required String uri,
    required int line,
    required int character,
  }) async {
    final response = await _sendRequest('textDocument/completion', {
      'textDocument': {'uri': uri},
      'position': {'line': line, 'character': character},
      'context': {'triggerKind': 1},
    });
    final result = response['result'];
    if (result is List) {
      return _parseCompletionItems(result.cast<Object?>());
    }
    if (result is Map<String, Object?>) {
      final items = result['items'];
      if (items is List) {
        return _parseCompletionItems(items.cast<Object?>());
      }
    }
    throw StateError('Unexpected completion payload: $result');
  }

  Future<Map<String, Object?>> resolveCompletionItem(
    Map<String, Object?> item,
  ) async {
    final response = await _sendRequest('completionItem/resolve', item);
    final result = response['result'];
    if (result is Map<String, Object?>) {
      return result;
    }
    throw StateError('Unexpected completionItem/resolve payload: $result');
  }

  Future<void> shutdown() async {
    try {
      await _sendRequest('shutdown', const <String, Object?>{});
    } catch (_) {
      // Ignore shutdown races if the server already exited.
    }
    _sendNotification('exit', const <String, Object?>{});
    await process.exitCode.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        process.kill();
        return -1;
      },
    );
    await _stdoutSub.cancel();
    await _stderrSub.cancel();
  }

  Future<Map<String, Object?>> _sendRequest(
    String method,
    Map<String, Object?> params,
  ) {
    final id = _nextRequestId++;
    final completer = Completer<Map<String, Object?>>();
    _pending[id] = completer;
    _writeMessage({
      'jsonrpc': '2.0',
      'id': id,
      'method': method,
      'params': params,
    });
    return completer.future.timeout(timeout);
  }

  void _sendNotification(String method, Map<String, Object?> params) {
    _writeMessage({
      'jsonrpc': '2.0',
      'method': method,
      'params': params,
    });
  }

  void _writeMessage(Map<String, Object?> message) {
    final body = utf8.encode(jsonEncode(message));
    final header = ascii.encode('Content-Length: ${body.length}\r\n\r\n');
    process.stdin.add(header);
    process.stdin.add(body);
  }

  void _handleStdout(List<int> chunk) {
    _stdoutBuffer.add(chunk);
    _drainMessages();
  }

  void _drainMessages() {
    var bytes = _stdoutBuffer.takeBytes();
    while (true) {
      final headerEnd = _indexOfHeaderEnd(bytes);
      if (headerEnd == -1) {
        _stdoutBuffer.add(bytes);
        return;
      }
      final headerBytes = bytes.sublist(0, headerEnd);
      final headerText = ascii.decode(headerBytes);
      final lengthMatch =
          RegExp(r'Content-Length:\s*(\d+)', caseSensitive: false)
              .firstMatch(headerText);
      if (lengthMatch == null) {
        throw StateError('Missing Content-Length in header:\n$headerText');
      }
      final contentLength = int.parse(lengthMatch.group(1)!);
      final bodyStart = headerEnd + 4;
      if (bytes.length < bodyStart + contentLength) {
        _stdoutBuffer.add(bytes);
        return;
      }
      final bodyBytes = bytes.sublist(bodyStart, bodyStart + contentLength);
      final message = jsonDecode(utf8.decode(bodyBytes)) as Map<String, Object?>;
      _handleMessage(message);
      bytes = Uint8List.fromList(bytes.sublist(bodyStart + contentLength));
    }
  }

  int _indexOfHeaderEnd(Uint8List bytes) {
    for (var i = 0; i <= bytes.length - 4; i++) {
      if (bytes[i] == 13 &&
          bytes[i + 1] == 10 &&
          bytes[i + 2] == 13 &&
          bytes[i + 3] == 10) {
        return i;
      }
    }
    return -1;
  }

  void _handleMessage(Map<String, Object?> message) {
    final id = message['id'];
    final method = message['method'];
    if (id is int && method is String) {
      _handleServerRequest(id, method, message['params']);
      return;
    }
    if (id is int) {
      final completer = _pending.remove(id);
      if (completer != null && !completer.isCompleted) {
        completer.complete(message);
      }
      return;
    }

    if (method == 'textDocument/publishDiagnostics') {
      return;
    }

    if (method == r'$/analyzerStatus') {
      final params = message['params'];
      if (params is Map<String, Object?>) {
        final isAnalyzing = params['isAnalyzing'];
        if (isAnalyzing is bool) {
          _isAnalyzing = isAnalyzing;
          if (!isAnalyzing) {
            final completer = _analysisDone;
            _analysisDone = null;
            if (completer != null && !completer.isCompleted) {
              completer.complete();
            }
          }
        }
      }
    }
  }

  void _handleDone() {
    for (final completer in _pending.values) {
      if (!completer.isCompleted) {
        completer.completeError(StateError('Language server exited.'));
      }
    }
    _pending.clear();
    final analysisDone = _analysisDone;
    if (analysisDone != null && !analysisDone.isCompleted) {
      analysisDone.completeError(StateError('Language server exited.'));
    }
  }

  void _handleServerRequest(int id, String method, Object? params) {
    Object? result;
    if (method == 'workspace/configuration') {
      final items = (params as Map<String, Object?>?)?['items'];
      if (items is List) {
        result = items.map<Object?>((item) {
          final section = (item as Map<String, Object?>)['section'];
          if (section == 'dart') {
            return <String, Object?>{
              'enableSnippets': false,
              'documentation': 'none',
              'completeFunctionCalls': false,
            };
          }
          return null;
        }).toList();
      }
    } else {
      result = null;
    }
    _writeMessage({
      'jsonrpc': '2.0',
      'id': id,
      'result': result,
    });
  }
}

_CompletionResult _parseCompletionItems(List<Object?> items) {
  final labels = <String>[];
  var hasMethod0 = false;
  var method0HasImportEdit = false;
  Map<String, Object?>? method0Item;

  for (final item in items) {
    if (item is! Map<String, Object?>) {
      continue;
    }
    final label = item['label'];
    if (label is! String) {
      continue;
    }
    labels.add(label);
    if (label == 'method0' || label.startsWith('method0(')) {
      hasMethod0 = true;
      method0Item ??= item;
      method0HasImportEdit = _completionItemHasImportEdit(item);
    }
  }

  return _CompletionResult(
    count: items.length,
    hasMethod0: hasMethod0,
    method0HasImportEdit: method0HasImportEdit,
    labels: labels,
    method0Item: method0Item,
  );
}

bool _completionItemHasImportEdit(Map<String, Object?>? item) {
  if (item == null) {
    return false;
  }
  final additionalTextEdits = item['additionalTextEdits'];
  final command = item['command'];
  if (additionalTextEdits is List && additionalTextEdits.isNotEmpty) {
    return true;
  }
  return command != null;
}

String pathBasename(String path) {
  final normalized = path.endsWith(Platform.pathSeparator)
      ? path.substring(0, path.length - 1)
      : path;
  final index = normalized.lastIndexOf(Platform.pathSeparator);
  return index == -1 ? normalized : normalized.substring(index + 1);
}
