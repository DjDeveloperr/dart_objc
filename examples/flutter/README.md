# Flutter ObjC Demo

Flutter demo that embeds Dart-built native host views on Darwin.

The macOS app demonstrates three incremental adoption patterns:

- an `NSView` hierarchy created in Dart and mounted in Flutter;
- a real `NSTextView`/`NSScrollView` editor where AppKit owns editing and
  selection while a typed delegate updates Flutter state;
- a typed `NSOpenPanel` completion block that returns a selected native
  `NSURL` without an app-specific platform channel.

The iOS app embeds a Dart-created UIKit tab shell. The repository root also
contains a fully native AppKit/Metal app driven by an embedded Dart VM.

## Prerequisites

From the repo root, run:

```bash
./tool/bootstrap.sh
```

## Run

macOS:

```bash
flutter run -d macos
```

iOS simulator:

```bash
sh tool/run_ios_simulator.sh
```

## Verify

From the repo root:

```bash
./tool/verify.sh
```

The Flutter-specific verification that matters here is:

- `flutter analyze lib`
- `flutter test`
- `flutter build macos`
- `flutter build ios --simulator --debug --no-codesign`

## Notes

- macOS uses the stock Flutter runner setup.
- Flutter integration is optional: the base `objc_appkit` and `objc_uikit`
  packages do not depend on Flutter. This demo opts into
  `objc_appkit_flutter` and `objc_uikit_flutter`.
- iOS uses `FlutterImplicitEngineDelegate` in
  [`ios/Runner/AppDelegate.swift`](./ios/Runner/AppDelegate.swift) so generated
  plugins are registered on the implicit engine before Dart registers the view
  factories.
