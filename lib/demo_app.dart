import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:objective_c/objective_c.dart';
import 'package:objc_appkit/objc_appkit.dart';
import 'package:objc_metal/objc_metal.dart' as metal;
import 'package:objc_metalkit/objc_metalkit.dart' as metalkit;
import 'package:objective_c/objective_c.dart' as objc;

import 'src/appkit_geometry.dart';

const bool _embeddedMode = bool.fromEnvironment(
  'OBJC_TEST_EMBEDDED',
  defaultValue: false,
);

NSWindow? _window;
DemoAppDelegate? _appDelegate;
_MetalTriangleRenderer? _metalTriangleRenderer;

@Native<Pointer<objc.ObjCObjectImpl> Function()>(
  symbol: 'MTLCreateSystemDefaultDevice',
)
external Pointer<objc.ObjCObjectImpl> _mtlCreateSystemDefaultDeviceRaw();

metal.MTLDevice? _createSystemDefaultDevice() {
  final pointer = _mtlCreateSystemDefaultDeviceRaw();
  return pointer.address == 0
      ? null
      : metal.MTLDevice.fromPointer(pointer, retain: true, release: true);
}

final class _MetalTriangleRenderer
    with metalkit.MTKViewDelegateAdapter
    implements metalkit.MTKViewDelegateSpec {
  _MetalTriangleRenderer._(
    this.device,
    this.commandQueue,
    this.pipelineState,
    this.shaderLibrary,
  );

  final metal.MTLDevice device;
  final metal.MTLCommandQueue commandQueue;
  final metal.MTLRenderPipelineState pipelineState;
  final metal.MTLLibrary shaderLibrary;

  static _MetalTriangleRenderer? create() {
    final device = _createSystemDefaultDevice();
    if (device == null) {
      return null;
    }

    final shaderLibrary = device.newLibraryWithSourceOptionsError(
      _triangleShaderSource.toNSString(),
    );
    if (shaderLibrary == null) {
      return null;
    }

    final vertexFunction = shaderLibrary.newFunctionWithName(
      'triangleVertex'.toNSString(),
    );
    final fragmentFunction = shaderLibrary.newFunctionWithName(
      'triangleFragment'.toNSString(),
    );
    if (vertexFunction == null || fragmentFunction == null) {
      return null;
    }

    final descriptor = metal.MTLRenderPipelineDescriptor();
    descriptor.label = 'Demo Triangle Pipeline'.toNSString();
    descriptor.vertexFunction = vertexFunction;
    descriptor.fragmentFunction = fragmentFunction;
    descriptor.colorAttachments.objectAtIndexedSubscript(0).pixelFormat =
        metal.MTLPixelFormat.MTLPixelFormatBGRA8Unorm;

    final pipelineState = device.newRenderPipelineStateWithDescriptorError(
      descriptor,
    );
    final commandQueue = device.newCommandQueue();
    if (pipelineState == null || commandQueue == null) {
      return null;
    }

    return _MetalTriangleRenderer._(
      device,
      commandQueue,
      pipelineState,
      shaderLibrary,
    );
  }

  @override
  void drawInMTKView(metalkit.MTKView view) {
    final renderPassDescriptor = view.currentRenderPassDescriptor;
    final drawable = view.currentDrawable;
    final commandBuffer = commandQueue.commandBuffer();
    if (renderPassDescriptor == null ||
        drawable == null ||
        commandBuffer == null) {
      return;
    }

    final metalRenderPassDescriptor = metal.MTLRenderPassDescriptor.fromPointer(
      renderPassDescriptor.ref.pointer,
      retain: true,
      release: true,
    );
    final metalDrawable = metal.MTLDrawable.fromPointer(
      drawable.ref.pointer,
      retain: true,
      release: true,
    );
    final encoder = commandBuffer.renderCommandEncoderWithDescriptor(
      metalRenderPassDescriptor,
    );
    if (encoder == null) {
      return;
    }

    encoder.setRenderPipelineState(pipelineState);
    encoder.drawPrimitivesVertexStartVertexCount(
      metal.MTLPrimitiveType.MTLPrimitiveTypeTriangle,
      vertexStart: 0,
      vertexCount: 3,
    );
    encoder.endEncoding();
    commandBuffer.presentDrawable(metalDrawable);
    commandBuffer.commit();
  }

  @override
  void mtkView(
    metalkit.MTKView view, {
    required CGSize drawableSizeWillChange,
  }) {}
}

const _triangleShaderSource = '''
#include <metal_stdlib>
using namespace metal;

struct VertexOut {
  float4 position [[position]];
  float4 color;
};

vertex VertexOut triangleVertex(uint vertexID [[vertex_id]]) {
  constexpr float2 positions[3] = {
    float2(0.0, 0.72),
    float2(-0.72, -0.54),
    float2(0.72, -0.54),
  };

  constexpr float4 colors[3] = {
    float4(0.44, 0.95, 0.83, 1.0),
    float4(0.98, 0.76, 0.31, 1.0),
    float4(0.54, 0.71, 1.0, 1.0),
  };

  VertexOut out;
  out.position = float4(positions[vertexID], 0.0, 1.0);
  out.color = colors[vertexID];
  return out;
}

fragment float4 triangleFragment(VertexOut in [[stage_in]]) {
  return in.color;
}
''';

