import 'package:flutter/material.dart';
import 'package:objc_appkit/objc_appkit.dart';
import 'package:objective_c/objective_c.dart';

class ObjcAppKitFilePanelDemo extends StatefulWidget {
  const ObjcAppKitFilePanelDemo({super.key});

  @override
  State<ObjcAppKitFilePanelDemo> createState() =>
      _ObjcAppKitFilePanelDemoState();
}

class _ObjcAppKitFilePanelDemoState extends State<ObjcAppKitFilePanelDemo> {
  String? _selectedPath;

  void _chooseFile() {
    final panel = NSOpenPanel.openPanel();
    panel.title = 'Choose a file from Dart'.toNSString();
    panel.message =
        'This is NSOpenPanel, invoked through generated AppKit bindings.'
            .toNSString();
    panel.prompt = 'Use File'.toNSString();
    panel.canChooseFiles = true;
    panel.canChooseDirectories = false;
    panel.allowsMultipleSelection = false;

    panel.beginWithCompletionHandler(
      ObjCBlock_ffiVoid_ffiLong.listener((response) {
        final path = panel.URL?.path?.toDartString();
        if (!mounted || path == null) return;
        setState(() => _selectedPath = path);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Native file access',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Flutter launches NSOpenPanel directly. Its typed Objective-C block '
          'returns the selected NSURL without an app-specific platform '
          'channel or file-picker plugin.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: _chooseFile,
          icon: const Icon(Icons.folder_open),
          label: const Text('Choose with AppKit'),
        ),
        const SizedBox(height: 20),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: SizedBox(
              width: double.infinity,
              child: SelectableText(
                _selectedPath ?? 'No file selected yet.',
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
