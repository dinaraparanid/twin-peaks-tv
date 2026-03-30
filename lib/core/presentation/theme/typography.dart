import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/responsive_scale/responsive_extensions.dart';
import 'package:twin_peaks_tv/core/domain/settings/entity/entity.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';

@immutable
final class AppTypography {
  AppTypography({required TextScale scale}) {
    final fontFamily = switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => 'Roboto',
      AppPlatforms.tvos => 'SF Pro',
      AppPlatforms.tizen => 'Inter',
      AppPlatforms.webos => 'MuseoSans',
    };

    splash = SplashTypography._(fontFamily: fontFamily, scale: scale);
    navigationMenu = NavigationMenuTypography._(
      fontFamily: fontFamily,
      scale: scale,
    );
    tabBar = TabBarTypography._(fontFamily: fontFamily, scale: scale);
    movieInfo = MovieInfoTypography._(fontFamily: fontFamily, scale: scale);
    actor = ActorTypography._(fontFamily: fontFamily, scale: scale);
    episode = EpisodeTypography._(fontFamily: fontFamily, scale: scale);
    player = PlayerTypography._(fontFamily: fontFamily, scale: scale);
    settings = SettingsTypography._(fontFamily: fontFamily, scale: scale);
  }

  late final SplashTypography splash;
  late final NavigationMenuTypography navigationMenu;
  late final TabBarTypography tabBar;
  late final MovieInfoTypography movieInfo;
  late final ActorTypography actor;
  late final EpisodeTypography episode;
  late final PlayerTypography player;
  late final SettingsTypography settings;
}

@immutable
final class SplashTypography {
  SplashTypography._({required String fontFamily, required TextScale scale}) {
    splashHeader = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 48.fz + scale.value,
      letterSpacing: 4.fz,
    );

    splashSubText = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24.fz + scale.value,
      letterSpacing: 2.fz,
    );
  }

  late final TextStyle splashHeader;
  late final TextStyle splashSubText;
}

@immutable
final class NavigationMenuTypography {
  NavigationMenuTypography._({
    required String fontFamily,
    required TextScale scale,
  }) {
    item = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24.fz + scale.value,
    );

    footer = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18.fz + scale.value,
    );

    floatingHeader = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontSize: 18.fz + scale.value,
    );
  }

  late final TextStyle item;
  late final TextStyle footer;
  late final TextStyle floatingHeader;
}

@immutable
final class TabBarTypography {
  TabBarTypography._({required String fontFamily, required TextScale scale}) {
    primary = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 20.fz + scale.value,
    );
  }

  late final TextStyle primary;
}

@immutable
final class MovieInfoTypography {
  MovieInfoTypography._({
    required String fontFamily,
    required TextScale scale,
  }) {
    title = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 36.fz + scale.value,
    );

    properties = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 16.fz + scale.value,
    );

    description = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 20.fz + scale.value,
    );

    playButton = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18.fz + scale.value,
    );

    label = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24.fz + scale.value,
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
  ActorTypography._({required String fontFamily, required TextScale scale}) {
    name = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 16.fz + scale.value,
      height: 1,
    );

    character = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 12.fz + scale.value,
    );
  }

  late final TextStyle name;
  late final TextStyle character;
}

@immutable
final class EpisodeTypography {
  EpisodeTypography._({required String fontFamily, required TextScale scale}) {
    title = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24.fz + scale.value,
    );

    rating = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18.fz + scale.value,
    );

    description = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18.fz + scale.value,
    );
  }

  late final TextStyle title;
  late final TextStyle rating;
  late final TextStyle description;
}

@immutable
final class PlayerTypography {
  PlayerTypography._({required String fontFamily, required TextScale scale}) {
    videoTitle = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24.fz + scale.value,
    );

    timestamp = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18.fz + scale.value,
    );

    label = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24.fz + scale.value,
    );

    episode = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 20.fz + scale.value,
    );
  }

  late final TextStyle videoTitle;
  late final TextStyle timestamp;
  late final TextStyle label;
  late final TextStyle episode;
}

@immutable
final class SettingsTypography {
  SettingsTypography._({required String fontFamily, required TextScale scale}) {
    label = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 24.fz + scale.value,
    );

    property = TextStyle(
      fontFamily: fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18.fz + scale.value,
    );
  }

  late final TextStyle label;
  late final TextStyle property;
}