final class DemoAppDelegate
    with NSApplicationDelegateDefaults, NSApplicationDelegateAdapter
    implements NSApplicationDelegateSpec {
  DemoAppDelegate(this.app);

  final NSApplication app;

  @override
  void applicationDidFinishLaunching(NSNotification notification) {
    _showMainWindow(app);
  }

  @override
  bool applicationShouldTerminateAfterLastWindowClosed(NSApplication sender) =>
      true;

  @override
  NSApplicationTerminateReply applicationShouldTerminate(
    NSApplication sender,
  ) => NSApplicationTerminateReply.NSTerminateNow;

  @override
  void applicationWillTerminate(NSNotification notification) {
    _window = null;
  }
}

final class DemoViewController
    with NSViewControllerDefaults, NSViewControllerSubclass
    implements NSViewControllerOverrides {
  @override
  Set<String> get objcOverrideSelectors => {
    NSViewControllerOverrideSelectors.loadView,
  };

  @override
  void loadView() {
    asNSViewController.view = _buildContentView();
  }
}

void runDemoApp() {
  final app = NSApplication.getSharedApplication();
  app.setActivationPolicy(
    NSApplicationActivationPolicy.NSApplicationActivationPolicyRegular,
  );

  _appDelegate ??= DemoAppDelegate(app);
  app.delegate = _appDelegate!.asNSApplicationDelegate;

  if (app.isRunning) {
    _showMainWindow(app);
    return;
  }

  if (!_embeddedMode) {
    app.run();
  }
}

void _showMainWindow(NSApplication app) {
  final existingWindow = _window;
  if (existingWindow != null) {
    existingWindow.makeKeyAndOrderFront(null);
    app.activateIgnoringOtherApps(true);
    return;
  }

  final window = _buildMainWindow();
  _window = window;
  window.makeKeyAndOrderFront(null);
  app.activateIgnoringOtherApps(true);
}

NSWindow _buildMainWindow() {
  final window = NSWindow.alloc().initWithContentRectStyleMaskBackingDefer(
    cgRect(220, 180, 980, 680),
    styleMask:
        NSWindowStyleMask.NSWindowStyleMaskTitled |
        NSWindowStyleMask.NSWindowStyleMaskClosable |
        NSWindowStyleMask.NSWindowStyleMaskResizable |
        NSWindowStyleMask.NSWindowStyleMaskFullSizeContentView,
    backing: NSBackingStoreType.NSBackingStoreBuffered,
    defer: false,
  );
  window.title = 'Dart AppKit Studio'.toNSString();
  window.titleVisibility = NSWindowTitleVisibility.NSWindowTitleHidden;
  window.titlebarAppearsTransparent = true;
  window.toolbarStyle = NSWindowToolbarStyle.NSWindowToolbarStyleUnifiedCompact;
  window.isMovableByWindowBackground = true;
  window.isReleasedWhenClosed = false;
  window.backgroundColor = NSColor.colorWithSRGBRed(
    0.09,
    green: 0.1,
    blue: 0.12,
    alpha: 1.0,
  );
  window.center();
  window.contentMinSize = CGSize.$allocate(calloc, width: 820, height: 560).ref;
  window.contentViewController = DemoViewController().asNSViewController;

  return window;
}

