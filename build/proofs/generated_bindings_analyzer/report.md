# Generated Bindings Analyzer Report

This report captures the analyzer and code-size experiments for the Objective-C
binding packages in this repository.

## Current checked-in binding sizes

| Package | Lines |
| --- | ---: |
| `objc_foundation` | 227,410 |
| `objc_metalkit` | 17,106 |
| `objc_metal` | 586,220 |
| `objc_appkit` | 915,665 |
| `objc_uikit` | 1,047,257 |

The biggest downstream tooling cost comes from `objc_uikit`, followed by
`objc_appkit` and `objc_metal`.

## Durable wins

### 1. Exclude generated bindings from package-local analysis

The package-local `analysis_options.yaml` files now exclude
`lib/src/*_bindings.dart`, and the root generator template preserves that on
regen.

This is the right fix for maintainers working inside these packages because it
keeps `dart analyze` focused on hand-written code instead of million-line
generated sources.

### 2. Add a `lean` generator profile

`tool/gen_objc_packages.dart` now supports:

```bash
dart run tool/gen_objc_packages.dart --profile full|lean [targets...]
```

The current `lean` policy is:

| Package | Lean policy |
| --- | --- |
| `foundation` | full surface, comments removed |
| `appkit` | full surface, comments removed |
| `uikit` | `UI*` only, non-transitive, comments removed |
| `metal` | `MTL*` only, non-transitive, comments removed |
| `metalkit` | `MTK*` only, non-transitive, comments removed |

### 3. Fix `comments: false` for Objective-C generation

The local `ffigen` fork had several Objective-C paths that still emitted
fallback symbol-name docs even when `CommentType.none()` was requested.

Those fallbacks are now removed in the local fork, so the `lean` profile can
actually strip comments instead of mostly pretending to.

### 4. Make `flutter_views.dart` independent from giant binding libraries

`packages/objc-appkit/lib/src/flutter_views.dart` and
`packages/objc-uikit/lib/src/flutter_views.dart` now accept
`objc.ObjCObject` instead of `NSView` / `UIView`.

That removes their dependency on `appkit_bindings.dart` and
`uikit_bindings.dart`, which makes helper-only imports dramatically cheaper for
the analyzer.

## Benchmarks

### Real current packages, consumer app baseline

Measured from a temporary consumer app importing the checked-in package root and
running:

```bash
/usr/bin/time -l dart analyze bin/main.dart
/usr/bin/time -l dart compile kernel bin/main.dart -o build/app.dill
```

| Package | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: |
| `foundation` | 750 ms | 176.5 MiB | 1930 ms | 333.2 MiB |
| `appkit` | 1000 ms | 311.9 MiB | 6830 ms | 807.2 MiB |
| `uikit` | 7290 ms | 1.2 GiB | 9670 ms | 929.7 MiB |
| `metal` | 2060 ms | 205.1 MiB | 5370 ms | 592.2 MiB |

### Metal variant matrix

Generated and benchmarked with `tool/prove_metal_sharing.dart`.

| Scenario | Size | Lines | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `metal_full` | 18.5 MiB | 580,745 | 1570 ms | 527.9 MiB | 4620 ms | 563.5 MiB |
| `metal_full_no_comments` | 18.2 MiB | 570,984 | 1670 ms | 562.6 MiB | 4270 ms | 596.1 MiB |
| `metal_full_no_categories` | 18.5 MiB | 580,745 | 3010 ms | 748.1 MiB | 4110 ms | 661.4 MiB |
| `metal_full_no_protocols` | 4.3 MiB | 150,810 | 1790 ms | 320.6 MiB | 1820 ms | 327.6 MiB |
| `metal_prefix_only` | 11.4 MiB | 357,070 | 2010 ms | 368.3 MiB | 2740 ms | 400.9 MiB |
| `metal_prefix_only_no_comments` | 11.3 MiB | 352,294 | 1810 ms | 359.8 MiB | 2590 ms | 422.0 MiB |

The important result is that comments are a small win, while reducing
transitive surface and especially protocol/helper generation is the real size
lever.

### UIKit variant matrix

Generated and benchmarked with `tool/prove_uikit_variants.dart`.

| Scenario | Size | Lines | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `uikit_full` | 33.7 MiB | 1,035,852 | 8820 ms | 1.2 GiB | 7710 ms | 849.5 MiB |
| `uikit_full_no_comments` | 33.2 MiB | 1,017,810 | 8560 ms | 1.1 GiB | 8030 ms | 890.4 MiB |
| `uikit_full_no_protocols` | 10.9 MiB | 374,480 | 4370 ms | 568.8 MiB | 3760 ms | 475.5 MiB |
| `uikit_prefix_only` | 25.0 MiB | 757,136 | 5670 ms | 929.8 MiB | 5290 ms | 671.7 MiB |
| `uikit_prefix_only_no_comments` | 24.6 MiB | 745,005 | 5100 ms | 914.5 MiB | 5610 ms | 674.1 MiB |

Again, comments barely matter. The meaningful wins come from reducing the
transitive Objective-C surface and avoiding protocol-heavy helper emission.

### Full vs lean profile spot checks

