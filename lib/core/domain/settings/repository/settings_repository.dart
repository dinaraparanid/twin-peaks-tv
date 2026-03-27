import 'package:twin_peaks_tv/core/domain/settings/entity/entity.dart';

abstract class SettingsRepository {
  const SettingsRepository();

  Stream<AppLanguage?> get appLanguage;
  Future<void> setAppLanguage(AppLanguage language);

  Stream<TextScale> get textScale;
  Future<void> setTextScale(TextScale scale);

  Stream<bool> get automaticallySwitchEpisode;
  Future<void> setAutomaticallySwitchEpisode(bool isAutomaticallySwitchEpisode);

  Stream<bool> get showRemainingTime;
  Future<void> setShowRemainingTime(bool showRemainingTime);
}
