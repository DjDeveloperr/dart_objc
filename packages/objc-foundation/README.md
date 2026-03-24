# objc_foundation

Generated Objective-C bindings for `Foundation` using the local
`ffigen` fork in `../ffigen`.

## Regenerate

From the repository root:

```bash
dart run tool/gen_objc_packages.dart foundation
```

To regenerate all packages used by the demos:

```bash
dart run tool/gen_objc_packages.dart foundation appkit uikit metal metalkit
```