Generated and benchmarked with `tool/benchmark_objc_profiles.dart`.

| Framework | Full Analyze | Lean Analyze | Full Analyze RSS | Lean Analyze RSS |
| --- | ---: | ---: | ---: | ---: |
| `uikit` | 8530 ms | 5190 ms | 1.1 GiB | 881.6 MiB |
| `metal` | 580 ms | 550 ms | 150.3 MiB | 140.9 MiB |
| `metalkit` | 480 ms | 620 ms | 112.7 MiB | 135.8 MiB |
| `foundation` | 440 ms | 1910 ms | 121.8 MiB | 367.4 MiB |
| `appkit` | 1150 ms | 14550 ms | 300.1 MiB | 994.6 MiB |

The `foundation` and `appkit` lean numbers are not worth optimizing around.
Their lean mode only strips comments, so any apparent win or loss is dominated
by benchmark noise and cold-cache effects. In practice, comment stripping alone
is not a real strategy.

### Import-shape benchmark

Measured with `tool/benchmark_consumer_imports.dart` after refactoring the
Flutter helper libraries away from the giant bindings.

Representative rerun:

| Scenario | Analyze | Analyze RSS |
| --- | ---: | ---: |
| `uikit_root` | 580 ms | 265.4 MiB |
| `uikit_root_show` | 570 ms | 265.3 MiB |
| `uikit_flutter_views` | 540 ms | 151.6 MiB |
| `appkit_root` | 540 ms | 245.1 MiB |
| `appkit_root_show` | 540 ms | 244.2 MiB |
| `appkit_target_action` | 550 ms | 244.3 MiB |
| `appkit_flutter_views` | 520 ms | 154.9 MiB |

Before the helper refactor, the helper-library rows were much worse:

| Scenario | Analyze | Analyze RSS |
| --- | ---: | ---: |
| `uikit_flutter_views` | 1670 ms | 450.4 MiB |
| `appkit_flutter_views` | 1370 ms | 422.0 MiB |

Two useful conclusions:

1. `show` does not materially help when the imported symbol still lives in the
   giant binding library.
2. A genuinely separate helper library can help a lot, as long as it does not
   import the giant generated bindings.

### Library topology benchmark

Measured with `tool/benchmark_library_shapes.dart` using synthetic packages with
the same declaration count but different library layouts.

At roughly 120k generated lines:

| Shape | Files | Analyze | Analyze RSS |
| --- | ---: | ---: | ---: |
| monolith | 1 | 2400 ms | 373.1 MiB |
| exported sublibraries via root | 121 | 2040 ms | 306.0 MiB |
| direct sublibrary import | 121 | 410 ms | 101.5 MiB |
| `part` files under one root library | 121 | 2080 ms | 382.3 MiB |

At roughly 240k generated lines:

| Shape | Files | Analyze | Analyze RSS |
| --- | ---: | ---: | ---: |
| monolith | 1 | 7160 ms | 676.6 MiB |
| exported sublibraries via root | 241 | 4640 ms | 531.5 MiB |
| direct sublibrary import | 241 | 560 ms | 102.0 MiB |
| `part` files under one root library | 241 | 5510 ms | 633.9 MiB |

This is the most useful library-shape result in the whole exercise:

1. Splitting a giant API across many real libraries is materially better than a
   single monolith, even when a root library re-exports everything.
2. `part` files do not buy the same win, because they still behave like one
   giant library to the analyzer.
3. The best performance is still a direct import of the specific sublibrary.

### Library topology benchmark with cross-library references

Measured with `tool/benchmark_library_shapes_refs.dart` using synthetic
packages where each chunk heavily references types from other chunks.

At roughly 120k generated lines:

| Shape | Analyze | Analyze RSS |
| --- | ---: | ---: |
| monolith | 2450 ms | 413.7 MiB |
| exported sublibraries via root | 2500 ms | 401.9 MiB |
| direct sublibrary import | 4050 ms | 385.7 MiB |
| `part` files under one root library | 2770 ms | 417.0 MiB |

At roughly 240k generated lines:

| Shape | Analyze | Analyze RSS |
| --- | ---: | ---: |
| monolith | 5240 ms | 828.7 MiB |
| exported sublibraries via root | 4590 ms | 746.5 MiB |
| direct sublibrary import | 3930 ms | 696.2 MiB |
| `part` files under one root library | 4000 ms | 740.5 MiB |

This is the main caveat to the split-library recommendation: splitting helps
much less when the generated graph is densely interconnected. The best splits
are family or header boundaries that mostly share common base types, not lots
of peer-to-peer references.

### API density benchmark

Measured with `tool/benchmark_api_density.dart` using synthetic packages with
the same public API count but very different amounts of per-member boilerplate.

At roughly 3k classes:

| Shape | Lines | Analyze | Analyze RSS |
| --- | ---: | ---: | ---: |
| stub | 30,003 | 990 ms | 244.4 MiB |
| heavy | 174,003 | 2550 ms | 409.4 MiB |

At roughly 6k classes:

| Shape | Lines | Analyze | Analyze RSS |
| --- | ---: | ---: | ---: |
| stub | 60,003 | 1760 ms | 297.5 MiB |
| heavy | 348,003 | 5150 ms | 841.7 MiB |

