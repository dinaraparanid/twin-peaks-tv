// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get general_more => 'Развернуть';

  @override
  String get general_less => 'Скрыть';

  @override
  String get splash_header => 'TWIN PEAKS TV';

  @override
  String get splash_subtext => 'Developed with Flutter';

  @override
  String get main_menu_home => 'Домой';

  @override
  String get main_menu_encyclopedia => 'Энциклопедия';

  @override
  String get main_menu_settings => 'Настройки';

  @override
  String main_app_version(String appVersion) {
    return 'Версия $appVersion';
  }

  @override
  String get home_tab_season1 => 'Сезон 1';

  @override
  String get home_tab_season2 => 'Сезон 2';

  @override
  String get home_tab_movie => 'Твин Пикс: Сквозь огонь';

  @override
  String get home_tab_season3 => 'Сезон 3';

  @override
  String season_year_episodes_rating(int year, int episodesNum) {
    return '$year • $episodesNum серий • ';
  }

  @override
  String movie_year_duration_rating(int year, String duration) {
    return '$year • $duration • ';
  }

  @override
  String get movie_cast => 'В ролях';

  @override
  String get movie_watch => 'Смотреть';

  @override
  String get movie_scenes_from_movie => 'Сцены из фильма';

  @override
  String get player_watch_next => 'Смотреть далее';

  @override
  String settings_app_version_info(Object version) {
    return 'Версия $version';
  }

  @override
  String get settings_developer => 'Flutter TV-приложение от Paranid5';

  @override
  String get settings_ui_settings_label => 'Настройки интерфейса';

  @override
  String get settings_ui_settings_lang => 'Язык';

  @override
  String get settings_ui_settings_lang_system => 'Системный';

  @override
  String get settings_ui_settings_text_scaling => 'Масштаб текста';

  @override
  String get settings_ui_settings_text_scaling_small => 'Маленький';

  @override
  String get settings_ui_settings_text_scaling_normal => 'Обычный';

  @override
  String get settings_ui_settings_text_scaling_big => 'Большой';

  @override
  String get settings_playback_label => 'Воспроизведение';

  @override
  String get settings_playback_switch_to_next_episode =>
      'Автоматически переключать на следующий эпизод';

  @override
  String get settings_playback_show_remaining_time =>
      'Показывать оставшееся время';

  @override
  String get settings_faq => 'FAQ';
}
