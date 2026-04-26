import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/domain/settings/settings.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';

@singleton
final class FetchAppLangUseCase {
  const FetchAppLangUseCase(this._settingsRepository);
  final SettingsRepository _settingsRepository;

  Future<void> call({
    required FutureOr<void> Function(AppLanguage? lang) onSuccess,
    required FutureOr<void> Function() onFailure,
  }) async {
    try {
      final lang = await _settingsRepository.appLanguage;
      await onSuccess(lang);
    } catch (e) {
      AppLogger.instance.e(e);
      await onFailure();
    }
  }
}