This is the strongest evidence for a NativeScript-like hybrid architecture.
Even when the number of public types and methods stays constant, the analyzer
cost rises dramatically when each API member carries a large generated wrapper
body. That means a future design with slim typed stubs plus runtime metadata
and generic dispatch can plausibly preserve IDE discoverability while cutting
analyzer work a lot.

### UIKit implementation-helper stripping benchmark

Measured with `tool/benchmark_impl_helper_stripping.dart`.

This experiment copies the checked-in UIKit bindings and removes the
implementation-heavy scaffolding that exists to let Dart implement Objective-C
protocols and subclasses:

- `*Spec`
- `*Optional`
- `*Defaults`
- `*Adapter`
- `*Overrides`
- `*OverrideSelectors`
- `*SubclassBuilder`
- `*Subclass`

The important detail is that the low-level block/trampoline declarations were
left intact. Earlier attempts that stripped those as well did not compile,
which is itself evidence that the generated helper surface is tightly coupled.

Resulting size delta:

| Scenario | Size | Lines |
| --- | ---: | ---: |
| `uikit_full_copy` | 33.9 MiB | 1,047,258 |
| `uikit_no_impl_helpers` | 21.1 MiB | 711,750 |

Warm repeated consumer-app measurements:

| Scenario | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: |
| `uikit_full_copy` | 0.65-0.87 s | 196.4-200.2 MiB | 8.77-9.55 s | 964.6-983.4 MiB |
| `uikit_no_impl_helpers` | 0.58-0.85 s | 171.1-179.2 MiB | 7.51-7.57 s | 647.3-677.0 MiB |

This is a real win, but not the biggest one in the report. Removing the Dart
"implement native things from Dart" surface helps, especially for kernel
compile memory, but it does not transform analyzer behavior nearly as much as
changing library topology or moving metadata/wrapper logic out of Dart source.

### Runtime metadata shape benchmark

Measured with `tool/benchmark_runtime_metadata_shapes.dart`.

This benchmark keeps the same public classes and methods, but changes how much
dispatch logic and selector metadata live in Dart source:

- `heavyInline`: per-method selector declarations plus heavier wrapper bodies
- `thinInline`: one-line typed stubs, but still one selector declaration per
  method
- `thinTable`: one-line typed stubs, selectors compacted into a shared table
- `thinExternal`: one-line typed stubs, selector metadata represented only by
  integer slots in Dart source

At roughly 16k methods:

| Shape | Size | Lines | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `heavyInline` | 7.3 MiB | 184,005 | 2950 ms | 490.4 MiB | 2070 ms | 347.7 MiB |
| `thinInline` | 2.2 MiB | 40,005 | 1310 ms | 262.7 MiB | 890 ms | 262.8 MiB |
| `thinTable` | 1.6 MiB | 40,007 | 840 ms | 238.4 MiB | 920 ms | 214.0 MiB |
| `thinExternal` | 1.1 MiB | 24,005 | 830 ms | 218.4 MiB | 750 ms | 195.2 MiB |

At roughly 24k methods:

| Shape | Size | Lines | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `heavyInline` | 11.0 MiB | 276,005 | 3660 ms | 633.0 MiB | 2950 ms | 525.6 MiB |
| `thinInline` | 3.3 MiB | 60,005 | 2060 ms | 353.4 MiB | 1390 ms | 292.4 MiB |
| `thinTable` | 2.4 MiB | 60,007 | 2240 ms | 268.8 MiB | 1780 ms | 304.1 MiB |
| `thinExternal` | 1.7 MiB | 36,005 | 1960 ms | 251.5 MiB | 1440 ms | 286.9 MiB |

Warm repeated analyze measurements at the larger scale:

| Shape | Analyze | Analyze RSS |
| --- | ---: | ---: |
| `heavyInline` | 1.11-1.22 s | 148.6-163.3 MiB |
| `thinInline` | 0.89-1.25 s | 103.0-131.2 MiB |
| `thinTable` | 0.80-1.11 s | 86.5-95.4 MiB |
| `thinExternal` | 0.75-1.08 s | 81.1-88.8 MiB |

This is the clearest result for the long-term interop architecture:

1. Keeping typed methods for discoverability is fine.
2. The expensive part is per-method wrapper logic and per-method metadata
   declarations.
3. Compacting metadata into tables helps memory a lot.
4. Externalizing metadata from Dart source entirely helps more.

### ObjC-pattern package benchmark

Measured with `tool/benchmark_objc_pattern_shapes.dart`.

This benchmark is closer to the actual generated Objective-C shape than the
generic metadata benchmark. It compares:

- `currentAll`: one current-style library containing both normal bindings and
  implementation helpers
- `currentSplit`: the same current-style surface, but with implementation
  helpers moved into a separate opt-in `impl.dart`
- `thinRuntime`: typed APIs that dispatch through a shared runtime layer

At roughly 1,000 synthetic ObjC families:

