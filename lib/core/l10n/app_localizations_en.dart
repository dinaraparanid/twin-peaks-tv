// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get general_more => 'More';

  @override
  String get general_less => 'Less';

  @override
  String get splash_header => 'TWIN PEAKS TV';

  @override
  String get splash_subtext => 'Developed with Flutter';

  @override
  String get main_menu_home => 'Home';

  @override
  String get main_menu_encyclopedia => 'Encyclopedia';

  @override
  String get main_menu_settings => 'Settings';

  @override
  String main_app_version(String appVersion) {
    return 'Version $appVersion';
  }

  @override
  String get home_tab_season1 => 'Season 1';

  @override
  String get home_tab_season2 => 'Season 2';

  @override
  String get home_tab_movie => 'Fire Walk With Me';

  @override
  String get home_tab_season3 => 'Season 3';

  @override
  String season_year_episodes_rating(int year, int episodesNum) {
    return '$year • $episodesNum episodes • ';
  }

  @override
  String movie_year_duration_rating(int year, String duration) {
    return '$year • $duration • ';
  }

  @override
  String get movie_cast => 'Cast';

  @override
  String get movie_watch => 'Watch';

  @override
  String get movie_scenes_from_movie => 'Scenes from the movie';

  @override
  String get player_watch_next => 'Watch next';

  @override
  String settings_app_version_info(Object version) {
    return 'Version $version';
  }

  @override
  String get settings_developer => 'Flutter TV app by Paranid5';

  @override
  String get settings_ui_settings_label => 'UI Settings';

  @override
  String get settings_ui_settings_lang => 'Language';

  @override
  String get settings_ui_settings_text_scaling => 'Text scaling';

  @override
  String get settings_playback_label => 'Playback';

  @override
  String get settings_playback_switch_to_next_episode =>
      'Automatically switch to next episode';

  @override
  String get settings_playback_show_remaining_time => 'Show the remaining time';

  @override
  String get settings_faq => 'FAQ';
}
