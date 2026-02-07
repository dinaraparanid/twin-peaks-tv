import 'package:flutter/widgets.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/feature/home/home_screen.dart';
import 'package:twin_peaks_tv/feature/home/home_tab.dart';

final class MaterialTabBar extends StatelessWidget {
  const MaterialTabBar({
    super.key,
    required this.tabController,
    required this.tabFocusScopeNode,
    required this.contentFocusNode,
    required this.currentIndex,
  });

  final TvTabBarController tabController;
  final FocusScopeNode tabFocusScopeNode;
  final FocusNode contentFocusNode;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 48),
        TvTabBar.secondary(
          controller: tabController,
          focusScopeNode: tabFocusScopeNode,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 16,
          animationDuration: HomeScreen.tabAnimationDuration,
          indicatorBuilder: _buildIndicator,
          onDown: (_, _, _) {
            contentFocusNode.requestFocus();
            return KeyEventResult.handled;
          },
          onLeft: (_, _, isOutOfScope) {
            if (isOutOfScope) {
              TvNavigationDrawer.of(context).requestFocusOnMenu();
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
    final tabColors = context.appTheme.colors.tabBar;

    return _TabIndicator(
      tabBarHasFocus: tabBarHasFocus,
      tabSize: tabSize,
      color: WidgetStateProperty.fromMap({
        WidgetState.focused: tabColors.selectedFocused,
        WidgetState.selected: tabColors.selectedUnfocused,
      }),
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
    return TvTab(
      autofocus: isSelected,
      child: Text(
        tab.buildTitle(context),
        style: context.appTheme.typography.tabBar.primary.copyWith(
          color: _buildTabColor(context),
        ),
      ),
    );
  }

  Color _buildTabColor(BuildContext context) {
    final tabColors = context.appTheme.colors.tabBar;

    if (isSelected && tabBarHasFocus) {
      return tabColors.selectedFocused;
    }

    if (isSelected) {
      return tabColors.selectedUnfocused;
    }

    return tabColors.unselected;
  }
}

final class _TabIndicator extends StatelessWidget {
  const _TabIndicator({
    required this.tabBarHasFocus,
    required this.tabSize,
    required this.color,
  });

  static const _unfocusedWidth = 8.0;
  static const _radius = BorderRadius.all(Radius.circular(2));

  final bool tabBarHasFocus;
  final Size tabSize;
  final WidgetStateProperty<Color> color;

  @override
  Widget build(BuildContext context) {
    final margin = (tabSize.width - _unfocusedWidth) / 2;

    return AnimatedContainer(
      duration: HomeScreen.tabAnimationDuration,
      height: 2,
      width: tabBarHasFocus ? tabSize.width : _unfocusedWidth,
      margin: EdgeInsets.only(left: tabBarHasFocus ? 0 : margin),
      decoration: BoxDecoration(
        color: tabBarHasFocus
            ? color.resolve({WidgetState.focused})
            : color.resolve({WidgetState.selected}),
        borderRadius: _radius,
      ),
    );
  }
}
