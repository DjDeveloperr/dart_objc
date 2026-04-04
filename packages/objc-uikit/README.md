# objc_uikit

Split-family Objective-C bindings for `UIKit` using the local
`ffigen` fork in `../ffigen`.
This package also bundles the Flutter platform-view transfer shim used by the
demo app:

- import `package:objc_uikit/flutter_views.dart`
- `registerObjCUiKitViewType(...)`
- `ObjCUiKitHostView`


## Regenerate

From the repository root:

```bash
dart tool/gen_objc_packages.dart uikit
```

To generate the smaller tooling-focused profile instead:

```bash
dart tool/gen_objc_packages.dart --profile lean uikit
```

To regenerate the package with an umbrella root surface:

```bash
dart tool/gen_objc_packages.dart --root-surface umbrella uikit
```

This package also emits:

- `all.dart` for the full umbrella export
- `core.dart` as the cheap default root surface
 

To regenerate all packages used by the demos:

```bash
dart tool/gen_objc_packages.dart foundation appkit uikit metal metalkit
```
