import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:objective_c/objective_c.dart';
import 'package:objc_appkit/objc_appkit.dart';
import 'package:objc_appkit/flutter_views.dart';

const objcAppKitDemoViewType = 'objc-appkit-demo-view';

class ObjcAppKitEmbeddedSurface extends StatefulWidget {
  const ObjcAppKitEmbeddedSurface({super.key, required this.onButtonPressed});

  final VoidCallback onButtonPressed;

  @override
  State<ObjcAppKitEmbeddedSurface> createState() =>
      _ObjcAppKitEmbeddedSurfaceState();
}

class _ObjcAppKitEmbeddedSurfaceState extends State<ObjcAppKitEmbeddedSurface> {
  late final ObjcAppKitDemoScene _scene = ObjcAppKitDemoScene(
    onButtonPressed: widget.onButtonPressed,
  );

  @override
  Widget build(BuildContext context) {
    return ObjCAppKitHostView(
      viewType: objcAppKitDemoViewType,
      view: _scene.rootView,
    );
  }
}

final class ObjcAppKitDemoScene {
  ObjcAppKitDemoScene._({
    required this.retainedButtonTarget,
    required this.rootView,
  });

  factory ObjcAppKitDemoScene({required VoidCallback onButtonPressed}) {
    final retainedButtonTarget = NSButtonTargetAction.listener(
      onButtonPressed,
    );
    final rootView = _buildRootView(retainedButtonTarget);
    return ObjcAppKitDemoScene._(
      retainedButtonTarget: retainedButtonTarget,
      rootView: rootView,
    );
  }

  final NSButtonTargetAction retainedButtonTarget;
  final NSView rootView;

  static NSView _buildRootView(NSButtonTargetAction retainedButtonTarget) {
    const width = 520.0;
    const height = 240.0;

    final root = NSVisualEffectView.alloc().initWithFrame(
      _cgRect(0, 0, width, height),
    );
    root.autoresizingMask =
        NSAutoresizingMaskOptions.NSViewWidthSizable |
        NSAutoresizingMaskOptions.NSViewHeightSizable;
    root.blendingMode =
        NSVisualEffectBlendingMode.NSVisualEffectBlendingModeWithinWindow;
    root.material = NSVisualEffectMaterial.NSVisualEffectMaterialSidebar;
    root.state = NSVisualEffectState.NSVisualEffectStateActive;

    final title = _label(
      'Built in Dart. Mounted by Flutter.',
      frame: _cgRect(24, 170, 448, 28),
      font: NSFont.systemFontOfSizeWeight(24, weight: 0.68),
      color: NSColor.getLabelColor(),
    );
    root.addSubview(title);

    final subtitle = _label(
      'The platform view factory is registered from Dart with ObjC runtime calls.',
      frame: _cgRect(24, 138, 472, 18),
      font: NSFont.systemFontOfSize(13),
      color: NSColor.getSecondaryLabelColor(),
    );
    root.addSubview(subtitle);

    final badge = NSBox.alloc().initWithFrame(_cgRect(24, 34, 200, 72));
    badge.boxType = NSBoxType.NSBoxCustom;
    badge.titlePosition = NSTitlePosition.NSNoTitle;
    badge.cornerRadius = 16;
    badge.borderWidth = 1;
    badge.fillColor = NSColor.colorWithSRGBRed(
      0.12,
      green: 0.45,
      blue: 0.34,
      alpha: 0.12,
    );
    badge.borderColor = NSColor.colorWithSRGBRed(
      0.12,
      green: 0.45,
      blue: 0.34,
      alpha: 0.26,
    );
    badge.addSubview(
      _label(
        'NSView subtree',
        frame: _cgRect(16, 34, 140, 20),
        font: NSFont.systemFontOfSizeWeight(17, weight: 0.63),
        color: NSColor.getLabelColor(),
      ),
    );
    badge.addSubview(
      _label(
        'objc_appkit in Dart',
        frame: _cgRect(16, 14, 150, 16),
        font: NSFont.systemFontOfSize(12),
        color: NSColor.getSecondaryLabelColor(),
      ),
    );
    root.addSubview(badge);

    final button = NSButton.alloc().initWithFrame(_cgRect(332, 52, 164, 36));
    button.title = 'Call Flutter'.toNSString();
    button.bezelStyle = NSBezelStyle.NSBezelStyleRounded;
    button.target = retainedButtonTarget.target;
    button.action = retainedButtonTarget.action;
    root.addSubview(button);

    return root;
  }

  static NSTextField _label(
    String text, {
    required CGRect frame,
    required NSFont font,
    required NSColor color,
  }) {
    final label = NSTextField.labelWithString(text.toNSString());
    label.frame = frame;
    label.font = font;
    label.textColor = color;
    return label;
  }
}

CGRect _cgRect(double x, double y, double width, double height) {
  final bytes = Uint8List(sizeOf<CGRect>());
  final rect = Struct.create<CGRect>(bytes);
  rect.origin.x = x;
  rect.origin.y = y;
  rect.size.width = width;
  rect.size.height = height;
  return rect;
}
