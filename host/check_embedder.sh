#!/usr/bin/env bash
set -euo pipefail

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

INCLUDE_PATH="$SDK_ROOT/include/dart_api.h"
DARTVM_PATH="$SDK_ROOT/bin/dartvm"

echo "Checking Dart embedder prerequisites under: $SDK_ROOT"

if [[ ! -f "$INCLUDE_PATH" ]]; then
  echo "Missing header: $INCLUDE_PATH"
  exit 2
fi

echo "Found header: $INCLUDE_PATH"

if [[ ! -x "$DARTVM_PATH" ]]; then
  echo "Missing executable dartvm: $DARTVM_PATH"
  exit 2
fi

echo "Found runtime: $DARTVM_PATH"

if nm "$DARTVM_PATH" 2>/dev/null | grep "_Dart_Initialize" >/dev/null; then
  echo "Found Dart embedder symbols in dartvm (dlopen-compatible)."
  echo "Result: in-process embedding prerequisites look good."
  exit 0
fi

echo "dartvm does not expose expected Dart_* symbols."
echo "In-process embedding via dlopen(dartvm) is blocked for this SDK build."
exit 2
