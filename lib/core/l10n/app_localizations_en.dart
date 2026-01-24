// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
}
