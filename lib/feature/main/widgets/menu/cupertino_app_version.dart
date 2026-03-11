import 'package:flutter/cupertino.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/core/presentation/theme/strings.dart';

CupertinoTvSidebarItem buildCupertinoAppVersion({required PackageInfo info}) {
  return CupertinoTvSidebarItem(
    isSelectable: false,
    canRequestFocus: false,
    iconBuilder: null,
    builder: (context, constraints, states, _) {
      return Container(
        constraints: constraints,
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(left: 20.s, bottom: 12.s),
          child: Text(
            context.ln.main_app_version(info.version),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.appTheme.typography.navigationMenu.footer.copyWith(
              color: CupertinoColors.white,
            ),
          ),
        ),
      );
    },
  );
}