| Scenario | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: |
| `currentAll_consumer_path` | 2130 ms | 385.5 MiB | 1750 ms | 363.4 MiB |
| `currentSplit_consumer_path` | 1150 ms | 254.8 MiB | 1100 ms | 309.1 MiB |
| `thinRuntime_consumer_path` | 820 ms | 245.8 MiB | 970 ms | 250.0 MiB |
| `currentAll_implementer_path` | 560 ms | 153.9 MiB | 1630 ms | 353.7 MiB |
| `currentSplit_implementer_path` | 1120 ms | 326.5 MiB | 1540 ms | 331.5 MiB |

Three useful conclusions came out of this:

1. Splitting implementation helpers out of the default import surface is a real
   win for consumers of the bindings.
2. That split does not automatically help the "implement a protocol in Dart"
   path; implementers really do need the helper-heavy library.
3. A thin runtime-dispatch shape is still the best consumer result, which
   matches the generic metadata benchmark.

The same script also compared delivery mode for the exact same generated
package:

| Scenario | Cold Analyze | Cold Analyze RSS |
| --- | ---: | ---: |
| `currentAll_consumer_path` | 2130 ms | 385.5 MiB |
| `currentAll_consumer_git` | 1800 ms | 402.2 MiB |
| `currentSplit_consumer_path` | 1150 ms | 254.8 MiB |
| `currentSplit_consumer_git` | 960 ms | 300.1 MiB |
| `thinRuntime_consumer_path` | 820 ms | 245.8 MiB |
| `thinRuntime_consumer_git` | 800 ms | 222.5 MiB |

Warm repeated consumer-app runs were much more stable:

| Scenario | Analyze | Analyze RSS |
| --- | ---: | ---: |
| `currentAll_consumer_path` | 0.32-0.56 s | 123.2-123.9 MiB |
| `currentAll_consumer_git` | 0.34-0.35 s | 123.2-123.5 MiB |
| `currentSplit_consumer_path` | 0.31-0.32 s | 110.0-112.0 MiB |
| `currentSplit_consumer_git` | 0.30-0.33 s | 109.7-110.9 MiB |
| `thinRuntime_consumer_path` | 0.28-0.36 s | 94.8-95.1 MiB |
| `thinRuntime_consumer_git` | 0.29-0.42 s | 94.8-95.1 MiB |

That means packaging the bindings as an external dependency is still fine, but
it is not an analyzer escape hatch. Code shape matters much more than `path:`
versus cached `git:` delivery.

### Real `msgSend` wrapper-sharing benchmark

Measured with `tool/benchmark_real_objc_msgsend_sharing.dart`.

This isolates one near-term generator optimization: keep the current typed API
shape, but stop emitting a fresh
`objc.msgSendPointer.cast(...).asFunction(...)` binding for every repeated
signature site.

The actual checked-in bindings have a lot of duplication in this layer:

| Package | Total wrappers | Unique typed signatures | Duplicate fraction | Wrapper block size |
| --- | ---: | ---: | ---: | ---: |
| `objc_metal` | 968 | 600 | 38.0% | 0.91 MiB / 29,899 lines |
| `objc_uikit` | 1,740 | 941 | 45.9% | 1.75 MiB / 56,388 lines |

Representative repeated signatures from the real output include:

- `Long Function(id, SEL) -> int`
- `Void Function(id, SEL, Long) -> void`
- `UnsignedLong Function(id, SEL) -> int`

At roughly 1,000 synthetic ObjC families:

| Shape | Size | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: | ---: |
| `duplicatedWrappers` | 3.4 MiB | 610 ms | 139.4 MiB | 3980 ms | 322.4 MiB |
| `sharedWrappers` | 1.6 MiB | 590 ms | 125.0 MiB | 1790 ms | 320.4 MiB |
| `sharedWrappersTable` | 1.2 MiB | 470 ms | 101.7 MiB | 1650 ms | 242.7 MiB |

Warm repeated analyze runs:

| Shape | Analyze | Analyze RSS |
| --- | ---: | ---: |
| `duplicatedWrappers` | 0.44-0.48 s | 128.6-146.3 MiB |
| `sharedWrappers` | 0.43-0.50 s | 115.0-131.3 MiB |
| `sharedWrappersTable` | 0.39-0.47 s | 106.7-107.3 MiB |

This is the best low-risk generator optimization in the whole report:

1. Sharing `msgSend` wrappers by signature materially shrinks generated code.
2. It improves analyzer and kernel behavior without changing the external typed
   API model.
3. Pairing shared wrappers with a compact selector table compounds the win.

### Actual generated-wrapper dedup benchmark

Measured with `tool/benchmark_generated_wrapper_dedup.dart`.

Unlike the synthetic wrapper-sharing benchmark, this one copies the real
checked-in `objc_uikit` and `objc_metal` packages, rewrites duplicate
`final _objc_msgSend_* = objc.msgSendPointer.cast(...).asFunction(...)`
declarations to share one definition per identical emitted wrapper body, and
benchmarks the copied packages without changing their public API surface.

Real duplicate counts in the checked-in generated files:

| Package | Wrapper defs | Unique emitted wrappers | Duplicate defs |
| --- | ---: | ---: | ---: |
| `objc_uikit` | 1,740 | 941 | 799 |
| `objc_metal` | 968 | 600 | 368 |

Representative cold run:

