import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/core/domain/settings/settings.dart';
import 'package:twin_peaks_tv/platform/audio_output/audio_output_device.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    String? appVersion,
    String? os,
    SettingsProperties? properties,
    AudioOutputDevice? audioOutputDevice,
  }) = _SettingsState;
}

@freezed
abstract class SettingsProperties with _$SettingsProperties {
  const factory SettingsProperties({
    AppLanguage? language,
    TextScale? textScale,
    bool? switchToNextEpisode,
    bool? showRemainingTime,
  }) = _SettingsProperties;
}
