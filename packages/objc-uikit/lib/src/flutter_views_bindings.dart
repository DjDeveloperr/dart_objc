@ffi.DefaultAsset('package:objc_uikit/objc_uikit_flutter_views.dylib')
library;

import 'dart:ffi' as ffi;

import 'package:objective_c/objective_c.dart' as objc;

@ffi.Native<ffi.Pointer<objc.ObjCObjectImpl> Function()>(
  symbol: 'DOBJCUIKIT_newTransferredPlatformViewFactory',
)
external ffi.Pointer<objc.ObjCObjectImpl> newTransferredPlatformViewFactory();

@ffi.Native<ffi.Void Function(ffi.Int64, ffi.Pointer<objc.ObjCObjectImpl>)>(
  symbol: 'DOBJCUIKIT_storeTransferredPlatformView',
)
external void storeTransferredPlatformView(
  int token,
  ffi.Pointer<objc.ObjCObjectImpl> view,
);
