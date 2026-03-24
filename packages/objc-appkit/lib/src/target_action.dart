import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:objective_c/objective_c.dart' as objc;

import 'appkit_bindings.dart';

/// A small helper for wiring AppKit target/action callbacks from Dart.
final class NSButtonTargetAction {
  NSButtonTargetAction._(this.target, this.action);

  final objc.NSObject target;
  final Pointer<objc.ObjCSelector> action;

  factory NSButtonTargetAction.listener(
    void Function() onPressed, {
    String selectorName = 'handlePress:',
    String debugName = 'NSButtonTargetAction',
  }) {
    final action = objc.registerName(selectorName);
    final builder = objc.ObjCSubclassBuilder(
      superclassName: 'NSObject',
      debugName: debugName,
    );
    final signature = 'v@:@'.toNativeUtf8();
    builder.implementMethod(
      action,
      signature.cast(),
      ObjCBlock_ffiVoid_ffiVoid_NSButton.protocolTrampoline,
      ObjCBlock_ffiVoid_ffiVoid_NSButton.listener((
        Pointer<Void> _,
        NSButton? button,
      ) {
        if (button == null) {
          return;
        }
        onPressed();
      }),
    );
    calloc.free(signature);
    return NSButtonTargetAction._(objc.NSObject.as(builder.build()), action);
  }
}