| Framework | Shape | Size | Lines | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `uikit` | `original` | 33.9 MiB | 1,047,258 | 1020 ms | 200.2 MiB | 9800 ms | 1005.7 MiB |
| `uikit` | `deduped` | 33.6 MiB | 1,033,953 | 1420 ms | 181.6 MiB | 10740 ms | 933.0 MiB |
| `metal` | `original` | 18.6 MiB | 586,221 | 1440 ms | 250.5 MiB | 13940 ms | 633.6 MiB |
| `metal` | `deduped` | 18.4 MiB | 580,053 | 6010 ms | 755.8 MiB | 5640 ms | 656.1 MiB |

Those cold numbers were noisy, so warm repeated runs matter more here.

Warm repeated analyze runs:

| Framework | Shape | Analyze | Analyze RSS |
| --- | --- | ---: | ---: |
| `uikit` | `original` | 0.68-0.90 s | 197.3-251.6 MiB |
| `uikit` | `deduped` | 0.74-0.76 s | 196.5-196.7 MiB |
| `metal` | `original` | 0.56-0.58 s | 151.4-154.3 MiB |
| `metal` | `deduped` | 0.58 s after warm-up, with first-run outliers | 152.8 MiB after warm-up |

Warm repeated kernel runs:

| Framework | Shape | Kernel | Kernel RSS |
| --- | --- | ---: | ---: |
| `uikit` | `original` | 10.24-11.00 s | 866.0-954.9 MiB |
| `uikit` | `deduped` | 8.98-9.38 s | 997.1-1007.1 MiB |
| `metal` | `original` | 5.53-8.66 s | 587.8-654.1 MiB |
| `metal` | `deduped` | 5.55 s | 649.0-651.1 MiB |

This refined the earlier synthetic conclusion:

1. Real wrapper dedup absolutely removes redundant source, but the total size
   win is modest because wrappers are only one slice of the full file.
2. For analyzer steady-state behavior, wrapper dedup alone looks mostly
   neutral on real packages.
3. It may still help kernel compile time in some cases, especially on UIKit,
   but not enough to outrank library topology or helper-surface isolation.
4. So wrapper dedup is still a worthwhile low-risk cleanup, just not the main
   lever for IDE responsiveness.

### Real metadata-table compaction benchmark

Measured with `tool/benchmark_generated_metadata_tables.dart`.

This experiment copies the real checked-in `objc_uikit` and `objc_metal`
packages and rewrites their generated metadata globals:

- `_sel_*` selector bindings
- `_class_*` class bindings
- `_protocol_*` protocol bindings

Instead of one lazy top-level binding per metadata entry, the rewritten files
store names in compact arrays and resolve them through shared cached lookup
helpers such as `_selectorAt(slot)`.

Real metadata counts in the checked-in generated files:

| Framework | Selectors | Classes | Protocols |
| --- | ---: | ---: | ---: |
| `uikit` | 8,771 | 813 | 278 |
| `metal` | 4,274 | 387 | 138 |

Representative isolated runs for the original shape versus compacting all three
metadata kinds:

| Framework | Shape | Size | Lines | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `uikit` | `original` | 33.9 MiB | 1,047,258 | 900 ms | 187.4 MiB | 8520 ms | 973.8 MiB |
| `uikit` | `allMetadataTables` | 33.1 MiB | 1,036,727 | 760 ms | 242.6 MiB | 8350 ms | 916.4 MiB |
| `metal` | `original` | 18.6 MiB | 586,221 | 610 ms | 151.3 MiB | 4440 ms | 600.5 MiB |
| `metal` | `allMetadataTables` | 18.2 MiB | 581,394 | 710 ms | 138.8 MiB | 4700 ms | 524.5 MiB |

The selector-only rewrite was noisier and never clearly better, so it is not
the interesting variant here.

This result is weaker than the synthetic thin-runtime benchmarks:

1. Compacting metadata globals inside the current generated architecture only
   saves a few hundred kilobytes and a few thousand lines.
2. On real packages, it can shave kernel RSS, but it does not create a clear,
   durable analyzer win by itself.
3. That means metadata-table compaction is not a standalone fix. It only looks
   worthwhile as part of a broader thin-runtime or shared-dispatch design.

### Real runtime-prototype benchmark

Measured with `tool/benchmark_real_objc_runtime_shapes.dart`.

Unlike the purely synthetic metadata benchmark, this one generates code against
the actual local `objective_c` package and uses real `objc.registerName` /
`objc.msgSendPointer` primitives.

It compares:

- `currentStyle`: current-style wrappers with one late-final selector binding
  per member and direct per-method `msgSend` calls
- `thinTable`: shared typed dispatch helpers plus a compact shared selector
  table in Dart source
- `thinExternal`: the same shared dispatch shape, but selector names moved to a
  sidecar text file

At roughly 1,000 synthetic ObjC families:

| Shape | Size | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: | ---: |
| `currentStyle` | 1.7 MiB Dart | 550 ms | 126.4 MiB | 3180 ms | 257.8 MiB |
| `thinTable` | 1.1 MiB Dart | 510 ms | 121.0 MiB | 2680 ms | 286.7 MiB |
| `thinExternal` | 0.9 MiB Dart + 0.1 MiB sidecar | 970 ms | 121.2 MiB | 3260 ms | 290.4 MiB |

