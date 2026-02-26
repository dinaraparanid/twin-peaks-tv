import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/core/utils/ext/focus_node_ext.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/home/home_screen.dart';
import 'package:twin_peaks_tv/feature/home/home_tab.dart';

final class CupertinoTabBar extends StatelessWidget {
  const CupertinoTabBar({
    super.key,
    required this.tabController,
    required this.tabFocusScopeNode,
    required this.contentFocusNode,
    required this.currentIndex,
  });

  final TvTabBarController tabController;
  final FocusScopeNode tabFocusScopeNode;
  final FocusScopeNode contentFocusNode;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8.s),

        CupertinoTvTabBar(
          controller: tabController,
          focusScopeNode: tabFocusScopeNode,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          animationDuration: HomeScreen.tabAnimationDuration,
          padding: EdgeInsets.symmetric(horizontal: 24.s),
          separatorBuilder: (_, _) => SizedBox(width: 40.s),
          indicatorPadding: EdgeInsets.symmetric(horizontal: 12.s),
          indicatorMargin: EdgeInsets.symmetric(vertical: 8.s),
          indicatorBuilder: _buildIndicator,
          decorationBuilder: (context, child) {
            return LiquidGlassLayer(
              settings: AppLiquidGlass.defaultSettings(context),
              child: FakeGlass(
                shape: LiquidRoundedRectangle(borderRadius: 24.r),
                child: child,
              ),
            );
          },
          onDown: (_, _, _) {
            contentFocusNode.requestFocusOnChild();
            return KeyEventResult.handled;
          },
          onLeft: (_, _, isOutOfScope) {
            if (isOutOfScope) {
              CupertinoTvSidebar.of(context).requestFocusOnMenu();
            }

            return KeyEventResult.handled;
          },
          tabs: [
            for (final tab in HomeTab.values)
              _TabItem(
                tab: tab,
                isSelected: currentIndex == tab.index,
                tabBarHasFocus: tabFocusScopeNode.hasFocus,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildIndicator(
    BuildContext context,
    Offset tabOffset,
    Size tabSize,
    bool tabBarHasFocus,
  ) {
    final radius = BorderRadius.all(Radius.circular(28.r));
    final tabColors = context.appTheme.colors.tabBar;

    return AnimatedScale(
      scale: tabBarHasFocus ? 1.2 : 1,
      duration: HomeScreen.tabAnimationDuration,
      child: AnimatedContainer(
        duration: HomeScreen.tabAnimationDuration,
        width: tabSize.width,
        height: tabSize.height,
        decoration: BoxDecoration(
          borderRadius: radius,
          color: tabBarHasFocus
              ? tabColors.selectedFocused
              : tabColors.selectedUnfocused,
        ),
      ),
    );
  }
}

final class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.tab,
    required this.isSelected,
    required this.tabBarHasFocus,
  });

  final HomeTab tab;
  final bool isSelected;
  final bool tabBarHasFocus;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected && tabBarHasFocus ? 1.2 : 1,
      duration: HomeScreen.tabAnimationDuration,
      child: TvTab(
        height: 48.s,
        autofocus: isSelected,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.s),
          child: Text(
            tab.buildTitle(context),
            style: context.appTheme.typography.tabBar.primary.copyWith(
              color: _buildTabColor(context),
            ),
          ),
        ),
      ),
    );
  }

  Color _buildTabColor(BuildContext context) {
    final tabColors = context.appTheme.colors.tabBar;
    return isSelected ? tabColors.selectedContrast : tabColors.unselected;
  }
}
