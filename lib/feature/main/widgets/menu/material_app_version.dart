import 'package:flutter/cupertino.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/core/presentation/theme/strings.dart';

TvNavigationDrawerItem buildMaterialAppVersion({required PackageInfo info}) {
  return TvNavigationDrawerItem(
    isSelectable: false,
    canRequestFocus: false,
    iconBuilder: null,
    builder: (context, constraints, states, _) {
      final expandAnimation = TvNavigationDrawer.animationOf(context);

      return ConstrainedBox(
        constraints: constraints,
        child: Padding(
          padding: EdgeInsets.only(left: 20.s, bottom: 12.s),
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
