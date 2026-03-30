import 'package:twin_peaks_tv/core/domain/settings/entity/entity.dart';

abstract class SettingsRepository {
  const SettingsRepository();

  Stream<AppLanguage?> get appLanguageChanges;
  Future<void> setAppLanguage(AppLanguage language);

  Stream<TextScale> get textScaleChanges;
  Future<void> setTextScale(TextScale scale);

  Stream<bool> get automaticallySwitchEpisode;
  Future<void> setAutomaticallySwitchEpisode(bool isAutomaticallySwitchEpisode);

  Stream<bool> get showRemainingTimeChanges;
  Future<void> setShowRemainingTime(bool showRemainingTime);
}
