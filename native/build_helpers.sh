#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT"

mkdir -p native/build
rm -f native/build/objc_foundation_bindings.dylib native/build/objc_appkit_bindings.dylib

clang -dynamiclib -fobjc-arc \
  -o native/build/objc_foundation_bindings.dylib \
  packages/objc-foundation/native/foundation_bindings.m \
  -framework Foundation

clang -dynamiclib -fobjc-arc \
  -o native/build/objc_appkit_bindings.dylib \
  packages/objc-appkit/native/appkit_bindings.m \
  -framework Foundation \
  -framework AppKit

echo "Built:"
echo "  native/build/objc_foundation_bindings.dylib"
echo "  native/build/objc_appkit_bindings.dylib"
