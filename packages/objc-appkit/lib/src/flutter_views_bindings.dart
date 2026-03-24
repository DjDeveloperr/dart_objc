@ffi.DefaultAsset('package:objc_appkit/objc_appkit_flutter_views.dylib')
library;

import 'dart:ffi' as ffi;

import 'package:objective_c/objective_c.dart' as objc;

@ffi.Native<ffi.Pointer<objc.ObjCObjectImpl> Function()>(
  symbol: 'DOBJCAPPKIT_newTransferredPlatformViewFactory',
)
external ffi.Pointer<objc.ObjCObjectImpl> newTransferredPlatformViewFactory();

@ffi.Native<ffi.Void Function(ffi.Int64, ffi.Pointer<objc.ObjCObjectImpl>)>(
  symbol: 'DOBJCAPPKIT_storeTransferredPlatformView',
)
external void storeTransferredPlatformView(
  int token,
  ffi.Pointer<objc.ObjCObjectImpl> view,
);
