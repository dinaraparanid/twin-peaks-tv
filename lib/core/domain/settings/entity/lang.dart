import 'dart:ui';

enum AppLanguage {
  en,
  ru;

  factory AppLanguage.fromLocalized(String value) =>
      AppLanguage.values.firstWhere((l) => l.localized() == value);

  Locale toLocale() => switch (this) {
    AppLanguage.en => const Locale('en'),
    AppLanguage.ru => const Locale('ru'),
  };
}

extension AppLanguageExt on AppLanguage {
  String localized() => switch (this) {
    AppLanguage.en => 'English',
    AppLanguage.ru => 'Русский',
  };
}
