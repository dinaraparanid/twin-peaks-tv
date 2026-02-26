import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/responsive_scale/responsive_extensions.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';

@immutable
final class AppTypography {
  AppTypography() {
    final fontFamily = switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => 'Roboto',
      AppPlatforms.tvos => 'SF Pro',
      AppPlatforms.tizen => 'Inter',
      AppPlatforms.webos => 'MuseoSans',
    };

    splash = SplashTypography._(fontFamily: fontFamily);
    navigationMenu = NavigationMenuTypography._(fontFamily: fontFamily);
    tabBar = TabBarTypography._(fontFamily: fontFamily);
    movieInfo = MovieInfoTypography._(fontFamily: fontFamily);
    actor = ActorTypography._(fontFamily: fontFamily);
    episode = EpisodeTypography._(fontFamily: fontFamily);
  }

  late final SplashTypography splash;
  late final NavigationMenuTypography navigationMenu;
  late final TabBarTypography tabBar;
  late final MovieInfoTypography movieInfo;
  late final ActorTypography actor;
  late final EpisodeTypography episode;
}

@immutable
final class SplashTypography {
  SplashTypography._({required String fontFamily}) {
    splashHeader = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 48.fz,
      letterSpacing: 4.fz,
    );

    splashSubText = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24.fz,
      letterSpacing: 2.fz,
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
      fontSize: 24.fz,
    );

    footer = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18.fz,
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
      fontSize: 20.fz,
    );
  }

  late final TextStyle primary;
}

@immutable
final class MovieInfoTypography {
  MovieInfoTypography._({required String fontFamily}) {
    title = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 36.fz,
    );

    properties = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 16.fz,
    );

    description = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 20.fz,
    );

    playButton = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18.fz,
    );

    label = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24.fz,
    );
  }

  late final TextStyle title;
  late final TextStyle properties;
  late final TextStyle description;
  late final TextStyle playButton;
  late final TextStyle label;
}

@immutable
final class ActorTypography {
  ActorTypography._({required String fontFamily}) {
    name = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 16.fz,
      height: 1,
    );

    character = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 12.fz,
    );
  }

  late final TextStyle name;
  late final TextStyle character;
}

@immutable
final class EpisodeTypography {
  EpisodeTypography._({required String fontFamily}) {
    title = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24.fz,
    );

    rating = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18.fz,
    );

    description = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18.fz,
    );
  }

  late final TextStyle title;
  late final TextStyle rating;
  late final TextStyle description;
}
