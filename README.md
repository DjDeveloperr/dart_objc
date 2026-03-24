# dart_objc

Objective-C/AppKit/UIKit interop experiments for Dart and Flutter.

This setup covers two concrete app paths:

- a fully native AppKit app driven from Dart through an embedder host in
  [`host/`](./host) and source in (`lib/`)(./lib)
- a Flutter app that embeds Dart-built AppKit and UIKit views in
  [`examples/flutter/`](./examples/flutter)

Taking advantage of powerful FFI capabilities of Dart. This is a
proof-of-concept of potential that Dart has as a language that can provide ways
to write fully-native experiences, or hybrid UI with Flutter all while staying
in Dart-land.

Note: for some reason, Dart CLI on macOS is running the VM off the main thread,
which prevents using AppKit from there directly, hence the embedder host. It is
quite minimal though.

## Layout

- `ffigen/`: pinned fork of `dart-lang/native`, on the `objc-interop` branch
  with support for subclass helpers
- `packages/objc-foundation`: generated Foundation bindings
- `packages/objc-appkit`: generated AppKit bindings plus Flutter AppKit view
  helpers
- `packages/objc-uikit`: generated UIKit bindings plus Flutter UIKit view
  helpers
- `host/`: SwiftPM macOS host that embeds the Dart VM on main thread
- `examples/flutter/`: Flutter demo with embedded AppKit and UIKit scenes
- `tool/gen_objc_packages.dart`: package scaffolding + regeneration entrypoint
- `tool/bootstrap.sh`: repeatable local setup
- `tool/verify.sh`: repeatable verification for the repo surface we care about

## Prerequisites

- macOS with Xcode and command line tools
- Flutter with macOS and iOS simulator support
- Dart SDK

Clone with the forked `ffigen` submodule:

```bash
git clone --recurse-submodules https://github.com/DjDeveloperr/dart_objc.git
cd dart_objc
```

If the repo is already cloned:

```bash
git submodule update --init --recursive
```

## Bootstrap

```bash
./tool/bootstrap.sh
```

That does the minimum reproducible setup:

- initializes the nested `ffigen` fork submodule
- `dart pub get` at the repo root
- `dart pub get` in the nested `ffigen` fork
- regenerates the ObjC binding packages from the local fork
- `flutter pub get` for the Flutter demo

## Verify

```bash
./tool/verify.sh
```

The verification script checks the setup we actually depend on:

- Objective-C runtime/generator tests in `ffigen/pkgs/objective_c`
- repo-local analysis for `bin/`, `lib/`, `tool/`, `packages/`, and
  `examples/flutter/lib`
- Dart kernel compilation for the native host entrypoint
- `swift build` for the embedder host
- `flutter build macos`
- `flutter build ios --simulator --debug --no-codesign`

## Native AppKit Host

The native host path is a SwiftPM app that embeds the Dart VM and lets Dart own
the AppKit UI.

```bash
./host/check_embedder.sh
./host/run_host.sh
```

The Dart entrypoint is [`bin/objc_test.dart`](./bin/objc_test.dart), which
delegates to [`lib/demo_app.dart`](./lib/demo_app.dart).

## Flutter Demo

The Flutter demo registers platform-view factories from Dart and embeds native
views without app-specific Swift or Objective-C platform-view glue.

```bash
cd examples/flutter
flutter run -d macos
```

For iOS simulator:

```bash
cd examples/flutter
sh tool/run_ios_simulator.sh
```

More detail is in [`examples/flutter/README.md`](./examples/flutter/README.md).

## Creating Another Demo

The simplest way to build another demo on top of this setup is:

1. Keep the local `ffigen` fork checked out at `ffigen/`.
2. Depend on the local packages with path dependencies.
3. Regenerate package bindings after changing the forked ObjC generator/runtime.
4. Re-run `./tool/verify.sh` before relying on the new demo setup.

For a fresh clone, the shortest repeatable path is:

```bash
git clone --recurse-submodules https://github.com/DjDeveloperr/dart_objc.git
cd dart_objc
./tool/bootstrap.sh
./tool/verify.sh
```

Minimal dependency wiring for another Dart or Flutter project:

```yaml
dependencies:
  ffi: ^2.2.0
  objective_c:
    path: ../dart_objc/ffigen/pkgs/objective_c
  objc_foundation:
    path: ../dart_objc/packages/objc-foundation
  objc_appkit:
    path: ../dart_objc/packages/objc-appkit
  objc_uikit:
    path: ../dart_objc/packages/objc-uikit

dev_dependencies:
  ffigen:
    path: ../dart_objc/ffigen/pkgs/ffigen

dependency_overrides:
  ffi:
    path: ../dart_objc/ffigen/pkgs/ffi
```

For Flutter platform views:

- AppKit path: import `package:objc_appkit/flutter_views.dart`, call
  `registerObjCAppKitViewType(...)`, and mount `ObjCAppKitHostView`
- UIKit path: import `package:objc_uikit/flutter_views.dart`, call
  `registerObjCUiKitViewType(...)`, and mount `ObjCUiKitHostView`
