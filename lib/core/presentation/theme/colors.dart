import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';

const _limeGreen = Color(0xFF39C43C);
const _limeGreen50 = Color(0x8039C43C);
const _limeGreen60 = Color(0x9939C43C);
const _limeGreen80 = Color(0xCC39C43C);
const _intenseCocoa = Color(0xFF593C39);
const _white = Color(0xFFFFFFFF);
const _white80 = Color(0xCCFFFFFF);
const _pureSilver = Color(0xFFC4C7C5);
const _pearlBlack = Color(0xFF303030);
const _gray50 = Color(0x80808080);
const _elegantBlack = Color(0xFF131313);
const _elegantBlack80 = Color(0xCC131313);
const _elegantBlack60 = Color(0x99131313);
const _elegantBlack30 = Color(0x4D131313);
const _elegantBlack10 = Color(0x1A131313);
const _elegantBlack01 = Color(0x03131313);
const _royalWhite50 = Color(0x80FEFFFE);
const _transparent = Color(0x00000000);

@immutable
final class AppColors {
  const AppColors({
    this.primary = _limeGreen,
    this.background = const BackgroundColors(),
    this.splash = const SplashColors(),
    this.text = const TextColors(),
    this.navigationMenu = const NavigationMenuColors(),
    this.tabBar = const TabBarColors(),
    this.gradients = const Gradients(),
  });

  final Color primary;
  final BackgroundColors background;
  final SplashColors splash;
  final TextColors text;
  final NavigationMenuColors navigationMenu;
  final TabBarColors tabBar;
  final Gradients gradients;
}

@immutable
final class BackgroundColors {
  const BackgroundColors({
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
final class SplashColors {
  const SplashColors({this.text = _intenseCocoa});

  final Color text;
}

@immutable
final class TextColors {
  const TextColors({
    this.primary = _white,
    this.secondary = _pureSilver,
    this.tertiary = _white80,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
}

@immutable
final class NavigationMenuColors {
  const NavigationMenuColors({
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

@immutable
final class TabBarColors {
  const TabBarColors({
    this.selectedFocused = _limeGreen80,
    this.selectedUnfocused = _limeGreen50,
    this.unselected = _royalWhite50,
  });

  final Color selectedFocused;
  final Color selectedUnfocused;
  final Color unselected;
}

@immutable
final class Gradients {
  const Gradients({
    this.selection = const LinearGradient(colors: [_limeGreen, _limeGreen60]),
    this.transparent = const LinearGradient(
      colors: [_transparent, _transparent],
    ),
    this.wallpaperScrim = const RadialGradient(
      radius: 1,
      center: Alignment.topRight,
      colors: [_elegantBlack10, _elegantBlack],
      stops: [0.0, 0.8],
      transform: EllipticalGradientTransform(
        relativeCenter: Offset(1, 1),
        scale: Scale(widthFactor: 1.2, heightFactor: 1),
      ),
    ),
  });

  final Gradient selection;
  final Gradient transparent;
  final Gradient wallpaperScrim;
}
