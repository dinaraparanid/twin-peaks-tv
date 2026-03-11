import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/core/utils/ext/focus_node_ext.dart';
import 'package:twin_peaks_tv/feature/home/home_tab.dart';

final class SandstoneTabBar extends StatelessWidget {
  const SandstoneTabBar({
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.s, vertical: 12.s),
      child: SandstoneHorizontalTabLayout(
        controller: tabController,
        focusScopeNode: tabFocusScopeNode,
        indicatorBuilder: _buildIndicator,
        onDown: (_, _, _) {
          contentFocusNode.requestFocusOnChild();
          return KeyEventResult.handled;
        },
        onLeft: (_, _, isOutOfScope) {
          if (isOutOfScope) {
            SandstoneVerticalTabLayout.of(
              context,
            ).controller.requestFocusOnMenu();
          }

          return KeyEventResult.handled;
        },
        tabs: [
          for (final tab in HomeTab.values)
            _TabItem(
              tab: tab,
              isSelected: currentIndex == tab.index,
              tabBarHasFocus: tabFocusScopeNode.hasFocus,
              onSelected: () => tabController.select(tab.index),
            ),
        ],
      ),
    );
  }

  Widget _buildIndicator(
    BuildContext context,
    Offset tabOffset,
    Size tabSize,
    bool hasFocus,
  ) {
    final tabColors = context.appTheme.colors.tabBar;

    return hasFocus
        ? _TabPrimaryIndicator(
            tabSize: tabSize,
            color: tabColors.selectedFocused,
          )
        : _TabSecondaryIndicator(
            tabSize: tabSize,
            color: tabColors.selectedUnfocused,
          );
  }
}

final class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.tab,
    required this.isSelected,
    required this.tabBarHasFocus,
    required this.onSelected,
  });

  final HomeTab tab;
  final bool isSelected;
  final bool tabBarHasFocus;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return TvTab(
      autofocus: isSelected,
      onSelected: onSelected,
      height: 32.s,
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
      return tabColors.selectedContrast;
    }

    if (isSelected) {
      return tabColors.selectedUnfocused;
    }

    return tabColors.unselected;
  }
}

final class _TabPrimaryIndicator extends StatelessWidget {
  const _TabPrimaryIndicator({required this.tabSize, required this.color});

  final Size tabSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: tabSize.height,
      width: tabSize.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(2.r)),
      ),
    );
  }
}

final class _TabSecondaryIndicator extends StatelessWidget {
  const _TabSecondaryIndicator({required this.tabSize, required this.color});

  final Size tabSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.s,
      width: tabSize.width * 0.9,
      margin: EdgeInsets.only(left: tabSize.width * 0.05),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(2.r)),
      ),
    );
  }
}
