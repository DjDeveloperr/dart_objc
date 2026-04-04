# objc_appkit

Split-family Objective-C bindings for `AppKit` using the local
`ffigen` fork in `../ffigen`.
This package also bundles the Flutter platform-view transfer shim used by the
demo app:

- import `package:objc_appkit/flutter_views.dart`
- `registerObjCAppKitViewType(...)`
- `ObjCAppKitHostView`


## Regenerate

From the repository root:

```bash
dart tool/gen_objc_packages.dart appkit
```

To generate the smaller tooling-focused profile instead:

```bash
dart tool/gen_objc_packages.dart --profile lean appkit
```

To regenerate the package with an umbrella root surface:

```bash
dart tool/gen_objc_packages.dart --root-surface umbrella appkit
```

This package also emits:

- `all.dart` for the full umbrella export
- `core.dart` as the cheap default root surface
 

To regenerate all packages used by the demos:

```bash
dart tool/gen_objc_packages.dart foundation appkit uikit metal metalkit
```
