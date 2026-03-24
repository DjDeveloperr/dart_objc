# objc_metalkit

Generated Objective-C bindings for `MetalKit` using the local
`ffigen` fork in `../ffigen`.

## Regenerate

From the repository root:

```bash
dart run tool/gen_objc_packages.dart metalkit
```

To regenerate all packages used by the demos:

```bash
dart run tool/gen_objc_packages.dart foundation appkit uikit metal metalkit
```
