import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/core/utils/ext/focus_node_ext.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';
import 'package:twin_peaks_tv/feature/main/main_tab.dart';
import 'package:twin_peaks_tv/feature/main/widgets/widgets.dart';

@RoutePage()
final class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static BoxConstraints get materialConstraints =>
      BoxConstraints(minWidth: 88.s, maxWidth: 300.s);

  static BoxConstraints get cupertinoConstraints =>
      BoxConstraints(minWidth: 0, maxWidth: 240.s);

  static BoxConstraints get oneUiMenuConstraints =>
      BoxConstraints(minWidth: 64.s, maxWidth: 280.s);

  static MainScreenState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<MainScreenState>();

  static MainScreenState of(BuildContext context) => maybeOf(context)!;

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

final class MainScreenState extends State<MainScreen> {
  late final navMenuController = TvNavigationMenuController(
    initialEntry: const ItemEntry(key: ValueKey(MainTab.home)),
  );

  late final contentScopeNode = FocusScopeNode();

  @override
  void dispose() {
    navMenuController.dispose();
    contentScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final info = snapshot.data;

        if (info == null) {
          return const SizedBox();
        }

        return switch (AppPlatform.targetPlatform) {
          AppPlatforms.android => _MaterialUi(info: info),
          AppPlatforms.tizen => _TizenUi(info: info),
          AppPlatforms.tvos => _CupertinoUi(info: info),
          AppPlatforms.webos => _SandstoneUi(info: info),
        };
      },
    );
  }
}

final class _ContentScopeRouter extends StatelessWidget {
  const _ContentScopeRouter();

  @override
  Widget build(BuildContext context) {
    final state = MainScreen.of(context);

    return DpadFocusScope(
      focusScopeNode: state.contentScopeNode,
      onLeft: (_, _, isOutOfScope) {
        state.navMenuController.requestFocusOnMenu();
        return KeyEventResult.handled;
      },
      builder: (_, _) => const AutoRouter(requestFocus: false),
    );
  }
}

final class _MaterialUi extends StatelessWidget {
  const _MaterialUi({required this.info});
  final PackageInfo info;

  @override
  Widget build(BuildContext context) {
    final state = MainScreen.of(context);

    return TvNavigationDrawer(
      controller: MainScreen.of(context).navMenuController,
      backgroundColor: context.appTheme.colors.background.primary,
      mode: TvNavigationDrawerMode.modal,
      constraints: MainScreen.materialConstraints,
      separatorBuilder: (_) => SizedBox(height: 12.s),
      footer: buildMaterialAppVersion(info: info),
      menuItems: buildMaterialNavigationItems(context: context),
      drawerBuilder: (context, animation, child) {
        return MaterialMainMenu(child: child);
      },
      onRight: (_, _, isOutOfScope) {
        if (isOutOfScope) {
          state.contentScopeNode.requestFocusOnChild();
        }

        return KeyEventResult.handled;
      },
      builder: (_, _, _) => const _ContentScopeRouter(),
    );
  }
}

final class _CupertinoUi extends StatelessWidget {
  const _CupertinoUi({required this.info});
  final PackageInfo info;

  static const _expandDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final state = MainScreen.of(context);

    return CupertinoTvSidebar(
      controller: state.navMenuController,
      drawerAnimationsDuration: _expandDuration,
      backgroundColor: context.appTheme.colors.background.primary,
      constraints: MainScreen.cupertinoConstraints,
      separatorBuilder: (_) => SizedBox(height: 8.s),
      footer: buildCupertinoAppVersion(info: info),
      menuItems: buildCupertinoNavigationItems(context: context),
      drawerMargin: EdgeInsets.all(16.s),
      collapsedHeaderBuilder: (context, _, selectedItem) {
        return CupertinoFloatingHeader(
          controller: state.navMenuController,
          selectedItem: selectedItem,
        );
      },
      sidebarBuilder: (context, child) {
        return CupertinoMainMenu(child: child);
      },
      onRight: (_, _, isOutOfScope) {
        if (isOutOfScope) {
          state.contentScopeNode.requestFocusOnChild();
        }

        return KeyEventResult.handled;
      },
      builder: (_, _) => const _ContentScopeRouter(),
    );
  }
}

final class _TizenUi extends StatelessWidget {
  const _TizenUi({required this.info});
  final PackageInfo info;

  @override
  Widget build(BuildContext context) {
    final state = MainScreen.of(context);

    return OneUiTvNavigationDrawer(
      controller: state.navMenuController,
      backgroundColor: context.appTheme.colors.background.primary,
      constraints: MainScreen.oneUiMenuConstraints,
      separatorBuilder: (_) => SizedBox(height: 12.s),
      footer: buildOneUiAppVersion(info: info),
      menuItems: buildOneUiNavigationItems(context: context),
      drawerBuilder: (context, animation, child) {
        return OneUiMainMenu(animation: animation, child: child);
      },
      onRight: (_, _, isOutOfScope) {
        if (isOutOfScope) {
          state.contentScopeNode.requestFocusOnChild();
        }

        return KeyEventResult.handled;
      },
      builder: (_, _, _) => const _ContentScopeRouter(),
    );
  }
}

final class _SandstoneUi extends StatelessWidget {
  const _SandstoneUi({required this.info});
  final PackageInfo info;

  @override
  Widget build(BuildContext context) {
    final state = MainScreen.of(context);

    return SandstoneVerticalTabLayout(
      controller: state.navMenuController,
      backgroundColor: context.appTheme.colors.background.primary,
      tabs: buildSandstoneNavigationItems(context: context),
      tabsBuilder: (context, _, child) => SandstoneMainMenu(child: child),
      separatorBuilder: (_, _, _) => SizedBox(height: 12.s),
      onRight: (_, _, isOutOfScope) {
        if (isOutOfScope) {
          state.contentScopeNode.requestFocusOnChild();
        }

        return KeyEventResult.handled;
      },
      builder: (_, _, _) => const _ContentScopeRouter(),
    );
  }
}
