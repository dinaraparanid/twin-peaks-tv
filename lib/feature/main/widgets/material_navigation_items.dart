import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/router/app_router.gr.dart';
import 'package:twin_peaks_tv/feature/main/main_screen.dart';
import 'package:twin_peaks_tv/feature/main/main_tab.dart';

List<TvNavigationMenuItem> buildMaterialNavigationItems({
  required BuildContext context,
  required bool Function() isDrawerExpanded,
}) {
  return [
    _MenuItem(
      key: const ValueKey(MainTab.home),
      title: context.ln.main_menu_home,
      isDrawerExpanded: isDrawerExpanded,
      onSelect: () => context.replaceRoute(const HomeRoute()),
      iconBuilder: (color) => ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 28.0,
          maxWidth: 28.0,
          maxHeight: 20.0,
        ),
        child: Assets.icons.home.svg(
          width: 28.0,
          height: 20.0,
          fit: BoxFit.fitHeight,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    ),
    _MenuItem(
      key: const ValueKey(MainTab.encyclopedia),
      title: context.ln.main_menu_encyclopedia,
      isDrawerExpanded: isDrawerExpanded,
      onSelect: () => context.replaceRoute(const EncyclopediaRoute()),
      iconBuilder: (color) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 28.0, maxHeight: 28.0),
        child: Assets.icons.encyclopedia.svg(
          width: 28.0,
          height: 28.0,
          fit: BoxFit.fitWidth,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    ),
    _MenuItem(
      key: const ValueKey(MainTab.settings),
      title: context.ln.main_menu_settings,
      isDrawerExpanded: isDrawerExpanded,
      iconBuilder: (color) => Icon(Icons.settings, size: 28.0, color: color),
      onSelect: () => context.replaceRoute(const SettingsRoute()),
    ),
  ].map((i) => i.build(context)).toList(growable: false);
}

@immutable
final class _MenuItem {
  const _MenuItem({
    required this.key,
    required this.title,
    this.iconBuilder,
    required this.isDrawerExpanded,
    required this.onSelect,
  });

  final Key key;
  final String title;
  final Widget Function(Color)? iconBuilder;
  final bool Function() isDrawerExpanded;
  final VoidCallback onSelect;

  TvNavigationMenuItem build(BuildContext context) {
    final theme = context.appTheme;

    return TvNavigationMenuItem(
      key: key,
      decoration: WidgetStateProperty.resolveWith((states) {
        final isSelected = states.contains(WidgetState.selected);
        final isFocused = states.contains(WidgetState.focused);

        final color = switch ((isSelected, isFocused)) {
          (true, true) => theme.colors.navigationMenu.itemSelectedFocused,
          (true, _) => theme.colors.navigationMenu.itemSelectedUnfocused,
          (_, true) => theme.colors.navigationMenu.itemFocused,
          _ => Colors.transparent,
        };

        return BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(32)),
        );
      }),
      icon: WidgetStateProperty.resolveWith((states) {
        final color = states.contains(WidgetState.selected)
            ? theme.colors.navigationMenu.itemContentSelected
            : theme.colors.navigationMenu.itemContent;

        return iconBuilder!(color);
      }),
      onSelect: onSelect,
      builder: (context, constraints, states) {
        final color = states.contains(WidgetState.selected)
            ? theme.colors.navigationMenu.itemContentSelected
            : theme.colors.navigationMenu.itemContent;

        return ConstrainedBox(
          constraints: constraints,
          child: AnimatedOpacity(
            opacity: isDrawerExpanded() ? 1 : 0,
            duration: MainScreen.itemExpandDuration,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.typography.navigationMenu.item.copyWith(
                color: color,
              ),
            ),
          ),
        );
      },
    );
  }
}
