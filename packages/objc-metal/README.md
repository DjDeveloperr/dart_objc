# objc_metal

Split-family Objective-C bindings for `Metal` using the local
`ffigen` fork in `../ffigen`.

## Regenerate

From the repository root:

```bash
dart tool/gen_objc_packages.dart metal
```

To generate the smaller tooling-focused profile instead:

```bash
dart tool/gen_objc_packages.dart --profile lean metal
```

To regenerate the package with an umbrella root surface:

```bash
dart tool/gen_objc_packages.dart --root-surface umbrella metal
```

This package also emits:

- `all.dart` for the full umbrella export
- `core.dart` as the cheap default root surface
 

To regenerate all packages used by the demos:

```bash
dart tool/gen_objc_packages.dart foundation appkit uikit metal metalkit
```
