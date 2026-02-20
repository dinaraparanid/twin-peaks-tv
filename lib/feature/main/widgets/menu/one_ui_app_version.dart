import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/core/presentation/theme/strings.dart';

TvNavigationMenuItem buildOneUiAppVersion({required PackageInfo info}) {
  return TvNavigationMenuItem(
    isSelectable: false,
    canRequestFocus: false,
    iconBuilder: null,
    builder: (context, constraints, states, _) {
      final expandAnimation = OneUiTvNavigationDrawer.animationOf(context);

      return ConstrainedBox(
        constraints: constraints,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 12),
          child: Opacity(
            opacity: expandAnimation.value,
            child: Text(
              context.ln.main_app_version(info.version),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.appTheme.typography.navigationMenu.footer.copyWith(
                color: context.appTheme.colors.text.secondary,
              ),
            ),
          ),
        ),
      );
    },
  );
}
