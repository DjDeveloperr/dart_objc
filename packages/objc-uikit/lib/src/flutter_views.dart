import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:objective_c/objective_c.dart' as objc;

import 'flutter_views_bindings.dart' as c;
import 'uikit_bindings.dart';

typedef _ObjectPtr = ffi.Pointer<objc.ObjCObjectImpl>;
typedef _SelectorPtr = ffi.Pointer<objc.ObjCSelector>;

final _registeredFactories = <String, objc.ObjCObject>{};
int _nextTransferredPlatformViewToken = 1;

final _selDelegate = objc.registerName('delegate');
final _selFirstObject = objc.registerName('firstObject');
final _selPluginRegistry = objc.registerName('pluginRegistry');
final _selRegistrarForPlugin = objc.registerName('registrarForPlugin:');
final _selRegisterViewFactoryWithId = objc.registerName(
  'registerViewFactory:withId:',
);
final _selRootViewController = objc.registerName('rootViewController');
final _selSharedApplication = objc.registerName('sharedApplication');
final _selWindow = objc.registerName('window');
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

int transferPlatformViewObject(UIView view) =>
    transferPlatformView(view.ref.pointer);

objc.ObjCObject _newTransferredPlatformViewFactory() {
  final factory = c.newTransferredPlatformViewFactory();
  if (factory.address == 0) {
    throw StateError(
      'Failed to create transferred UIKit platform view factory',
    );
  }
  return objc.ObjCObject(factory, retain: false, release: true);
}

Future<void> registerObjCUiKitViewType({
  required String viewType,
  String? pluginKey,
}) async {
  final key = pluginKey ?? 'objc_uikit.platform_view.$viewType';
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
  if (!Platform.isIOS) {
    throw UnsupportedError(
      'Transferred UIKit platform views are only supported on iOS',
    );
  }

  final app = _sendClassObject('UIApplication', _selSharedApplication);
  final delegate = _msgSendObject0(app.ref.pointer, _selDelegate);
  final pluginKeyObject = pluginKey.toNSString().ref.pointer;

  var registrar = delegate.address == 0
      ? ffi.nullptr
      : _msgSendObject1Object(
          delegate,
          _selRegistrarForPlugin,
          pluginKeyObject,
        );

  if (registrar.address == 0) {
    final delegateWindow = delegate.address == 0
        ? ffi.nullptr
        : _msgSendObject0(delegate, _selWindow);
    final appWindow = delegateWindow.address != 0
        ? delegateWindow
        : _msgSendObject0(
            _msgSendObject0(app.ref.pointer, _selWindows),
            _selFirstObject,
          );
    final rootViewController = appWindow.address == 0
        ? ffi.nullptr
        : _msgSendObject0(appWindow, _selRootViewController);
    final pluginRegistry = rootViewController.address == 0
        ? ffi.nullptr
        : _msgSendObject0(rootViewController, _selPluginRegistry);
    registrar = pluginRegistry.address == 0
        ? ffi.nullptr
        : _msgSendObject1Object(
            pluginRegistry,
            _selRegistrarForPlugin,
            pluginKeyObject,
          );
  }

  if (registrar.address == 0) {
    throw StateError(
      'Failed to find a Flutter plugin registrar for "$pluginKey" on iOS',
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

int _newTransferToken(UIView view) => transferPlatformViewObject(view);

class ObjCUiKitHostView extends StatefulWidget {
  const ObjCUiKitHostView({
    super.key,
    required this.viewType,
    required this.view,
    this.layoutDirection = TextDirection.ltr,
    this.creationParamsCodec = const StandardMessageCodec(),
  });

  final String viewType;
  final UIView view;
  final TextDirection layoutDirection;
  final MessageCodec<Object?> creationParamsCodec;

  @override
  State<ObjCUiKitHostView> createState() => _ObjCUiKitHostViewState();
}

class _ObjCUiKitHostViewState extends State<ObjCUiKitHostView> {
  late int _transferToken = _newTransferToken(widget.view);

  @override
  void didUpdateWidget(covariant ObjCUiKitHostView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.view.ref.pointer.address != widget.view.ref.pointer.address) {
      _transferToken = _newTransferToken(widget.view);
    }
  }

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: widget.viewType,
      layoutDirection: widget.layoutDirection,
      creationParams: _transferToken,
      creationParamsCodec: widget.creationParamsCodec,
    );
  }
}
