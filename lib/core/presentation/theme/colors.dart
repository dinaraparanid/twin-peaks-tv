import 'dart:ui';

import 'package:flutter/foundation.dart';

const _limeGreen = Color(0xFF39C43C);
const _intenseCocoa = Color(0xFF593C39);

@immutable
final class AppColors {
  const AppColors({
    this.primary = _limeGreen,
    this.splash = const AppSplashColors(),
  });

  final Color primary;
  final AppSplashColors splash;
}

@immutable
final class AppSplashColors {
  const AppSplashColors({this.text = _intenseCocoa});

  final Color text;
}
