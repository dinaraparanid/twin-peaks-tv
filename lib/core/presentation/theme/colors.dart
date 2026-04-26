import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';

const _limeGreen = Color(0xFF39C43C);
const _limeGreen01 = Color(0x0339C43C);
const _limeGreen10 = Color(0x1A39C43C);
const _limeGreen50 = Color(0x8039C43C);
const _limeGreen60 = Color(0x9939C43C);
const _limeGreen80 = Color(0xCC39C43C);
const _intenseCocoa = Color(0xFF593C39);
const _white = Color(0xFFFFFFFF);
const _white7 = Color(0x12FFFFFF);
const _white20 = Color(0x33FFFFFF);
const _white50 = Color(0x80FFFFFF);
const _white80 = Color(0xCCFFFFFF);
const _pureSilver = Color(0xFFC4C7C5);
const _pureSilver10 = Color(0x1AC4C7C5);
const _pearlBlack = Color(0xFF303030);
const _gray50 = Color(0x80808080);
const _elegantBlack = Color(0xFF131313);
const _elegantBlack90 = Color(0xE6131313);
const _elegantBlack80 = Color(0xCC131313);
const _elegantBlack60 = Color(0x99131313);
const _elegantBlack30 = Color(0x4D131313);
const _elegantBlack01 = Color(0x03131313);
const _royalWhite50 = Color(0x80FEFFFE);
const _blackout = Color(0xFF1E1E1E);
const _transparent = Color(0x00000000);
const _royalWhite = Color(0xFFFFFDFD);
const _black50 = Color(0x80000000);
const _funkyGray20 = Color(0x33787878);
const _funkyGray40 = Color(0x66787878);
const _kawaiiSilver20 = Color(0x33DEDEDE);
const _kawaiiSilver40 = Color(0x66DEDEDE);
const _powerGray50 = Color(0x80727272);

@immutable
final class AppColors {
  const AppColors({
    this.primary = const PrimaryColors(),
    this.background = const BackgroundColors(),
    this.splash = const SplashColors(),
    this.text = const TextColors(),
    this.navigationMenu = const NavigationMenuColors(),
    this.tabBar = const TabBarColors(),
    this.carousel = const CarouselColors(),
    this.button = const ButtonColors(),
    this.slider = const SliderColors(),
    this.searchBar = const SearchBarColors(),
    this.settings = const SettingsColors(),
    this.encyclopedia = const EncyclopediaColors(),
    this.cupertino = const AppCupertinoColors(),
    this.gradients = const Gradients(),
    this.transparent = _transparent,
  });

  final PrimaryColors primary;
  final BackgroundColors background;
  final SplashColors splash;
  final TextColors text;
  final NavigationMenuColors navigationMenu;
  final TabBarColors tabBar;
  final CarouselColors carousel;
  final ButtonColors button;
  final SliderColors slider;
  final SearchBarColors searchBar;
  final SettingsColors settings;
  final EncyclopediaColors encyclopedia;
  final AppCupertinoColors cupertino;
  final Gradients gradients;
  final Color transparent;
}

@immutable
final class PrimaryColors {
  const PrimaryColors({
    this.primary = _limeGreen,
    this.primary01 = _limeGreen01,
    this.primary10 = _limeGreen10,
    this.primary50 = _limeGreen50,
    this.primary60 = _limeGreen60,
    this.primary80 = _limeGreen80,
  });

  final Color primary;
  final Color primary01;
  final Color primary10;
  final Color primary50;
  final Color primary60;
  final Color primary80;
}

@immutable
final class BackgroundColors {
  const BackgroundColors({
    this.primary = _elegantBlack,
    this.primary80 = _elegantBlack80,
    this.primary60 = _elegantBlack60,
    this.primary30 = _elegantBlack30,
    this.primary01 = _elegantBlack01,
    this.secondary = _blackout,
  });

  final Color primary;
  final Color primary80;
  final Color primary60;
  final Color primary30;
  final Color primary01;
  final Color secondary;
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
    this.iconBackground = _white7,
    this.iconBackgroundSelected = _royalWhite,
  });

  final Color itemContent;
  final Color itemContentSelected;
  final Color itemFocused;
  final Color itemSelectedUnfocused;
  final Color itemSelectedFocused;
  final Color iconBackground;
  final Color iconBackgroundSelected;
}

@immutable
final class TabBarColors {
  const TabBarColors({
    this.selectedFocused = _limeGreen80,
    this.selectedContrast = _white,
    this.selectedUnfocused = _limeGreen50,
    this.unselected = _royalWhite50,
  });

