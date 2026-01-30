import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/feature/main/main_tab.dart';
import 'package:twin_peaks_tv/feature/main/widgets/widgets.dart';

@RoutePage()
final class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const drawerExpandDuration = Duration(milliseconds: 300);
  static const itemExpandDuration = Duration(milliseconds: 350);

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

        return _MaterialUi(
          info: info,
          controller: _controller,
          contentScopeNode: _contentScopeNode,
        );
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
      drawerExpandDuration: MainScreen.drawerExpandDuration,
      mode: TvNavigationDrawerMode.modal,
      constraints: const BoxConstraints(minWidth: 60, maxWidth: 280),
      separatorBuilder: (_) => const SizedBox(height: 12),
      footer: buildAppVersion(
        info: info,
        isMenuExpanded: () => controller.hasFocus,
      ),
      menuItems: buildMaterialNavigationItems(
        context: context,
        isDrawerExpanded: () => controller.hasFocus,
      ),
      drawerBuilder: (context, child) {
        return MaterialMainMenu(child: child);
      },
      onRight: (_, _, isOutOfScope) {
        if (isOutOfScope) {
          contentScopeNode.requestFocus();
        }

        return KeyEventResult.handled;
      },
      builder: (_, _) => DpadFocusScope(
        focusScopeNode: contentScopeNode,
        builder: (_) => const AutoRouter(requestFocus: false),
      ),
    );
  }
}