Warm repeated analyze runs:

| Shape | Analyze | Analyze RSS |
| --- | ---: | ---: |
| `currentStyle` | 0.50-0.91 s | 126.0-132.3 MiB |
| `thinTable` | 0.46-0.55 s | 107.3-127.0 MiB |
| `thinExternal` | 0.60-0.68 s | 127.0-128.0 MiB |

This is important because it is the closest benchmark to a real migration path:

1. A thin runtime layer on top of the existing `objective_c` runtime is
   feasible.
2. Moving to shared dispatch helpers and a compact selector table is already a
   win.
3. Moving selector names fully out of Dart source did not beat the compact
   table in this prototype, because the extra loader path offset the source-size
   savings.

### Member-topology benchmark

Measured with `tool/benchmark_member_topology.dart`.

This benchmark keeps the same synthetic families and methods, but changes how
those methods are attached to the type:

- `inlineMembers`: every method lives directly on the extension type
- `sameLibraryExtensions`: methods move to extensions, but stay in one library
- `splitExtensionsRoot`: methods are grouped into real sublibraries and
  re-exported by one umbrella root
- `splitExtensionsDirect`: the consumer imports only one method-group library

At roughly 1,500 families with 24 methods each:

| Shape | Files | Size | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `inlineMembers` | 1 | 7.4 MiB | 2670 ms | 391.7 MiB | 2890 ms | 452.0 MiB |
| `sameLibraryExtensions` | 1 | 7.8 MiB | 3450 ms | 438.8 MiB | 3290 ms | 450.9 MiB |
| `splitExtensionsRoot` | 14 | 7.8 MiB | 2980 ms | 278.8 MiB | 3900 ms | 433.1 MiB |
| `splitExtensionsDirect` | 14 | 7.8 MiB | 2040 ms | 158.0 MiB | 1620 ms | 190.1 MiB |

At roughly 3,000 families with 24 methods each:

| Shape | Files | Size | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `inlineMembers` | 1 | 14.8 MiB | 8340 ms | 679.5 MiB | 8310 ms | 751.8 MiB |
| `sameLibraryExtensions` | 1 | 15.7 MiB | 11710 ms | 616.5 MiB | 11270 ms | 787.0 MiB |
| `splitExtensionsRoot` | 14 | 15.7 MiB | 5490 ms | 404.4 MiB | 5780 ms | 776.3 MiB |
| `splitExtensionsDirect` | 14 | 15.7 MiB | 1220 ms | 245.5 MiB | 1360 ms | 297.0 MiB |

Warm repeated analyze runs on the 1,500-family harnesses were also useful:

| Shape | Analyze | Analyze RSS |
| --- | ---: | ---: |
| `inlineMembers` | 0.51-0.51 s | 100.5-104.4 MiB |
| `sameLibraryExtensions` | 0.53-0.58 s | 109.0 MiB |
| `splitExtensionsRoot` | 1.09-1.15 s | 107.3-110.2 MiB |
| `splitExtensionsDirect` | 0.49-0.54 s | 83.5-83.6 MiB |

This gives a much more precise answer to the "scope below framework level"
question:

1. Moving methods into extensions does not help by itself. If they stay in the
   same library, it is usually slightly worse than keeping them inline.
2. Grouping methods into real sublibraries can materially reduce analyzer cost
   at larger scales, even when an umbrella root still re-exports everything.
3. Direct method-group imports are still dramatically better than the umbrella
   root.
4. A plausible full-SDK layout is therefore: core ObjC types in one layer,
   header/family/category methods in many generated extension libraries, and a
   convenience umbrella export on top.

### LSP completion and auto-import benchmark

Measured with `tool/benchmark_lsp_completion.dart` on the kept 1,500-family
member-topology harnesses.

The first version of this benchmark was inconclusive because the tiny LSP
client was too naive. It now:

- waits for analyzer status notifications,
- answers server-side `workspace/configuration` requests,
- resolves completion items to inspect auto-import edits,
- and can force split layouts down to `src/core.dart` imports to simulate a
  "core types only" user import.

With the default imports for each shape:

| Shape | First completion | Second completion | Suggestions | `method0` | Auto-import edit |
| --- | ---: | ---: | ---: | --- | --- |
| `inlineMembers` | 125 ms | 8 ms | 24 | yes | no |
| `sameLibraryExtensions` | 1169 ms | 9 ms | 24 | yes | no |
| `splitExtensionsDirect` | 104 ms | 126 ms | 24 | yes | no |
| `splitExtensionsRoot` | 206 ms | 23 ms | 24 | yes | no |

With the split layouts forced to import only `src/core.dart`:

| Shape | First completion | Second completion | Suggestions | `method0` | Auto-import edit |
| --- | ---: | ---: | ---: | --- | --- |
| `splitExtensionsDirect` | 104 ms | 132 ms | 24 | yes | yes |
| `splitExtensionsRoot` | 104 ms | 138 ms | 24 | yes | yes |

This is the strongest DX result in the whole exercise:

