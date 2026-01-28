import 'dart:io';

import 'package:flutter/widgets.dart';

@immutable
final class AppTypography {
  AppTypography({required BuildContext context}) {
    final fontFamily = Platform.isAndroid
        ? 'Roboto'
        : Platform.isIOS
        ? 'SF Pro'
        : 'Inter';

    splash = SplashTypography._(fontFamily: fontFamily);
    navigationMenu = NavigationMenuTypography._(fontFamily: fontFamily);
    tabBar = TabBarTypography._(fontFamily: fontFamily);
  }

  late final SplashTypography splash;
  late final NavigationMenuTypography navigationMenu;
  late final TabBarTypography tabBar;
}

@immutable
final class SplashTypography {
  SplashTypography._({required String fontFamily}) {
    splashHeader = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 48,
      letterSpacing: 4,
    );

    splashSubText = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24,
      letterSpacing: 2,
    );
  }

  late final TextStyle splashHeader;
  late final TextStyle splashSubText;
}

@immutable
final class NavigationMenuTypography {
  NavigationMenuTypography._({required String fontFamily}) {
    item = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    );

    footer = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
  }

  late final TextStyle item;
  late final TextStyle footer;
}

@immutable
final class TabBarTypography {
  TabBarTypography._({required String fontFamily}) {
    primary = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
  }

  late final TextStyle primary;
}
