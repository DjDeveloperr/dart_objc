@TestOn('mac-os')
library;

import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_objc_appkit_embed/native_appkit_editor.dart';
import 'package:objc_appkit/objc_appkit.dart';
import 'package:objective_c/objective_c.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'the editor delegate preserves selection and only advertises its callback',
    () {
      final scene = ObjcAppKitEditorScene(
        initialText: 'Select me',
        onTextChanged: (_) {},
      );
      final delegate = scene.delegate;

      expect(
        delegate.respondsToSelector('textDidChange:'.toSelector()),
        isTrue,
      );
      expect(
        delegate.respondsToSelector(
          'textView:willChangeSelectionFromCharacterRange:toCharacterRange:'
              .toSelector(),
        ),
        isFalse,
        reason: 'Advertising this unimplemented callback resets the selection.',
      );
      expect(
        delegate.respondsToSelector(
          'textView:willChangeSelectionFromCharacterRanges:toCharacterRanges:'
              .toSelector(),
        ),
        isFalse,
      );

      final requestedSelection =
          Struct.create<NSRange>(Uint8List(sizeOf<NSRange>()))
            ..location = 4
            ..length = 2;
      final text = NSText.as(scene.textView);
      text.selectedRange = requestedSelection;
      final actualSelection = text.selectedRange;

      expect(actualSelection.location, 4);
      expect(actualSelection.length, 2);
    },
  );
}
