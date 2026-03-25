import 'dart:io';

import 'package:flutter/material.dart';
import 'package:objective_c/objective_c.dart';
import 'package:objc_uikit/objc_uikit.dart';
import 'package:objc_uikit/flutter_views.dart';

const objcUiKitTabBarViewType = 'objc-uikit-tab-bar';
const _kTabBarHeight = 49.0;
const _kContentHorizontalPadding = 24.0;
const _kContentTopPadding = 28.0;
const _kContentBottomPadding = 24.0;
const _kDemoSurfaceColor = Color(0xFFF6F2EB);

class ObjcUiKitTabShell extends StatefulWidget {
  const ObjcUiKitTabShell({super.key});

  @override
  State<ObjcUiKitTabShell> createState() => _ObjcUiKitTabShellState();
}

class _ObjcUiKitTabShellState extends State<ObjcUiKitTabShell> {
  final _pageStorageBucket = PageStorageBucket();
  ObjcUiKitTab _selectedTab = ObjcUiKitTab.overview;
  int _tabSwitchCount = 0;
  int _flutterCounter = 0;

  void _handleTabSelected(ObjcUiKitTab tab) {
    if (_selectedTab == tab) {
      return;
    }
    setState(() {
      _selectedTab = tab;
      _tabSwitchCount += 1;
    });
  }

  void _incrementFlutterCounter() {
    setState(() {
      _flutterCounter += 1;
    });
  }

