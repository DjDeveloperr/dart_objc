#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT"

SKIP_BOOTSTRAP=${SKIP_BOOTSTRAP:-0}
SKIP_IOS=${SKIP_IOS:-0}

find_dart_sdk_root() {
  local dart_bin dart_real target bin_dir repo_root
  dart_bin=${DART_BIN:-$(command -v dart || true)}
  if [[ -z "$dart_bin" ]]; then
    echo "dart not found on PATH" >&2
    return 1
  fi

  if [[ -L "$dart_bin" ]]; then
    target=$(readlink "$dart_bin")
    if [[ "$target" = /* ]]; then
      dart_real="$target"
    else
      dart_real="$(cd "$(dirname "$dart_bin")" && cd "$(dirname "$target")" && pwd)/$(basename "$target")"
    fi
  else
    dart_real="$dart_bin"
  fi

  bin_dir=$(cd "$(dirname "$dart_real")" && pwd)
  repo_root=$(cd "$bin_dir/.." && pwd)

  local candidates=(
    "$repo_root"
    "$repo_root/libexec"
    "$repo_root/bin/cache/dart-sdk"
    "$bin_dir/../cache/dart-sdk"
  )
  local candidate
  for candidate in "${candidates[@]}"; do
    if [[ -f "$candidate/include/dart_api.h" && -x "$candidate/bin/dartvm" ]]; then
      echo "$candidate"
      return 0
    fi
  done

  echo "$repo_root"
}

if [[ "$SKIP_BOOTSTRAP" != "1" ]]; then
  ./tool/bootstrap.sh
fi

echo "==> verify host embedder prerequisites"
./host/check_embedder.sh
SDK_ROOT=$(find_dart_sdk_root)
export DART_SDK_INCLUDE="${DART_SDK_INCLUDE:-$SDK_ROOT/include}"
export DART_VM_BIN="${DART_VM_BIN:-$SDK_ROOT/bin/dartvm}"

echo "==> verify Objective-C runtime/generator tests"
ffigen_pre_test_status=$(git -C "$ROOT/ffigen" status --porcelain)
(
  cd ffigen/pkgs/objective_c
  dart pub get
  dart test -r compact \
    test/subclass_builder_test.dart \
    test/generate_code_test.dart \
    test/hook_build_path_test.dart \
    test/interface_lists_test.dart
)
if [[ -z "$ffigen_pre_test_status" ]]; then
  git -C "$ROOT/ffigen" restore -- \
    pkgs/ffigen/lib/src/code_generator/objc_built_in_types.dart
fi

echo "==> analyze parent repo surface"
analysis_paths=(
  bin
  lib
  tool
  packages/objc-appkit/lib/objc_appkit.dart
  packages/objc-appkit/lib/flutter_views.dart
  packages/objc-appkit/lib/src/flutter_views.dart
  packages/objc-appkit/lib/src/flutter_views_bindings.dart
  packages/objc-appkit/hook/build.dart
  packages/objc-foundation/lib/objc_foundation.dart
  packages/objc-metal/lib/objc_metal.dart
  packages/objc-metalkit/lib/objc_metalkit.dart
  packages/objc-uikit/lib/objc_uikit.dart
  packages/objc-uikit/lib/flutter_views.dart
  packages/objc-uikit/lib/src/flutter_views.dart
  packages/objc-uikit/lib/src/flutter_views_bindings.dart
  packages/objc-uikit/hook/build.dart
)
dart analyze "${analysis_paths[@]}"

echo "==> analyze Flutter example surface"
(
  cd examples/flutter
  flutter analyze lib
)

echo "==> compile embedded Dart kernel"
mkdir -p host/build
dart compile kernel -DOBJC_TEST_EMBEDDED=true \
  bin/objc_test.dart \
  -o host/build/objc_test.dill

echo "==> build native host"
swift build --package-path host

echo "==> build Flutter demo for macOS"
(
  cd examples/flutter
  flutter build macos
)

if [[ "$SKIP_IOS" != "1" ]]; then
  echo "==> build Flutter demo for iOS simulator"
  (
    cd examples/flutter
    flutter build ios --simulator --debug --no-codesign
  )
fi

echo "Verification complete."