  final Color selectedFocused;
  final Color selectedContrast;
  final Color selectedUnfocused;
  final Color unselected;
}

@immutable
final class CarouselColors {
  const CarouselColors({
    this.content = _white20,
    this.selectedContent = _white50,
    this.focusedContent = _white,
    this.background = _elegantBlack60,
  });

  final Color content;
  final Color selectedContent;
  final Color focusedContent;
  final Color background;
}

@immutable
final class ButtonColors {
  const ButtonColors({this.filled = const FilledButtonColors()});

  final FilledButtonColors filled;
}

@immutable
final class FilledButtonColors {
  const FilledButtonColors({
    this.container = _gray50,
    this.focusedContainer = _limeGreen80,
    this.content = _pureSilver,
    this.focusedContent = _pearlBlack,
  });

  final Color container;
  final Color focusedContainer;
  final Color content;
  final Color focusedContent;
}

@immutable
final class SliderColors {
  const SliderColors({
    this.active = _limeGreen60,
    this.inactive = _pureSilver10,
  });

  final Color active;
  final Color inactive;
}

@immutable
final class SearchBarColors {
  const SearchBarColors({
    this.input = _white,
    this.placeholder = _pureSilver,
    this.background = _funkyGray20,
  });

  final Color input;
  final Color placeholder;
  final Color background;
}

@immutable
final class SettingsColors {
  const SettingsColors({
    this.block = _funkyGray20,
    this.divider = _powerGray50,
  });

  final Color block;
  final Color divider;
}

@immutable
final class EncyclopediaColors {
  const EncyclopediaColors({
    this.browseUnfocused = const LinearGradient(
      colors: [_funkyGray20, _kawaiiSilver20],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    ),
    this.browseFocused = const LinearGradient(
      colors: [_funkyGray40, _kawaiiSilver40],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    ),
    this.recentFocused = _funkyGray20,
  });

  final Gradient browseUnfocused;
  final Gradient browseFocused;
  final Color recentFocused;
}

@immutable
final class AppCupertinoColors {
  const AppCupertinoColors({
    this.background = _black50,
    this.collapsedHeaderContent = _white80,
    this.glassBorder = _white20,
  });

  final Color background;
  final Color collapsedHeaderContent;
  final Color glassBorder;
}

@immutable
final class Gradients {
  const Gradients({
    this.selection = const LinearGradient(colors: [_limeGreen, _limeGreen60]),
    this.transparent = const LinearGradient(
      colors: [_transparent, _transparent],
    ),
    this.topBarScrim = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [_elegantBlack60, _elegantBlack01],
    ),
    this.materialWallpaperScrim = const RadialGradient(
      radius: 1,
      center: Alignment.topRight,
      colors: [_elegantBlack01, _elegantBlack],
      stops: [0.0, 0.8],
      transform: EllipticalGradientTransform(
        relativeCenter: Offset(1, 1),
        scale: Scale(widthFactor: 1.2, heightFactor: 1),
      ),
    ),
    this.oneUiWallpaperScrim = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [_elegantBlack01, _elegantBlack90, _elegantBlack],
      stops: [0.0, 0.5, 1],
    ),
    this.oneUiMainMenuBorder = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        _limeGreen01,
        _limeGreen01,
        _limeGreen80,
        _limeGreen01,
        _limeGreen01,
      ],
      stops: [0.0, 0.4, 0.6, 0.8, 1],
    ),
    this.cupertinoVerticalWallpaperScrim = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [_elegantBlack01, _elegantBlack90, _elegantBlack],
    ),
    this.cupertinoHorizontalWallpaperScrim = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [_elegantBlack, _elegantBlack01],
    ),
    this.webOSVerticalScrim = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [_elegantBlack30, _elegantBlack01, _elegantBlack],
    ),
    this.webOSHorizontalScrim = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [_elegantBlack, _elegantBlack01, _elegantBlack],
    ),
  });

  final Gradient selection;
  final Gradient transparent;
  final Gradient topBarScrim;
  final Gradient materialWallpaperScrim;
  final Gradient oneUiWallpaperScrim;
  final Gradient oneUiMainMenuBorder;
  final Gradient cupertinoVerticalWallpaperScrim;
  final Gradient cupertinoHorizontalWallpaperScrim;
  final Gradient webOSVerticalScrim;
  final Gradient webOSHorizontalScrim;
}
