# objc_appkit

Generated Objective-C bindings for `AppKit` using the local
`ffigen` fork in `../ffigen`.
This package also bundles the Flutter platform-view transfer shim used by the
demo app:

- import `package:objc_appkit/flutter_views.dart`
- `registerObjCAppKitViewType(...)`
- `ObjCAppKitHostView`


## Regenerate

From the repository root:

```bash
dart run tool/gen_objc_packages.dart appkit
```

To regenerate all packages used by the demos:

```bash
dart run tool/gen_objc_packages.dart foundation appkit uikit metal metalkit
```
