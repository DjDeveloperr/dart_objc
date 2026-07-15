import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:objc_appkit/objc_appkit.dart';
import 'package:objc_appkit_flutter/objc_appkit_flutter.dart';
import 'package:objective_c/objective_c.dart';

const objcAppKitEditorViewType = 'objc-appkit-text-editor';
const _initialEditorText = '''
This is a real NSTextView embedded inside Flutter.

Selection, keyboard input, undo, accessibility, and platform text behavior are
provided by AppKit. The view and its delegate are created directly in Dart.
''';

class ObjcAppKitEditorDemo extends StatefulWidget {
  const ObjcAppKitEditorDemo({super.key});

  @override
  State<ObjcAppKitEditorDemo> createState() => _ObjcAppKitEditorDemoState();
}

class _ObjcAppKitEditorDemoState extends State<ObjcAppKitEditorDemo> {
  late final ObjcAppKitEditorScene _scene = ObjcAppKitEditorScene(
    initialText: _initialEditorText,
    onTextChanged: _handleNativeTextChanged,
  );
  String _nativeText = _initialEditorText.trim();

  void _handleNativeTextChanged(String value) {
    if (!mounted) return;
    setState(() => _nativeText = value);
  }

  void _insertTemplate() {
    _scene.text = '''
Flutter requested this replacement, but AppKit owns the editor.

The bridge passes the same typed NSTextView object; there is no method-channel
schema or per-control plugin API to maintain.
''';
    setState(() => _nativeText = _scene.text);
  }

  void _focusNativeEditor() {
    _scene.focus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Native AppKit editor',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'An NSTextView handles platform editing while Flutter reacts to its '
          'typed delegate callback.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: SizedBox(
            height: 260,
            child: ObjCAppKitHostView(
              viewType: objcAppKitEditorViewType,
              view: _scene.rootView,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            OutlinedButton(
              onPressed: _focusNativeEditor,
              child: const Text('Focus AppKit editor'),
            ),
            const SizedBox(width: 12),
            FilledButton.tonal(
              onPressed: _insertTemplate,
              child: const Text('Replace from Flutter'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${_nativeText.length} native characters',
                textAlign: TextAlign.end,
                style: theme.textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

final class ObjcAppKitEditorScene {
  ObjcAppKitEditorScene({
    required String initialText,
    required ValueChanged<String> onTextChanged,
  }) {
    _delegate = _TextViewDelegate(textView, onTextChanged);
    textView.delegate$1 = _delegate.asNSTextViewDelegate;
    text = initialText;
  }

  final NSTextView textView = NSTextView.alloc().initWithFrame(
    _cgRect(0, 0, 640, 260),
  );
  late final _TextViewDelegate _delegate;

  late final NSScrollView rootView = _buildScrollView(textView);

  NSTextViewDelegate get delegate => _delegate.asNSTextViewDelegate;

  String get text => textView.string.toDartString();

  set text(String value) {
    textView.string = value.toNSString();
  }

  bool focus() => textView.window?.makeFirstResponder(textView) ?? false;

  static NSScrollView _buildScrollView(NSTextView textView) {
    final scrollView = NSScrollView.alloc().initWithFrame(
      _cgRect(0, 0, 640, 260),
    );
    scrollView.autoresizingMask =
        NSAutoresizingMaskOptions.NSViewWidthSizable |
        NSAutoresizingMaskOptions.NSViewHeightSizable;
    scrollView.hasVerticalScroller = true;
    scrollView.autohidesScrollers = true;
    scrollView.borderType = NSBorderType.NSNoBorder;
    scrollView.documentView = textView;

    textView.autoresizingMask = NSAutoresizingMaskOptions.NSViewWidthSizable;
    textView.isEditable$1 = true;
    textView.isSelectable$1 = true;
    textView.isRichText$1 = false;
    textView.drawsBackground$1 = true;
    textView.font = NSFont.userFixedPitchFontOfSize(14);
    textView.textColor = NSColor.getTextColor();
    textView.backgroundColor = NSColor.getTextBackgroundColor();
    textView.allowsUndo = true;
    return scrollView;
  }
}

final class _TextViewDelegate
    with NSTextViewDelegateDefaults, NSTextViewDelegateAdapter
    implements NSTextViewDelegateSpec {
  _TextViewDelegate(this._textView, this.onTextChanged);

  @override
  Set<ObjCProtocolMethod<dynamic>> get $implementedOptionalMethods => {
    NSTextViewDelegate$Builder.textDidChange_,
  };

  final NSTextView _textView;
  final ValueChanged<String> onTextChanged;

  @override
  void textDidChange(NSNotification notification) {
    onTextChanged(_textView.string.toDartString());
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