  void _resetState() {
    setState(() {
      _tabSwitchCount = 0;
      _flutterCounter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final tabBarHeight = _kTabBarHeight + bottomInset;
    return Scaffold(
      backgroundColor: _kDemoSurfaceColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: PageStorage(
                bucket: _pageStorageBucket,
                child: _FlutterTabContent(
                  tab: _selectedTab,
                  tabSwitchCount: _tabSwitchCount,
                  flutterCounter: _flutterCounter,
                  bottomInset: tabBarHeight,
                  onIncrementFlutterCounter: _incrementFlutterCounter,
                  onResetState: _resetState,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: tabBarHeight,
                child: ObjcUiKitTabBarSurface(
                  bottomInset: bottomInset,
                  onTabSelected: _handleTabSelected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlutterTabContent extends StatelessWidget {
  const _FlutterTabContent({
    required this.tab,
    required this.tabSwitchCount,
    required this.flutterCounter,
    required this.bottomInset,
    required this.onIncrementFlutterCounter,
    required this.onResetState,
  });

  final ObjcUiKitTab tab;
  final int tabSwitchCount;
  final int flutterCounter;
  final double bottomInset;
  final VoidCallback onIncrementFlutterCounter;
  final VoidCallback onResetState;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: tab.index,
      children: [
        _OverviewTab(tabSwitchCount: tabSwitchCount, bottomInset: bottomInset),
        _ActivityTab(
          flutterCounter: flutterCounter,
          tabSwitchCount: tabSwitchCount,
          bottomInset: bottomInset,
          onIncrementFlutterCounter: onIncrementFlutterCounter,
        ),
        _BridgeTab(
          tabSwitchCount: tabSwitchCount,
          flutterCounter: flutterCounter,
          bottomInset: bottomInset,
          onResetState: onResetState,
        ),
      ],
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.tabSwitchCount, required this.bottomInset});

  final int tabSwitchCount;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _TabPage(
      storageId: 'overview',
      bottomInset: bottomInset,
      children: [
        Text(
          'UIKit Tabs, Flutter Content',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'The tab bar below is a native UIKit view built in Dart with '
          'objc_uikit. Selecting a tab calls back into Dart, and the body '
          'above swaps between ordinary Flutter widgets.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        _InfoCard(
          title: 'Why this matters',
          body:
              'This is the hybrid shell shape Flutter engineering cares about: '
              'native host navigation embedded in Flutter, while the screen '
              'content remains Flutter-driven on the same engine.',
        ),
        const SizedBox(height: 16),
        _MetricStrip(
          leadingLabel: 'Platform',
          leadingValue: Platform.operatingSystem,
          trailingLabel: 'Tab switches',
          trailingValue: '$tabSwitchCount',
        ),
        const SizedBox(height: 20),
        ...List.generate(
          8,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _InfoCard(
              title: 'Overview Note ${index + 1}',
              body:
                  'This is filler content to make the Overview tab long enough '
                  'to scroll beneath the native tab bar. It helps verify the '
                  'underlap behavior and makes the hybrid shell easier to demo.',
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivityTab extends StatelessWidget {
  const _ActivityTab({
    required this.flutterCounter,
    required this.tabSwitchCount,
    required this.bottomInset,
    required this.onIncrementFlutterCounter,
  });

  final int flutterCounter;
  final int tabSwitchCount;
  final double bottomInset;
  final VoidCallback onIncrementFlutterCounter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _TabPage(
      storageId: 'activity',
      bottomInset: bottomInset,
      children: [
        Text(
          'Pure Flutter Body',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Nothing in this panel is UIKit. The native tab bar only updates '
          'Flutter state.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        _MetricStrip(
          leadingLabel: 'Flutter counter',
          leadingValue: '$flutterCounter',
          trailingLabel: 'Tab switches',
          trailingValue: '$tabSwitchCount',
        ),
        const SizedBox(height: 20),
        FilledButton.tonal(
          onPressed: onIncrementFlutterCounter,
          child: const Text('Increment Flutter Counter'),
        ),
        const SizedBox(height: 20),
        ...List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _InfoCard(
              title: 'Activity Sample ${index + 1}',
              body:
                  'Extra Flutter-only content to make the Activity tab tall '
                  'enough to visibly scroll behind the native UITabBar.',
            ),
          ),
        ),
      ],
    );
  }
}

class _BridgeTab extends StatelessWidget {
  const _BridgeTab({
    required this.tabSwitchCount,
    required this.flutterCounter,
    required this.bottomInset,
    required this.onResetState,
  });

  final int tabSwitchCount;
  final int flutterCounter;
  final double bottomInset;
  final VoidCallback onResetState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _TabPage(
      storageId: 'bridge',
      bottomInset: bottomInset,
      children: [
        Text(
          'Bridge Topology',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        const _TopologyRow(label: 'Flutter', detail: 'Builds the screen body'),
        const _TopologyRow(
          label: 'UIKit',
          detail: 'Hosts the embedded UITabBar platform view',
        ),
        const _TopologyRow(
          label: 'Dart callbacks',
          detail: 'Receive native tab selections and update Flutter state',
        ),
        const SizedBox(height: 20),
        _MetricStrip(
          leadingLabel: 'Tab switches',
          leadingValue: '$tabSwitchCount',
          trailingLabel: 'Counter',
          trailingValue: '$flutterCounter',
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: onResetState,
          child: const Text('Reset Demo State'),
        ),
        const SizedBox(height: 20),
        ...List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _InfoCard(
              title: 'Bridge Note ${index + 1}',
              body:
                  'This filler content exists only to make the tab-body '
                  'underlap obvious while the native tab bar stays fixed on top.',
            ),
          ),
        ),
      ],
    );
  }
}

class _TabPage extends StatelessWidget {
  const _TabPage({
    required this.storageId,
    required this.bottomInset,
    required this.children,
  });

  final String storageId;
  final double bottomInset;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: PageStorageKey<String>('tab-page-$storageId'),
      padding: EdgeInsets.fromLTRB(
        _kContentHorizontalPadding,
        _kContentTopPadding,
        _kContentHorizontalPadding,
        bottomInset + _kContentBottomPadding,
      ),
      children: children,
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(body, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _MetricStrip extends StatelessWidget {
  const _MetricStrip({
    required this.leadingLabel,
    required this.leadingValue,
    required this.trailingLabel,
    required this.trailingValue,
  });

  final String leadingLabel;
  final String leadingValue;
  final String trailingLabel;
  final String trailingValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: _MetricValue(label: leadingLabel, value: leadingValue),
            ),
            Container(
              width: 1,
              height: 42,
              color: theme.colorScheme.outlineVariant,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: _MetricValue(label: trailingLabel, value: trailingValue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricValue extends StatelessWidget {
  const _MetricValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _TopologyRow extends StatelessWidget {
  const _TopologyRow({required this.label, required this.detail});

  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 86,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer.withValues(
                alpha: 0.6,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(detail, style: theme.textTheme.bodyLarge),
            ),
          ),
        ],
      ),
    );
  }
}

class ObjcUiKitTabBarSurface extends StatefulWidget {
  const ObjcUiKitTabBarSurface({
    super.key,
    required this.bottomInset,
    required this.onTabSelected,
  });

  final double bottomInset;
  final ValueChanged<ObjcUiKitTab> onTabSelected;

  @override
  State<ObjcUiKitTabBarSurface> createState() => _ObjcUiKitTabBarSurfaceState();
}

class _ObjcUiKitTabBarSurfaceState extends State<ObjcUiKitTabBarSurface> {
  late final ObjcUiKitTabBarScene _scene = ObjcUiKitTabBarScene(
    bottomInset: widget.bottomInset,
    onTabSelected: widget.onTabSelected,
  );

  @override
  Widget build(BuildContext context) {
    return ObjCUiKitHostView(
      viewType: objcUiKitTabBarViewType,
      view: _scene.hostView,
    );
  }
}

enum ObjcUiKitTab {
  overview(0, 'Overview', 'square.text.square'),
  activity(1, 'Activity', 'bolt.horizontal.circle'),
  bridge(2, 'Bridge', 'link.circle');

  const ObjcUiKitTab(this.tag, this.title, this.symbolName);

  final int tag;
  final String title;
  final String symbolName;

  static ObjcUiKitTab fromTag(int tag) {
    return ObjcUiKitTab.values.firstWhere(
      (tab) => tab.tag == tag,
      orElse: () => ObjcUiKitTab.overview,
    );
  }
}

final class ObjcUiKitTabBarScene {
  ObjcUiKitTabBarScene._({
    required this.hostView,
    required this.tabBar,
    required this.retainedDelegate,
    required this.items,
  });

  factory ObjcUiKitTabBarScene({
    required double bottomInset,
    required ValueChanged<ObjcUiKitTab> onTabSelected,
  }) {
    final items = ObjcUiKitTab.values.map(_buildItem).toList(growable: false);
    final retainedDelegate = _NativeTabBarDelegate(
      onTabSelected: onTabSelected,
    ).asUITabBarDelegateListener;
    final tabBar = _buildTabBar(items: items, delegate: retainedDelegate);
    return ObjcUiKitTabBarScene._(
      hostView: tabBar,
      tabBar: tabBar,
      retainedDelegate: retainedDelegate,
      items: items,
    );
  }

  final UIView hostView;
  final UITabBar tabBar;
  final UITabBarDelegate retainedDelegate;
  final List<UITabBarItem> items;

  static UITabBar _buildTabBar({
    required List<UITabBarItem> items,
    required UITabBarDelegate delegate,
  }) {
    final tabBar = UITabBar.alloc().init();
    final appearance = UITabBarAppearance.alloc().init();
    appearance.configureWithTransparentBackground();
    appearance.backgroundEffect = UIBlurEffect.effectWithStyle(
      UIBlurEffectStyle.UIBlurEffectStyleSystemChromeMaterialLight,
    );
    appearance.backgroundColor = UIColor.getClearColor();
    tabBar.backgroundColor = UIColor.getClearColor();
    tabBar.isOpaque = false;
    tabBar.isTranslucent = true;
    tabBar.clipsToBounds = false;
    tabBar.itemPositioning =
        UITabBarItemPositioning.UITabBarItemPositioningFill;
    tabBar.standardAppearance = appearance;
    tabBar.scrollEdgeAppearance = appearance;
    tabBar.items = NSArray.of(items);
    tabBar.selectedItem = items.first;
    tabBar.delegate = delegate;
    return tabBar;
  }

  static UITabBarItem _buildItem(ObjcUiKitTab tab) {
    final image = UIImage.systemImageNamed(tab.symbolName.toNSString());
    return UITabBarItem.alloc().initWithTitleImageTag(
      tab.title.toNSString(),
      image: image,
      tag: tab.tag,
    );
  }
}

final class _NativeTabBarDelegate
    with UITabBarDelegateDefaults, UITabBarDelegateAdapter
    implements UITabBarDelegateSpec, UITabBarDelegateOptional {
  _NativeTabBarDelegate({required this.onTabSelected});

  final ValueChanged<ObjcUiKitTab> onTabSelected;

  @override
  void tabBarDidSelectItem(
    UITabBar tabBar, {
    required UITabBarItem didSelectItem,
  }) {
    tabBar.selectedItem = didSelectItem;
    onTabSelected(ObjcUiKitTab.fromTag(didSelectItem.tag));
  }
}
