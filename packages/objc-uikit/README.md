# objc_uikit

Generated Objective-C bindings for `UIKit` using the local
`ffigen` fork in `../ffigen`.
This package also bundles the Flutter platform-view transfer shim used by the
demo app:

- import `package:objc_uikit/flutter_views.dart`
- `registerObjCUiKitViewType(...)`
- `ObjCUiKitHostView`


## Regenerate

From the repository root:

```bash
dart run tool/gen_objc_packages.dart uikit
```

To regenerate all packages used by the demos:

```bash
dart run tool/gen_objc_packages.dart foundation appkit uikit metal metalkit
```
