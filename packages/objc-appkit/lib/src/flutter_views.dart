import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:objective_c/objective_c.dart' as objc;

import 'flutter_views_bindings.dart' as c;
import 'appkit_bindings.dart';

typedef _ObjectPtr = ffi.Pointer<objc.ObjCObjectImpl>;
typedef _SelectorPtr = ffi.Pointer<objc.ObjCSelector>;

final _registeredFactories = <String, objc.ObjCObject>{};
int _nextTransferredPlatformViewToken = 1;

final _selContentViewController = objc.registerName('contentViewController');
final _selFirstObject = objc.registerName('firstObject');
final _selMainWindow = objc.registerName('mainWindow');
final _selRegistrarForPlugin = objc.registerName('registrarForPlugin:');
final _selRegisterViewFactoryWithId = objc.registerName(
  'registerViewFactory:withId:',
);
final _selSharedApplication = objc.registerName('sharedApplication');
final _selWindows = objc.registerName('windows');

final _msgSendObject0 = objc.msgSendPointer
    .cast<ffi.NativeFunction<_ObjectPtr Function(_ObjectPtr, _SelectorPtr)>>()
    .asFunction<_ObjectPtr Function(_ObjectPtr, _SelectorPtr)>();

final _msgSendObject1Object = objc.msgSendPointer
    .cast<
      ffi.NativeFunction<
        _ObjectPtr Function(_ObjectPtr, _SelectorPtr, _ObjectPtr)
      >
    >()
    .asFunction<_ObjectPtr Function(_ObjectPtr, _SelectorPtr, _ObjectPtr)>();

final _msgSendVoid2Object = objc.msgSendPointer
    .cast<
      ffi.NativeFunction<
        ffi.Void Function(_ObjectPtr, _SelectorPtr, _ObjectPtr, _ObjectPtr)
      >
    >()
    .asFunction<
      void Function(_ObjectPtr, _SelectorPtr, _ObjectPtr, _ObjectPtr)
    >();

int transferPlatformView(ffi.Pointer<objc.ObjCObjectImpl> viewPointer) {
  if (viewPointer.address == 0) {
    throw ArgumentError.value(viewPointer, 'viewPointer', 'must not be null');
  }
  final token = _nextTransferredPlatformViewToken++;
  c.storeTransferredPlatformView(token, viewPointer);
  return token;
}

int transferPlatformViewObject(NSView view) =>
    transferPlatformView(view.ref.pointer);

objc.ObjCObject _newTransferredPlatformViewFactory() {
  final factory = c.newTransferredPlatformViewFactory();
  if (factory.address == 0) {
    throw StateError(
      'Failed to create transferred AppKit platform view factory',
    );
  }
  return objc.ObjCObject(factory, retain: false, release: true);
}

Future<void> registerObjCAppKitViewType({
  required String viewType,
  String? pluginKey,
}) async {
  final key = pluginKey ?? 'objc_appkit.platform_view.$viewType';
  final factory = _newTransferredPlatformViewFactory();
  final registrar = _findFlutterRegistrar(key);
  _msgSendVoid2Object(
    registrar.ref.pointer,
    _selRegisterViewFactoryWithId,
    factory.ref.pointer,
    viewType.toNSString().ref.pointer,
  );
  _registeredFactories[viewType] = factory;
}

objc.ObjCObject _findFlutterRegistrar(String pluginKey) {
  if (!Platform.isMacOS) {
    throw UnsupportedError(
      'Transferred AppKit platform views are only supported on macOS',
    );
  }

  final app = _sendClassObject('NSApplication', _selSharedApplication);
  final mainWindow = _msgSendObject0(app.ref.pointer, _selMainWindow);
  final window = mainWindow.address != 0
      ? mainWindow
      : _msgSendObject0(
          _msgSendObject0(app.ref.pointer, _selWindows),
          _selFirstObject,
        );
  final controller = _msgSendObject0(window, _selContentViewController);
  final registrar = _msgSendObject1Object(
    controller,
    _selRegistrarForPlugin,
    pluginKey.toNSString().ref.pointer,
  );
  if (registrar.address == 0) {
    throw StateError(
      'Failed to find a Flutter plugin registrar for "$pluginKey" on macOS',
    );
  }
  return objc.ObjCObject(registrar, retain: true, release: true);
}

objc.ObjCObject _sendClassObject(String className, _SelectorPtr selector) =>
    objc.ObjCObject(
      _msgSendObject0(objc.getClass(className), selector),
      retain: true,
      release: true,
    );

int _newTransferToken(NSView view) => transferPlatformViewObject(view);

class ObjCAppKitHostView extends StatefulWidget {
  const ObjCAppKitHostView({
    super.key,
    required this.viewType,
    required this.view,
    this.layoutDirection = TextDirection.ltr,
    this.creationParamsCodec = const StandardMessageCodec(),
  });

  final String viewType;
  final NSView view;
  final TextDirection layoutDirection;
  final MessageCodec<Object?> creationParamsCodec;

  @override
  State<ObjCAppKitHostView> createState() => _ObjCAppKitHostViewState();
}

class _ObjCAppKitHostViewState extends State<ObjCAppKitHostView> {
  late int _transferToken = _newTransferToken(widget.view);

  @override
  void didUpdateWidget(covariant ObjCAppKitHostView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.view.ref.pointer.address != widget.view.ref.pointer.address) {
      _transferToken = _newTransferToken(widget.view);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppKitView(
      viewType: widget.viewType,
      layoutDirection: widget.layoutDirection,
      creationParams: _transferToken,
      creationParamsCodec: widget.creationParamsCodec,
    );
  }
}
