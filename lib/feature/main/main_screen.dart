import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';
import 'package:twin_peaks_tv/feature/main/main_tab.dart';
import 'package:twin_peaks_tv/feature/main/widgets/widgets.dart';

@RoutePage()
final class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const materialConstraints = BoxConstraints(
    minWidth: 80,
    maxWidth: 240,
  );

  static const oneUiMenuConstraints = BoxConstraints(
    minWidth: 64,
    maxWidth: 200,
  );

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

final class _MainScreenState extends State<MainScreen> {
  late final _controller = TvNavigationMenuController(
    initialEntry: const ItemEntry(key: ValueKey(MainTab.home)),
  );

  late final _contentScopeNode = FocusScopeNode();

  @override
  void dispose() {
    _controller.dispose();
    _contentScopeNode.dispose();
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
          AppPlatforms.android => _MaterialUi(
            info: info,
            controller: _controller,
            contentScopeNode: _contentScopeNode,
          ),

          AppPlatforms.tizen => _TizenUi(
            info: info,
            controller: _controller,
            contentScopeNode: _contentScopeNode,
          ),

          AppPlatforms.tvos => throw UnimplementedError(),

          AppPlatforms.webos => throw UnimplementedError(),
        };
      },
    );
  }
}

final class _MaterialUi extends StatelessWidget {
  const _MaterialUi({
    required this.info,
    required this.controller,
    required this.contentScopeNode,
  });

  final PackageInfo info;
  final TvNavigationMenuController controller;
  final FocusScopeNode contentScopeNode;

  @override
  Widget build(BuildContext context) {
    return TvNavigationDrawer(
      controller: controller,
      backgroundColor: context.appTheme.colors.background.primary,
      mode: TvNavigationDrawerMode.modal,
      constraints: MainScreen.materialConstraints,
      separatorBuilder: (_) => const SizedBox(height: 12),
      footer: buildMaterialAppVersion(info: info),
      menuItems: buildMaterialNavigationItems(context: context),
      drawerBuilder: (context, animation, child) {
        return MaterialMainMenu(child: child);
      },
      onRight: (_, _, isOutOfScope) {
        if (isOutOfScope) {
          contentScopeNode.requestFocus();
        }

        return KeyEventResult.handled;
      },
      builder: (_, _, _) => DpadFocusScope(
        focusScopeNode: contentScopeNode,
        onLeft: (_, _, isOutOfScope) {
          controller.requestFocusOnMenu();
          return KeyEventResult.handled;
        },
        builder: (_, _) => const AutoRouter(requestFocus: false),
      ),
    );
  }
}

final class _TizenUi extends StatelessWidget {
  const _TizenUi({
    required this.info,
    required this.controller,
    required this.contentScopeNode,
  });

  final PackageInfo info;
  final TvNavigationMenuController controller;
  final FocusScopeNode contentScopeNode;

  @override
  Widget build(BuildContext context) {
    return OneUiTvNavigationDrawer(
      controller: controller,
      backgroundColor: context.appTheme.colors.background.primary,
      constraints: MainScreen.oneUiMenuConstraints,
      separatorBuilder: (_) => const SizedBox(height: 12),
      footer: buildOneUiAppVersion(info: info),
      menuItems: buildOneUiNavigationItems(context: context),
      drawerBuilder: (context, animation, child) {
        return OneUiMainMenu(animation: animation, child: child);
      },
      onRight: (_, _, isOutOfScope) {
        if (isOutOfScope) {
          contentScopeNode.requestFocus();
        }

        return KeyEventResult.handled;
      },
      builder: (_, _, _) => DpadFocusScope(
        focusScopeNode: contentScopeNode,
        onLeft: (_, _, isOutOfScope) {
          controller.requestFocusOnMenu();
          return KeyEventResult.handled;
        },
        builder: (_, _) => const AutoRouter(requestFocus: false),
      ),
    );
  }
}
