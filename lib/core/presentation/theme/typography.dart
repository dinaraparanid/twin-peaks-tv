import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';

@immutable
final class AppTypography {
  AppTypography({required BuildContext context}) {
    final fontFamily = switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => 'Roboto',
      AppPlatforms.tvos => 'SF Pro',
      AppPlatforms.tizen => 'Inter',
      _ => 'Inter',
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

@immutable
final class MovieInfoTypography {
  MovieInfoTypography._({required String fontFamily}) {
    title = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 28,
    );

    properties = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );

    description = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

    playButton = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );

    label = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 20,
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
      fontSize: 14,
    );

    character = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 10,
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
      fontSize: 20,
    );

    rating = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );

    description = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
  }

  late final TextStyle title;
  late final TextStyle rating;
  late final TextStyle description;
}
