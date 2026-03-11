import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/router/app_router.gr.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';
import 'package:twin_peaks_tv/feature/main/main_tab.dart';

List<SandstoneVerticalTab> buildSandstoneNavigationItems({
  required BuildContext context,
}) {
  return [
    _MenuItem(
      key: const ValueKey(MainTab.home),
      title: context.ln.main_menu_home,
      onSelect: () => context.replaceRoute(const HomeRoute()),
      iconBuilder: (color) => ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 36.s,
          maxWidth: 36.s,
          maxHeight: 28.s,
        ),
        child: Assets.icons.home.svg(
          width: 36.iz,
          height: 28.iz,
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
        constraints: BoxConstraints(maxWidth: 36.s, maxHeight: 36.s),
        child: Assets.icons.encyclopedia.svg(
          width: 36.iz,
          height: 36.iz,
          fit: BoxFit.fitWidth,
          colorFilter: color.toColorFilter(),
        ),
      ),
    ),
    _MenuItem(
      key: const ValueKey(MainTab.settings),
      title: context.ln.main_menu_settings,
      iconBuilder: (color) => Icon(Icons.settings, size: 36.iz, color: color),
      onSelect: () => context.replaceRoute(const SettingsRoute()),
    ),
  ].map((i) => i.build(context)).toList(growable: false);
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
  final Widget Function(Color) iconBuilder;
  final VoidCallback onSelect;

  SandstoneVerticalTab build(BuildContext context) {
    final theme = context.appTheme;

    return SandstoneVerticalTab(
      key: key,
      iconBuilder: (context, _) {
        return WidgetStateProperty.resolveWith((states) => iconBuilder(
          states.contains(WidgetState.selected)
              ? theme.colors.navigationMenu.itemContentSelected
              : theme.colors.navigationMenu.itemContent,
        ));
      },
      onSelect: onSelect,
      builder: (context, states, isExpanded, icon) {
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
            (true, _) => theme.colors.navigationMenu.itemSelectedFocused,
            (_, true) => theme.colors.navigationMenu.itemFocused,
            _ => Colors.transparent,
          };

          return BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(4.r)),
          );
        });

        return Container(
          decoration: decoration.resolve(states),
          padding: EdgeInsets.symmetric(vertical: 12.s, horizontal: 12.s),
          child: Row(
            children: [
              ?icon,

              if (isExpanded)
                Padding(
                  padding: EdgeInsets.only(left: 12.s),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.typography.navigationMenu.item.copyWith(
                      color: isExpanded ? focusedColor : unfocusedColor,
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