1. Split extension libraries do not have to destroy discoverability.
2. A "core types only" import can still surface member completions from
   unimported extension libraries.
3. The resolved completion items can carry auto-import edits, which means the
   IDE can guide users into the narrow library shape without forcing them to
   know the right import upfront.
4. That makes "core + many generated extension libraries + umbrella export" a
   much more viable NativeScript-like experience in Dart than the earlier
   analyzer-only numbers suggested.

### Package-topology benchmark

Measured with `tool/benchmark_package_topology.dart`.

This benchmark keeps the same "core types plus grouped method libraries"
approach, but moves the grouping boundary between libraries and packages:

- `monolith`: one package, one library, all methods inline
- `samePackageRoot`: one package with grouped sublibraries and an umbrella root
- `multiPackageRoot`: one umbrella package re-exporting a core package plus
  grouped method packages
- `multiPackageDirect`: one grouped method package imported directly

At roughly 1,500 families with 24 methods each:

| Shape | Packages | Files | Size | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| `monolith` | 1 | 1 | 7.4 MiB | 1940-2210 ms | 369.9-373.7 MiB | 3000-3280 ms | 459.7-491.2 MiB |
| `samePackageRoot` | 1 | 14 | 7.8 MiB | 2090-4440 ms | 242.4-313.5 MiB | 2840-3260 ms | 421.7-447.3 MiB |
| `multiPackageRoot` | 8 | 14 | 7.8 MiB | 2540-2670 ms | 239.6-283.7 MiB | 3090-3200 ms | 428.5-433.9 MiB |
| `multiPackageDirect` | 8 | 14 | 7.8 MiB | 780-810 ms | 167.7-169.3 MiB | 960-1010 ms | 188.9-189.2 MiB |

At roughly 3,000 families with 24 methods each:

| Shape | Packages | Files | Size | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| `monolith` | 1 | 1 | 14.8 MiB | 4460 ms | 665.8 MiB | 7550 ms | 759.1 MiB |
| `samePackageRoot` | 1 | 14 | 15.7 MiB | 6990 ms | 401.8 MiB | 15110 ms | 684.1 MiB |
| `multiPackageRoot` | 8 | 14 | 15.7 MiB | 8790 ms | 428.4 MiB | 19780 ms | 665.9 MiB |
| `multiPackageDirect` | 8 | 14 | 15.7 MiB | 1800 ms | 234.6 MiB | 3940 ms | 272.8 MiB |

Warm repeated analyze runs on the 1,500-family kept harnesses:

| Shape | Analyze | Analyze RSS |
| --- | ---: | ---: |
| `monolith` | 0.39-0.60 s | 100.3-103.8 MiB |
| `samePackageRoot` | 0.51-0.82 s | 111.4-206.6 MiB |
| `multiPackageRoot` | 0.47-0.61 s | 107.3-111.8 MiB |
| `multiPackageDirect` | 0.35-0.46 s | 83.5-83.7 MiB |

This ruled out a tempting alternative architecture:

1. Package boundaries do not rescue the full umbrella-import case.
2. A multi-package umbrella can be slightly better on RSS in some mid-scale
   runs, but it is not a reliable latency win and often loses at larger scales.
3. Real library boundaries inside one package are at least as good as package
   boundaries for the umbrella-import path, and simpler to ship.
4. Narrow direct imports still dominate everything else.

### Real split-framework proof: Metal family package

Measured with `tool/prove_split_metal_family.dart`.

This proof generated a real split package for a Metal archive family:

- `archive_base_bindings.dart`
- `archive_bindings.dart`
- a separate `MTL4Command*` chunk for umbrella-root pressure

It also generated a same-scope monolithic package for comparison.

Representative output sizes:

| Package shape | Lines | Size |
| --- | ---: | ---: |
| monolith family slice | 29,657 | 1.0 MiB |
| split base chunk | 9,963 | 0.3 MiB |
| split archive chunk | 3,242 | 0.1 MiB |
| split command chunk | 17,607 | 0.6 MiB |
| split total | 30,812 | 1.0 MiB |

Representative benchmark run:

| Scenario | Analyze | Analyze RSS | Kernel | Kernel RSS |
| --- | ---: | ---: | ---: | ---: |
| current full `objc_metal` import | 550 ms | 152.1 MiB | 3970 ms | 592.0 MiB |
| family monolith import | 490 ms | 149.5 MiB | 860 ms | 191.8 MiB |
| split umbrella import | 440 ms | 137.2 MiB | 890 ms | 206.2 MiB |
| split direct family import | 440 ms | 93.9 MiB | 740 ms | 207.7 MiB |

Repeated runs moved around, but the stable conclusions were:

1. Importing a narrow pre-generated family is much cheaper than importing the
   full Metal package.
2. On this real slice, direct-family imports are usually cheaper than the
   umbrella import, but the gap is much smaller than in the synthetic topology
   benchmark because this family is still fairly interconnected.
3. Splitting the family into real libraries does work for this protocol-heavy
   Metal slice.

There is also an important limitation:

