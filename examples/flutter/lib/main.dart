import 'dart:io';

import 'package:flutter/material.dart';
import 'package:objc_appkit/flutter_views.dart';
import 'package:objc_uikit/flutter_views.dart';

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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Embedded AppKit View',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This NSView is built in Dart with objc_appkit and '
                  'registered with Flutter from Dart using Objective-C runtime '
                  'calls.',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
