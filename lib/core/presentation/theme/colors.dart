import 'dart:ui';

import 'package:flutter/foundation.dart';

const _limeGreen = Color(0xFF39C43C);
const _limeGreen50 = Color(0x8039C43C);
const _limeGreen80 = Color(0xCC39C43C);
const _intenseCocoa = Color(0xFF593C39);
const _white = Color(0xFFFFFFFF);
const _pureSilver = Color(0xFFC4C7C5);
const _pearlBlack = Color(0xFF303030);
const _gray50 = Color(0x80808080);
const _elegantBlack = Color(0xFF131313);
const _elegantBlack80 = Color(0xCC131313);
const _elegantBlack60 = Color(0x99131313);
const _elegantBlack30 = Color(0x4D131313);
const _elegantBlack01 = Color(0x03131313);

@immutable
final class AppColors {
  const AppColors({
    this.primary = _limeGreen,
    this.background = const AppBackgroundColors(),
    this.splash = const AppSplashColors(),
    this.text = const AppTextColors(),
    this.navigationMenu = const AppNavigationMenuColors(),
  });

  final Color primary;
  final AppBackgroundColors background;
  final AppSplashColors splash;
  final AppTextColors text;
  final AppNavigationMenuColors navigationMenu;
}

@immutable
final class AppBackgroundColors {
  const AppBackgroundColors({
    this.primary = _elegantBlack,
    this.primary80 = _elegantBlack80,
    this.primary60 = _elegantBlack60,
    this.primary30 = _elegantBlack30,
    this.primary01 = _elegantBlack01,
  });

  final Color primary;
  final Color primary80;
  final Color primary60;
  final Color primary30;
  final Color primary01;
}

@immutable
final class AppSplashColors {
  const AppSplashColors({this.text = _intenseCocoa});

  final Color text;
}

@immutable
final class AppTextColors {
  const AppTextColors({this.primary = _white, this.secondary = _pureSilver});

  final Color primary;
  final Color secondary;
}

@immutable
final class AppNavigationMenuColors {
  const AppNavigationMenuColors({
    this.itemContent = _pureSilver,
    this.itemContentSelected = _pearlBlack,
    this.itemFocused = _gray50,
    this.itemSelectedUnfocused = _limeGreen50,
    this.itemSelectedFocused = _limeGreen80,
  });

  final Color itemContent;
  final Color itemContentSelected;
  final Color itemFocused;
  final Color itemSelectedUnfocused;
  final Color itemSelectedFocused;
}
