# objc_uikit

Generated Objective-C bindings for `UIKit` using the local
`ffigen` fork in `../ffigen`.

This package has no Flutter dependency. Flutter platform-view integration is
available separately from `package:objc_uikit_flutter`.

## Regenerate

From the repository root:

```bash
dart run tool/gen_objc_packages.dart uikit
```

To regenerate all packages used by the demos:

```bash
dart run tool/gen_objc_packages.dart foundation appkit uikit metal metalkit
```