- The split archive chunk still re-emitted some imported ObjC symbols. The
  duplicate export set was: `MTL4BinaryFunction`, `MTLAllocation`,
  `MTLComputePipelineState`, `MTLRenderPipelineState`,
  `ObjCBlock_NSString_ffiVoid`, and
  `ObjCBlock_NSString_ffiVoid$CallExtension`.

That means current ObjC symbol-file sharing is only partially effective. It is
usable for some split-package layouts, but not clean enough yet to assume that
every family can be split without extra export-hiding or generator work.

## What did not pan out

### Comment stripping as the main strategy

Not worth it. Even after fixing the ObjC comment suppression bug, the size delta
is only a few percent and the analyzer improvements are minor or lost in noise.

### AppKit / Foundation lean mode as currently defined

Not worth it. Without a better way to split `NS*` APIs from shared Foundation
types, comment stripping alone is not a serious optimization.

### Shared symbol files across Objective-C framework packages

`ffigen` supports symbol-file sharing in general, and the Metal split-family
proof shows that it can help with some protocol-heavy slices. But the current
ObjC path still cannot cleanly dedupe all imported interfaces, protocols, block
helpers, and inheritance relationships:

1. Some imported ObjC symbols are still re-emitted in downstream chunks.
2. Interface inheritance still depends on full `ObjCInterface` nodes in places
   where imported symbols arrive as generic imported types.
3. The result is that symbol files are promising for framework-family splits,
   but not yet a clean foundation for a universal `foundation`-as-base-package
   or whole-SDK fanout strategy.

### Regex-level post-processing of generated helpers

Only partially useful.

The UIKit helper-stripping proof did eventually produce a valid reduced variant,
but only after treating protocol and subclass helper groups as generator units.
Naive text deletion of trampolines, block helpers, or single helper classes
breaks the generated graph quickly.

That means any serious "generate full SDK, but move implementation helpers out"
strategy should happen in the generator, not as a post-process.

### Relying on one umbrella import for the entire SDK

You can keep an umbrella import for convenience, but the topology benchmark
shows that a root import of the whole world will still be meaningfully more
expensive than importing a specific sublibrary. If full discoverability is the
goal, the better compromise is a pre-generated package with:

1. many real generated sublibraries,
2. an umbrella library that re-exports them for convenience,
3. IDE auto-import flowing users toward the narrow library when possible.

That preserves discoverability better than asking users to hand-curate symbols,
without forcing the analyzer through one monolithic library.

### Treating published or cached delivery as the main performance fix

Not worth betting on.

The ObjC-pattern benchmark showed that `git:` delivery of the same generated
package can look slightly better or worse on cold runs, but warm repeated runs
were essentially identical to `path:` delivery. Shipping pre-generated
packages is still useful for DX and release engineering, but it does not
meaningfully change the analyzer's steady-state cost.

### Treating package boundaries as the main performance fix

Not worth betting on.

The package-topology benchmark showed that an umbrella package re-exporting
many grouped child packages does not materially outperform grouped sublibraries
inside one package for the full-import case. Package boundaries may help a bit
with some memory profiles, but they are not the primary lever.

### Compacting current metadata globals as a standalone fix

Not worth betting on.

The real metadata-table benchmark did reduce source size a little and improved
some kernel-memory numbers, but it did not produce a decisive analyzer win on
the actual `uikit` and `metal` packages. If metadata compaction happens, it
should happen alongside a broader shift toward shared dispatch helpers or
thinner generated stubs, not as an isolated post-process.

## Workspace note

For repository maintainers, pub workspaces are also relevant. The Dart docs note
that opening a multi-package repo without workspaces creates separate analysis
contexts and increases memory usage, and that workspaces reduce analysis memory
for large repositories. That helps repo-local analysis, but it does not remove
the downstream cost of importing giant generated libraries from a consumer app.

## Recommended next direction

1. Keep the package-local analyzer excludes.
2. Use `--profile lean` for the biggest frameworks when tooling cost matters
   more than exhaustive API coverage.
3. Prefer many real generated sublibraries over one monolith, and do not expect
   `part` files to save you.
4. Start that split strategy with protocol-heavy or loosely-coupled families
   first, where current ObjC symbol-file sharing is most viable. Metal is the
   best immediate candidate.
5. Keep an umbrella export library for convenience, but bias IDE auto-import and
   docs toward narrower generated libraries. The LSP completion benchmark shows
   that this can still be discoverable if member completions resolve to
   auto-import edits from the split extension libraries.
6. Prefer separate companion libraries for helper APIs, and keep those helper
   libraries free of imports from giant generated bindings whenever possible.
7. Treat a hybrid NativeScript-like design as the serious long-term bet:
   generate slim typed stubs for discoverability, move dispatch details into
   shared runtime helpers plus generic Objective-C message sending, and keep
   selector/class metadata compact when it is part of that broader runtime
   shape. In the current prototypes, a compact shared table performed better
   than a fully external sidecar, but compacting metadata alone was not enough
   to move the real-package analyzer numbers much.
8. If full-SDK discoverability in the IDE becomes the top priority, consider a
   custom analyzer plugin fed from external SDK metadata. Dart 3.10+ supports
   analyzer plugins, so a plugin-backed completion or diagnostic layer is now a
   real option rather than a purely hypothetical one.
