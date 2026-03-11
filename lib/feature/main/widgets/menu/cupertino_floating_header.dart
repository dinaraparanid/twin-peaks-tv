import 'package:flutter/cupertino.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/main/main_screen.dart';
import 'package:twin_peaks_tv/feature/main/main_tab.dart';

final class CupertinoFloatingHeader extends StatelessWidget {
  const CupertinoFloatingHeader({
    super.key,
    required this.controller,
    required this.selectedItem,
  });

  final TvNavigationMenuController controller;
  final CupertinoTvSidebarItem selectedItem;

  @override
  Widget build(BuildContext context) {
    final radius = 40.r;

    return Container(
      width: MainScreen.cupertinoConstraints.maxWidth,
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.chevron_compact_left,
            size: 28.iz,
            color: context.appTheme.colors.cupertino.collapsedHeaderContent,
          ),

          LiquidGlassLayer(
            settings: AppLiquidGlass.defaultSettings(context),
            child: FakeGlass(
              shape: LiquidRoundedRectangle(borderRadius: radius),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.s),
                    child: _Icon(selectedItem: selectedItem),
                  ),

                  SizedBox(width: 4.s),

                  Padding(
                    padding: EdgeInsets.only(
                      top: 12.s,
                      bottom: 12.s,
                      right: 32.s,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200.s),
                      child: _Text(selectedItem: selectedItem),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _Icon extends StatelessWidget {
  const _Icon({required this.selectedItem});
  final CupertinoTvSidebarItem selectedItem;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final contentColor = theme.colors.cupertino.collapsedHeaderContent;

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colors.navigationMenu.iconBackground,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.s),
        child: switch (selectedItem.key) {
          ValueKey(value: MainTab.home) => ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 16.s,
              maxWidth: 16.s,
              maxHeight: 16.s,
            ),
            child: Assets.icons.home.svg(
              width: 16.iz,
              height: 16.iz,
              fit: BoxFit.fitHeight,
              colorFilter: contentColor.toColorFilter(),
            ),
          ),

          ValueKey(value: MainTab.encyclopedia) => ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 16.s, maxHeight: 16.s),
            child: Assets.icons.encyclopedia.svg(
              width: 16.iz,
              height: 16.iz,
              fit: BoxFit.fitWidth,
              colorFilter: contentColor.toColorFilter(),
            ),
          ),

          ValueKey(value: MainTab.settings) => Icon(
            CupertinoIcons.settings,
            size: 16.iz,
            color: contentColor,
          ),

          _ => const SizedBox(),
        },
      ),
    );
  }
}

final class _Text extends StatelessWidget {
  const _Text({required this.selectedItem});
  final CupertinoTvSidebarItem selectedItem;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final contentColor = theme.colors.cupertino.collapsedHeaderContent;

    final key = selectedItem.key;

    final title = key is ValueKey<MainTab> ? key.value.title(context) : '...';

    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.typography.navigationMenu.floatingHeader.copyWith(
        color: contentColor,
      ),
    );
  }
}
