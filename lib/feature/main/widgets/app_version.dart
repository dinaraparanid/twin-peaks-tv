import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/core/presentation/theme/strings.dart';

TvNavigationMenuItem buildAppVersion({
  required PackageInfo info,
  required bool Function() isMenuExpanded,
}) {
  return TvNavigationMenuItem(
    isSelectable: false,
    canRequestFocus: false,
    builder: (context, constraints, states) {
      return ConstrainedBox(
        constraints: constraints,
        child: Opacity(
          opacity: isMenuExpanded() ? 1 : 0,
          child: Text(
            context.ln.main_app_version(info.version),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.appTheme.typography.navigationMenu.footer.copyWith(
              color: context.appTheme.colors.text.secondary,
            ),
          ),
        ),
      );
    },
  );
}
