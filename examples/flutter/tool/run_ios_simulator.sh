#!/bin/sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
APP_PATH="$ROOT_DIR/build/ios/iphonesimulator/Runner.app"
BUNDLE_ID="com.example.objCFlutterApp"

BOOTED_DEVICE_ID=$(
  xcrun simctl list devices booted -j |
    jq -r '
      .devices
      | to_entries[]
      | .value[]
      | select(.state == "Booted")
      | .udid
    ' |
    head -n 1
)

if [ -z "$BOOTED_DEVICE_ID" ]; then
  echo "No booted iOS simulator found. Boot one first with Simulator.app or simctl."
  exit 1
fi

cd "$ROOT_DIR"
flutter build ios --simulator
xcrun simctl install "$BOOTED_DEVICE_ID" "$APP_PATH"
xcrun simctl launch "$BOOTED_DEVICE_ID" "$BUNDLE_ID"
