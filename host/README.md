# Native Host

Minimal macOS Cocoa host that embeds the Dart VM in-process and lets Dart own
the AppKit UI.

## What it verifies

- the Dart SDK exposes the embedder headers and `dartvm`
- the host can compile as a SwiftPM app
- the Dart entrypoint can be compiled to a kernel for embedded execution

## Quick Start

From the repo root:

```bash
./tool/bootstrap.sh
./host/check_embedder.sh
./host/run_host.sh
```

The host compiles [`bin/objc_test.dart`](../bin/objc_test.dart) to a kernel and
launches the AppKit demo from [`lib/demo_app.dart`](../lib/demo_app.dart).

## Verification

`./tool/verify.sh` covers the reproducible parts of the native-host flow:

- `./host/check_embedder.sh`
- `dart compile kernel -DOBJC_TEST_EMBEDDED=true bin/objc_test.dart ...`
- `swift build --package-path host`

The final GUI launch remains manual through `./host/run_host.sh`.

## Environment Overrides

- `DART_BIN`: `dart` executable used to compile the kernel
- `DART_ENTRYPOINT`: Dart file to compile, default `bin/objc_test.dart`
- `DART_KERNEL_PATH`: output kernel path
- `SKIP_KERNEL_COMPILE=1`: skip kernel compilation inside `run_host.sh`
- `DART_VM_BIN`: `dartvm` used for embedding
- `DART_SDK_INCLUDE`: include dir containing `dart_api.h`
- `DART_SCRIPT_URI`: script URI passed to isolate creation
- `DART_ENTRYPOINT_SYMBOL`: entrypoint symbol name, default `main`
- `OBJC_TEST_EMBEDDED`: compile-time flag passed through to the Dart app
- `OBJC_TEST_REPO_ROOT`: repo root for the host runtime context
- `OBJECTIVE_C_DYLIB`: path to `objective_c.dylib` preloaded with `RTLD_GLOBAL`
- `HOST_BUILD_DIR`: output dir for host-generated dylibs
- `FOUNDATION_BINDINGS_DYLIB`: optional prebuilt `objc_foundation` bindings dylib
- `APPKIT_BINDINGS_DYLIB`: optional prebuilt `objc_appkit` bindings dylib
- `SKIP_BINDINGS_COMPILE=1`: skip compiling native helper/binding dylibs