NSVisualEffectView _buildContentView() {
  final root = NSVisualEffectView.alloc().initWithFrame(cgRect(0, 0, 980, 680));
  root.autoresizingMask =
      NSAutoresizingMaskOptions.NSViewWidthSizable |
      NSAutoresizingMaskOptions.NSViewHeightSizable;
  root.blendingMode =
      NSVisualEffectBlendingMode.NSVisualEffectBlendingModeWithinWindow;
  root.material =
      NSVisualEffectMaterial.NSVisualEffectMaterialUnderWindowBackground;
  root.state = NSVisualEffectState.NSVisualEffectStateActive;

  final eyebrow = NSTextField.labelWithString('EMBEDDED DART VM'.toNSString());
  eyebrow.frame = cgRect(44, 606, 892, 20);
  eyebrow.autoresizingMask =
      NSAutoresizingMaskOptions.NSViewWidthSizable |
      NSAutoresizingMaskOptions.NSViewMinYMargin;
  eyebrow.font = NSFont.monospacedSystemFontOfSize(12, weight: 0.32);
  eyebrow.textColor = NSColor.getSecondaryLabelColor();
  root.addSubview(eyebrow);

  final title = NSTextField.labelWithString('Native UI from Dart'.toNSString());
  title.frame = cgRect(44, 528, 892, 64);
  title.autoresizingMask =
      NSAutoresizingMaskOptions.NSViewWidthSizable |
      NSAutoresizingMaskOptions.NSViewMinYMargin;
  title.font = NSFont.systemFontOfSizeWeight(52, weight: 0.75);
  title.textColor = NSColor.getLabelColor();
  root.addSubview(title);

  final subtitle = NSTextField.wrappingLabelWithString(
    'AppKit on the outside. A live Metal view in the middle. All driven from Dart.'
        .toNSString(),
  );
  subtitle.frame = cgRect(44, 462, 760, 52);
  subtitle.autoresizingMask =
      NSAutoresizingMaskOptions.NSViewWidthSizable |
      NSAutoresizingMaskOptions.NSViewMinYMargin;
  subtitle.maximumNumberOfLines = 2;
  subtitle.font = NSFont.systemFontOfSize(18);
  subtitle.textColor = NSColor.getSecondaryLabelColor();
  root.addSubview(subtitle);

  final accent = NSColor.getControlAccentColor();
  final metalShowcase = _buildMetalShowcase();
  metalShowcase.autoresizingMask =
      NSAutoresizingMaskOptions.NSViewWidthSizable |
      NSAutoresizingMaskOptions.NSViewMinYMargin |
      NSAutoresizingMaskOptions.NSViewMaxYMargin;
  root.addSubview(metalShowcase);

  final quitButton = _buttonWithTitleAction(
    'Quit Host',
    target: NSApplication.getSharedApplication(),
    action: registerName('terminate:'),
  );
  quitButton.frame = cgRect(44, 72, 154, 42);
  quitButton.autoresizingMask = NSAutoresizingMaskOptions.NSViewMaxYMargin;
  quitButton.bezelStyle = NSBezelStyle.NSBezelStyleRounded;
  quitButton.contentTintColor = accent;
  quitButton.font = NSFont.systemFontOfSizeWeight(14, weight: 0.58);
  quitButton.keyEquivalent = 'q'.toNSString();
  root.addSubview(quitButton);

  final footnote = NSTextField.labelWithString(
    'Tip: press Q to close'.toNSString(),
  );
  footnote.frame = cgRect(212, 84, 300, 18);
  footnote.autoresizingMask = NSAutoresizingMaskOptions.NSViewMaxYMargin;
  footnote.font = NSFont.monospacedSystemFontOfSize(11, weight: 0.22);
  footnote.textColor = NSColor.getTertiaryLabelColor();
  root.addSubview(footnote);

  return root;
}

NSView _buildMetalShowcase() {
  final frame = cgRect(44, 212, 892, 248);

  _metalTriangleRenderer ??= _MetalTriangleRenderer.create();
  final renderer = _metalTriangleRenderer;
  if (renderer == null) {
    final fallback = NSBox.alloc().initWithFrame(frame);
    fallback.boxType = NSBoxType.NSBoxCustom;
    fallback.titlePosition = NSTitlePosition.NSNoTitle;
    fallback.cornerRadius = 24;
    fallback.borderWidth = 1.0;
    fallback.fillColor = NSColor.colorWithSRGBRed(
      0.13,
      green: 0.14,
      blue: 0.18,
      alpha: 0.92,
    );
    fallback.borderColor = NSColor.getSystemRedColor().colorWithAlphaComponent(
      0.38,
    );

    final label = NSTextField.labelWithString(
      'Metal is unavailable on this machine.'.toNSString(),
    );
    label.frame = cgRect(30, 108, 400, 32);
    label.font = NSFont.systemFontOfSizeWeight(24, weight: 0.62);
    label.textColor = NSColor.getLabelColor();
    fallback.addSubview(label);
    return fallback;
  }

  final metalView = metalkit.MTKView.alloc().initWithFrameDevice(
    frame,
    device: metalkit.MTLDevice.fromPointer(
      renderer.device.ref.pointer,
      retain: true,
      release: true,
    ),
  );
  metalView.colorPixelFormat = metalkit.MTLPixelFormat.MTLPixelFormatBGRA8Unorm;
  metalView.clearColor = metalkit.MTLClearColor.$allocate(
    calloc,
    red: 0.08,
    green: 0.09,
    blue: 0.12,
    alpha: 1.0,
  ).ref;
  metalView.enableSetNeedsDisplay = false;
  metalView.isPaused = false;
  metalView.preferredFramesPerSecond = 60;
  metalView.framebufferOnly = true;
  metalView.delegate = renderer.asMTKViewDelegateBlocking;
  metalView.draw();
  return NSView.fromPointer(metalView.ref.pointer, retain: true, release: true);
}

NSButton _buttonWithTitleAction(
  String title, {
  ObjCObject? target,
  required Pointer<ObjCSelector> action,
}) {
  return NSButton.buttonWithTitleTargetAction(
    title.toNSString(),
    target: target,
    action: action,
  );
}
