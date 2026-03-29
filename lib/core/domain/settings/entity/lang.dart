enum AppLanguage {
  en,
  ru;

  factory AppLanguage.fromLocalized(String value) =>
      AppLanguage.values.firstWhere((l) => l.localized() == value);
}

extension AppLanguageExt on AppLanguage {
  String localized() => switch (this) {
    AppLanguage.en => 'English',
    AppLanguage.ru => 'Русский',
  };
}
