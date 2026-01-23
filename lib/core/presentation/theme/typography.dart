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
  }

  late final SplashTypography splash;
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
