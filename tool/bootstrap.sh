#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT"

echo "==> initialize nested ffigen fork"
git submodule update --init --recursive

echo "==> dart pub get (repo root)"
dart pub get

echo "==> dart pub get (ffigen fork)"
(cd ffigen && dart pub get)

echo "==> dart pub get (objective_c package)"
(cd ffigen/pkgs/objective_c && dart pub get)

echo "==> regenerate ObjC packages"
dart run tool/gen_objc_packages.dart foundation appkit uikit metal metalkit

echo "==> flutter pub get (examples/flutter)"
(cd examples/flutter && flutter pub get)

echo "Bootstrap complete."
