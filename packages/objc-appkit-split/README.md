# objc_appkit_split

Split-family Objective-C bindings for `AppKit` using the local
`ffigen` fork in `../ffigen`.

## Regenerate

From the repository root:

```bash
dart tool/gen_objc_packages.dart --layout split appkit
```

To generate the smaller tooling-focused profile instead:

```bash
dart tool/gen_objc_packages.dart --profile lean appkit
```

To regenerate the split package with a core-only root surface:

```bash
dart tool/gen_objc_packages.dart --layout split --split-root core-only appkit
```

This split package also emits:

- `all.dart` for the full umbrella export
- `core.dart` as the cheap default root surface
 

To regenerate all packages used by the demos:

```bash
dart tool/gen_objc_packages.dart foundation appkit uikit metal metalkit
```
