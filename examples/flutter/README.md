# Flutter ObjC Demo

Flutter demo that embeds Dart-built native host views on Darwin.

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

- `flutter build macos`
- `flutter build ios --simulator --debug --no-codesign`

## Notes

- macOS uses the stock Flutter runner setup.
- iOS uses `FlutterImplicitEngineDelegate` in
  [`ios/Runner/AppDelegate.swift`](./ios/Runner/AppDelegate.swift) so generated
  plugins are registered on the implicit engine before Dart registers the view
  factories.
