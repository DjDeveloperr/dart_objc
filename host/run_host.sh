#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT"

DART_BIN=${DART_BIN:-$(command -v dart || true)}
if [[ -z "$DART_BIN" ]]; then
  echo "dart not found on PATH"
  exit 1
fi

if [[ -L "$DART_BIN" ]]; then
  TARGET=$(readlink "$DART_BIN")
  if [[ "$TARGET" = /* ]]; then
    DART_REAL="$TARGET"
  else
    DART_REAL="$(cd "$(dirname "$DART_BIN")" && cd "$(dirname "$TARGET")" && pwd)/$(basename "$TARGET")"
  fi
else
  DART_REAL="$DART_BIN"
fi

find_sdk_root() {
  local dart_real="$1"
  local bin_dir repo_root
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

SDK_ROOT=$(find_sdk_root "$DART_REAL")

ENTRYPOINT=${DART_ENTRYPOINT:-"$ROOT/bin/objc_test.dart"}
KERNEL_PATH=${DART_KERNEL_PATH:-"$ROOT/host/build/objc_test.dill"}
OBJECTIVE_C_DYLIB=${OBJECTIVE_C_DYLIB:-}
HOST_BUILD_DIR=${HOST_BUILD_DIR:-"$ROOT/host/build"}
FOUNDATION_BINDINGS_DYLIB=${FOUNDATION_BINDINGS_DYLIB:-"$HOST_BUILD_DIR/objc_foundation_bindings.dylib"}
APPKIT_BINDINGS_DYLIB=${APPKIT_BINDINGS_DYLIB:-"$HOST_BUILD_DIR/objc_appkit_bindings.dylib"}
METAL_BINDINGS_DYLIB=${METAL_BINDINGS_DYLIB:-"$HOST_BUILD_DIR/objc_metal_bindings.dylib"}
METALKIT_BINDINGS_DYLIB=${METALKIT_BINDINGS_DYLIB:-"$HOST_BUILD_DIR/objc_metalkit_bindings.dylib"}

if [[ "${SKIP_KERNEL_COMPILE:-0}" != "1" ]]; then
  mkdir -p "$(dirname "$KERNEL_PATH")"
  echo "Compiling kernel: $ENTRYPOINT -> $KERNEL_PATH"
  EMBEDDED_DEFINE_VALUE="${OBJC_TEST_EMBEDDED:-1}"
  if [[ "$EMBEDDED_DEFINE_VALUE" == "1" ]]; then
    EMBEDDED_DART_DEFINE="-DOBJC_TEST_EMBEDDED=true"
  else
    EMBEDDED_DART_DEFINE="-DOBJC_TEST_EMBEDDED=false"
  fi
  "$DART_BIN" compile kernel "$EMBEDDED_DART_DEFINE" "$ENTRYPOINT" -o "$KERNEL_PATH"
fi

if [[ "${SKIP_BINDINGS_COMPILE:-0}" != "1" ]]; then
  CLANG_BIN=${CLANG_BIN:-$(command -v clang || true)}
  if [[ -z "$CLANG_BIN" ]]; then
    echo "clang not found on PATH"
    exit 1
  fi

  mkdir -p "$HOST_BUILD_DIR"
  shopt -s nullglob

  FOUNDATION_SOURCES=("$ROOT/packages/objc-foundation/native/foundation_bindings.m")
  APPKIT_SOURCES=("$ROOT/packages/objc-appkit/native/"appkit*_bindings.m)
  METAL_SOURCES=("$ROOT/packages/objc-metal/native/"metal*_bindings.m)
  METALKIT_SOURCES=("$ROOT/packages/objc-metalkit/native/metalkit_bindings.m")

  if [[ -f "${FOUNDATION_SOURCES[0]}" ]]; then
    echo "Compiling Foundation bindings dylib into $FOUNDATION_BINDINGS_DYLIB"
    "$CLANG_BIN" -dynamiclib -fobjc-arc \
      -o "$FOUNDATION_BINDINGS_DYLIB" \
      "${FOUNDATION_SOURCES[@]}" \
      -framework Foundation
  else
    echo "Skipping Foundation bindings dylib compile (no source at ${FOUNDATION_SOURCES[0]})"
  fi

  if (( ${#APPKIT_SOURCES[@]} > 0 )); then
    echo "Compiling AppKit bindings dylib into $APPKIT_BINDINGS_DYLIB"
    "$CLANG_BIN" -dynamiclib -fobjc-arc \
      -o "$APPKIT_BINDINGS_DYLIB" \
      "${APPKIT_SOURCES[@]}" \
      -framework Foundation \
      -framework AppKit
  else
    echo "Skipping AppKit bindings dylib compile (no matching sources in $ROOT/packages/objc-appkit/native)"
  fi

  if (( ${#METAL_SOURCES[@]} > 0 )); then
    echo "Compiling Metal bindings dylib into $METAL_BINDINGS_DYLIB"
    "$CLANG_BIN" -dynamiclib -fobjc-arc \
      -o "$METAL_BINDINGS_DYLIB" \
      "${METAL_SOURCES[@]}" \
      -framework Foundation \
      -framework Metal
  else
    echo "Skipping Metal bindings dylib compile (no matching sources in $ROOT/packages/objc-metal/native)"
  fi

  if [[ -f "${METALKIT_SOURCES[0]}" ]]; then
    echo "Compiling MetalKit bindings dylib into $METALKIT_BINDINGS_DYLIB"
    "$CLANG_BIN" -dynamiclib -fobjc-arc \
      -o "$METALKIT_BINDINGS_DYLIB" \
      "${METALKIT_SOURCES[@]}" \
      -framework Foundation \
      -framework AppKit \
      -framework Metal \
      -framework MetalKit
  else
    echo "Skipping MetalKit bindings dylib compile (no source at ${METALKIT_SOURCES[0]})"
  fi

  shopt -u nullglob
fi

ENTRYPOINT_ABS=$(cd "$(dirname "$ENTRYPOINT")" && pwd)/$(basename "$ENTRYPOINT")

if [[ -z "$OBJECTIVE_C_DYLIB" ]]; then
  CANDIDATES=(
    "$ROOT/.dart_tool/lib/objective_c.dylib"
    "$ROOT/build/host_test/bundle/lib/objective_c.dylib"
  )
  for candidate in "${CANDIDATES[@]}"; do
    if [[ -f "$candidate" ]]; then
      OBJECTIVE_C_DYLIB="$candidate"
      break
    fi
  done
fi

export OBJC_TEST_REPO_ROOT="${OBJC_TEST_REPO_ROOT:-$ROOT}"
export DART_VM_BIN="${DART_VM_BIN:-$SDK_ROOT/bin/dartvm}"
export DART_SDK_INCLUDE="${DART_SDK_INCLUDE:-$SDK_ROOT/include}"
export DART_KERNEL_PATH="$KERNEL_PATH"
export DART_SCRIPT_URI="${DART_SCRIPT_URI:-file://$ENTRYPOINT_ABS}"
export DART_ENTRYPOINT_SYMBOL="${DART_ENTRYPOINT_SYMBOL:-main}"
export OBJC_TEST_EMBEDDED="${OBJC_TEST_EMBEDDED:-1}"
export OBJECTIVE_C_DYLIB
export FOUNDATION_BINDINGS_DYLIB
export APPKIT_BINDINGS_DYLIB
export METAL_BINDINGS_DYLIB
export METALKIT_BINDINGS_DYLIB

swift run --package-path host ObjcTestHost
