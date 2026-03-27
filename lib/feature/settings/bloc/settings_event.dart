import 'package:twin_peaks_tv/core/domain/settings/entity/entity.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/settings_state.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

final class UpdateAppVersionEvent extends SettingsEvent {
  const UpdateAppVersionEvent({required this.appVersion});
  final String appVersion;
}

final class UpdateOsEvent extends SettingsEvent {
  const UpdateOsEvent({required this.os});
  final String os;
}

final class UpdateLanguageEvent extends SettingsEvent {
  const UpdateLanguageEvent({required this.language});
  final AppLanguage language;
}

final class UpdateTextScaleEvent extends SettingsEvent {
  const UpdateTextScaleEvent({required this.textScale});
  final TextScale textScale;
}

final class UpdateSwitchToNextEpisodeEvent extends SettingsEvent {
  const UpdateSwitchToNextEpisodeEvent({required this.switchToNextEpisode});
  final bool switchToNextEpisode;
}

final class UpdateShowRemainingTimeEvent extends SettingsEvent {
  const UpdateShowRemainingTimeEvent({required this.showRemainingTime});
  final bool showRemainingTime;
}

final class UpdatePropertiesEvent extends SettingsEvent {
  const UpdatePropertiesEvent({required this.properties});
  final SettingsProperties properties;
}

final class OpenDeveloperEvent extends SettingsEvent {
  const OpenDeveloperEvent();
}

final class OpenFAQEvent extends SettingsEvent {
  const OpenFAQEvent();
}

final class RequestFocusOnDeveloperEvent extends SettingsEvent {
  const RequestFocusOnDeveloperEvent();
}

final class RequestFocusOnLanguageEvent extends SettingsEvent {
  const RequestFocusOnLanguageEvent();
}

final class RequestFocusOnTextScaleEvent extends SettingsEvent {
  const RequestFocusOnTextScaleEvent();
}

final class RequestFocusOnSwitchToNextEpisodeEvent extends SettingsEvent {
  const RequestFocusOnSwitchToNextEpisodeEvent();
}

final class RequestFocusOnShowRemainingTimeEvent extends SettingsEvent {
  const RequestFocusOnShowRemainingTimeEvent();
}

final class RequestFocusOnFAQEvent extends SettingsEvent {
  const RequestFocusOnFAQEvent();
}
