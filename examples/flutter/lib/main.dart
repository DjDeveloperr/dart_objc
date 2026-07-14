import 'dart:io';

import 'package:flutter/material.dart';
import 'package:objc_appkit_flutter/objc_appkit_flutter.dart';
import 'package:objc_uikit_flutter/objc_uikit_flutter.dart';

import 'native_appkit_editor.dart';
import 'native_appkit_file_panel.dart';
import 'native_appkit_scene.dart';
import 'native_uikit_scene.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _registerPlatformViews();
  runApp(const ObjcDarwinEmbedApp());
}

Future<void> _registerPlatformViews() async {
  if (Platform.isIOS) {
    await registerObjCUiKitViewType(viewType: objcUiKitTabBarViewType);
  } else if (Platform.isMacOS) {
    await registerObjCAppKitViewType(viewType: objcAppKitDemoViewType);
    await registerObjCAppKitViewType(viewType: objcAppKitEditorViewType);
  }
}

class ObjcDarwinEmbedApp extends StatelessWidget {
  const ObjcDarwinEmbedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F6F54)),
        useMaterial3: true,
      ),
      home: Platform.isIOS
          ? const ObjcUiKitTabShell()
          : const ObjcDarwinEmbedHome(),
    );
  }
}

class ObjcDarwinEmbedHome extends StatefulWidget {
  const ObjcDarwinEmbedHome({super.key});

  @override
  State<ObjcDarwinEmbedHome> createState() => _ObjcDarwinEmbedHomeState();
}

class _ObjcDarwinEmbedHomeState extends State<ObjcDarwinEmbedHome> {
  _MacNativeDemo _selectedDemo = _MacNativeDemo.editor;
  int _nativeTapCount = 0;
  int _embedRevision = 0;

  void _rebuildNativeView() {
    setState(() {
      _embedRevision += 1;
    });
  }

  void _recordNativeTap() {
    setState(() {
      _nativeTapCount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SegmentedButton<_MacNativeDemo>(
                    segments: const [
                      ButtonSegment(
                        value: _MacNativeDemo.surface,
                        icon: Icon(Icons.view_in_ar),
                        label: Text('Native surface'),
                      ),
                      ButtonSegment(
                        value: _MacNativeDemo.editor,
                        icon: Icon(Icons.edit_note),
                        label: Text('Native editor'),
                      ),
                      ButtonSegment(
                        value: _MacNativeDemo.filePanel,
                        icon: Icon(Icons.folder_open),
                        label: Text('File panel'),
                      ),
                    ],
                    selected: {_selectedDemo},
                    onSelectionChanged: (selection) {
                      setState(() => _selectedDemo = selection.single);
                    },
                  ),
                  const SizedBox(height: 24),
                  if (_selectedDemo == _MacNativeDemo.surface) ...[
                    Text(
                      'Embedded AppKit View',
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This NSView is built in Dart with objc_appkit and '
                      'registered with Flutter from Dart using Objective-C '
                      'runtime calls.',
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: SizedBox(
                        height: 240,
                        child: ObjcAppKitEmbeddedSurface(
                          key: ValueKey(_embedRevision),
                          onButtonPressed: _recordNativeTap,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Native button taps: $_nativeTapCount',
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    FilledButton.tonal(
                      onPressed: _rebuildNativeView,
                      child: const Text('Rebuild Native View'),
                    ),
                  ] else if (_selectedDemo == _MacNativeDemo.editor)
                    const ObjcAppKitEditorDemo()
                  else
                    const ObjcAppKitFilePanelDemo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _MacNativeDemo { surface, editor, filePanel }
