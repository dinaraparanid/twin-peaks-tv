import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/router/app_router.gr.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';
import 'package:twin_peaks_tv/feature/main/main_tab.dart';

const _decorationSwitchDuration = Duration(milliseconds: 200);

List<TvNavigationMenuItem> buildOneUiNavigationItems({
  required BuildContext context,
}) {
  return [
    _MenuItem(
      key: const ValueKey(MainTab.home),
      title: context.ln.main_menu_home,
      onSelect: () => context.replaceRoute(const HomeRoute()),
      iconBuilder: (color) => ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 28,
          maxWidth: 28,
          maxHeight: 20,
        ),
        child: Assets.icons.home.svg(
          width: 28,
          height: 20,
          fit: BoxFit.fitHeight,
          colorFilter: color.toColorFilter(),
        ),
      ),
    ),
    _MenuItem(
      key: const ValueKey(MainTab.encyclopedia),
      title: context.ln.main_menu_encyclopedia,
      onSelect: () => context.replaceRoute(const EncyclopediaRoute()),
      iconBuilder: (color) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 28, maxHeight: 28),
        child: Assets.icons.encyclopedia.svg(
          width: 28,
          height: 28,
          fit: BoxFit.fitWidth,
          colorFilter: color.toColorFilter(),
        ),
      ),
    ),
    _MenuItem(
      key: const ValueKey(MainTab.settings),
      title: context.ln.main_menu_settings,
      iconBuilder: (color) => Icon(Icons.settings, size: 28, color: color),
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
    required this.onSelect,
  });

  final Key key;
  final String title;
  final Widget Function(Color)? iconBuilder;
  final VoidCallback onSelect;

  TvNavigationMenuItem build(BuildContext context) {
    final theme = context.appTheme;

    return TvNavigationMenuItem(
      key: key,
      iconBuilder: (context) => WidgetStateProperty.resolveWith((states) {
        final animation = OneUiTvNavigationDrawer.animationOf(context);

        final unfocusedColor = states.contains(WidgetState.selected)
            ? theme.colors.navigationMenu.itemSelectedFocused
            : theme.colors.navigationMenu.itemContent;

        final focusedColor = states.contains(WidgetState.selected)
            ? theme.colors.navigationMenu.itemContentSelected
            : theme.colors.navigationMenu.itemContent;

        return iconBuilder!(
          Color.lerp(unfocusedColor, focusedColor, animation.value)!,
        );
      }),
      onSelect: onSelect,
      builder: (context, constraints, states, icon) {
        final expandAnimation = OneUiTvNavigationDrawer.animationOf(context);

        final unfocusedColor = states.contains(WidgetState.selected)
            ? theme.colors.navigationMenu.itemSelectedFocused
            : theme.colors.navigationMenu.itemContent;

        final focusedColor = states.contains(WidgetState.selected)
            ? theme.colors.navigationMenu.itemContentSelected
            : theme.colors.navigationMenu.itemContent;

        final decoration = WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          final isFocused = states.contains(WidgetState.focused);

          final color = switch ((isSelected, isFocused)) {
            (true, true) => theme.colors.navigationMenu.itemSelectedFocused,

            (true, _) => Color.lerp(
              Colors.transparent,
              theme.colors.navigationMenu.itemSelectedUnfocused,
              expandAnimation.value,
            ),

            (_, true) => theme.colors.navigationMenu.itemFocused,

            _ => Colors.transparent,
          };

          return BoxDecoration(color: color);
        });

        return AnimatedContainer(
          duration: _decorationSwitchDuration,
          decoration: decoration.resolve(states),
          constraints: constraints,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              if (icon != null) Flexible(flex: 0, child: icon),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Opacity(
                    opacity: expandAnimation.value,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.navigationMenu.item.copyWith(
                        color: Color.lerp(
                          unfocusedColor,
                          focusedColor,
                          expandAnimation.value,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
