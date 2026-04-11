import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:twin_peaks_tv/core/domain/settings/entity/lang.dart';
import 'package:twin_peaks_tv/core/domain/settings/entity/text_scale.dart';
import 'package:twin_peaks_tv/core/domain/settings/repository/settings_repository.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';

@Singleton(as: SettingsRepository)
final class SettingsRepositoryImpl extends SettingsRepository {
  SettingsRepositoryImpl();

  static const _keyAppLanguage = 'app_language';
  static const _keySwitchEpisode = 'switch_episode';
  static const _keyShowRemainingTime = 'show_remaining_time';
  static const _keyTextScale = 'text_scale';

  final _prefs = RxSharedPreferences(
    SharedPreferences.getInstance(),
    kReleaseMode ? null : const RxSharedPreferencesDefaultLogger(),
  );

  @override
  Stream<AppLanguage?> get appLanguageChanges => _prefs
      .getIntStream(_keyAppLanguage)
      .map((value) => value != null ? AppLanguage.values[value] : null)
      .distinct();

  @override
  Future<void> setAppLanguage(AppLanguage language) async {
    try {
      await _prefs.setInt(_keyAppLanguage, language.index);
    } catch (e) {
      AppLogger.instance.e(e);
    }
  }

  @override
  Stream<bool> get automaticallySwitchEpisode => _prefs
      .getBoolStream(_keySwitchEpisode)
      .map((value) => value ?? false)
      .distinct();

  @override
  Future<void> setAutomaticallySwitchEpisode(
    bool isAutomaticallySwitchEpisode,
  ) async {
    try {
      await _prefs.setBool(_keySwitchEpisode, isAutomaticallySwitchEpisode);
    } catch (e) {
      AppLogger.instance.e(e);
    }
  }

  @override
  Stream<bool> get showRemainingTimeChanges => _prefs
      .getBoolStream(_keyShowRemainingTime)
      .map((value) => value ?? false)
      .distinct();

  @override
  Future<void> setShowRemainingTime(bool showRemainingTime) async {
    try {
      await _prefs.setBool(_keyShowRemainingTime, showRemainingTime);
    } catch (e) {
      AppLogger.instance.e(e);
    }
  }

  @override
  Stream<TextScale> get textScaleChanges =>
      _prefs.getIntStream(_keyTextScale).map((value) {
        return value != null ? TextScale.values[value] : TextScale.normal;
      }).distinct();

  @override
  Future<void> setTextScale(TextScale scale) async {
    try {
      await _prefs.setInt(_keyTextScale, scale.index);
    } catch (e) {
      AppLogger.instance.e(e);
    }
  }
}
