import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/router/app_router.gr.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';
import 'package:twin_peaks_tv/feature/main/main_tab.dart';

const _decorationSwitchDuration = Duration(milliseconds: 200);

List<TvNavigationMenuItem> buildCupertinoNavigationItems({
  required BuildContext context,
}) {
  return [
    _MenuItem(
      key: const ValueKey(MainTab.home),
      title: context.ln.main_menu_home,
      onSelect: () => context.replaceRoute(const HomeRoute()),
      iconBuilder: (context, states) {
        final (bg, content) = _getIconColors(context: context, states: states);

        return ClipOval(
          child: Container(
            padding: EdgeInsets.all(8.s),
            decoration: BoxDecoration(color: bg),
            child: SizedBox(
              width: 24.s,
              child: Assets.icons.home.svg(
                width: 24.iz,
                height: 20.iz,
                fit: BoxFit.fitHeight,
                colorFilter: content.toColorFilter(),
              ),
            ),
          ),
        );
      },
    ),
    _MenuItem(
      key: const ValueKey(MainTab.encyclopedia),
      title: context.ln.main_menu_encyclopedia,
      onSelect: () => context.replaceRoute(const EncyclopediaRoute()),
      iconBuilder: (context, states) {
        final (bg, content) = _getIconColors(context: context, states: states);

        return ClipOval(
          child: Container(
            padding: EdgeInsets.all(4.s),
            decoration: BoxDecoration(color: bg),
            child: SizedBox(
              width: 28.s,
              child: Assets.icons.encyclopedia.svg(
                width: 28.iz,
                height: 28.iz,
                fit: BoxFit.fitWidth,
                colorFilter: content.toColorFilter(),
              ),
            ),
          ),
        );
      },
    ),
    _MenuItem(
      key: const ValueKey(MainTab.settings),
      title: context.ln.main_menu_settings,
      iconBuilder: (context, states) {
        final (bg, content) = _getIconColors(context: context, states: states);

        return ClipOval(
          child: AnimatedContainer(
            duration: _decorationSwitchDuration,
            padding: EdgeInsets.all(8.s),
            decoration: BoxDecoration(color: bg),
            child: Icon(CupertinoIcons.settings, size: 24.iz, color: content),
          ),
        );
      },
      onSelect: () => context.replaceRoute(const SettingsRoute()),
    ),
  ].map((i) => i.build(context)).toList(growable: false);
}

(Color, Color) _getIconColors({
  required BuildContext context,
  required Set<WidgetState> states,
}) {
  final navMenuColors = context.appTheme.colors.navigationMenu;

  final bg =
      states.contains(WidgetState.selected) ||
          states.contains(WidgetState.focused)
      ? navMenuColors.iconBackgroundSelected
      : navMenuColors.iconBackground;

  final content =
      states.contains(WidgetState.selected) ||
          states.contains(WidgetState.focused)
      ? navMenuColors.itemContentSelected
      : navMenuColors.itemContent;

  return (bg, content);
}

@immutable
final class _MenuItem {
  const _MenuItem({
    required this.key,
    required this.title,
    required this.iconBuilder,
    required this.onSelect,
  });

  final Key key;
  final String title;
  final Widget Function(BuildContext, Set<WidgetState>) iconBuilder;
  final VoidCallback onSelect;

  TvNavigationMenuItem build(BuildContext context) {
    final theme = context.appTheme;

    final decoration = WidgetStateProperty.resolveWith((states) {
      final isSelected = states.contains(WidgetState.selected);
      final isFocused = states.contains(WidgetState.focused);

      final color = switch ((isSelected, isFocused)) {
        (true, true) => theme.colors.navigationMenu.itemSelectedFocused,
        (true, _) => theme.colors.navigationMenu.itemSelectedUnfocused,
        (_, true) => theme.colors.navigationMenu.itemFocused,
        _ => CupertinoColors.transparent,
      };

      return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      );
    });

    return TvNavigationMenuItem(
      key: key,
      iconBuilder: (context) => WidgetStateProperty.resolveWith((states) {
        return iconBuilder(context, states);
      }),
      onSelect: onSelect,
      builder: (context, constraints, states, icon) {
        final color = states.contains(WidgetState.selected)
            ? theme.colors.navigationMenu.itemContentSelected
            : theme.colors.navigationMenu.itemContent;

        return AnimatedContainer(
          duration: _decorationSwitchDuration,
          decoration: decoration.resolve(states),
          constraints: constraints,
          padding: EdgeInsets.symmetric(horizontal: 16.s, vertical: 12.s),
          child: Row(
            children: [
              if (icon != null) Flexible(flex: 0, child: icon),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.s),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.typography.navigationMenu.item.copyWith(
                      fontSize: 18.fz,
                      color: color,
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
