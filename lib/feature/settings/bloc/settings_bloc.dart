import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twin_peaks_tv/core/domain/open_url_use_case.dart';
import 'package:twin_peaks_tv/core/domain/settings/settings.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/settings_effect.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/settings_event.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/settings_state.dart';
import 'package:twin_peaks_tv/feature/settings/domain/use_case/use_case.dart';

final class SettingsBloc extends Bloc<SettingsEvent, SettingsState>
    with BlocPresentationMixin<SettingsState, SettingsEffect> {
  SettingsBloc({
    required SettingsRepository repository,
    required OpenUrlUseCase openUrlUseCase,
    required FetchAppVersionUseCase fetchAppVersionUseCase,
    required FetchOSUseCase fetchOSUseCase,
  }) : _repository = repository,
       _openUrlUseCase = openUrlUseCase,
       _fetchAppVersionUseCase = fetchAppVersionUseCase,
       _fetchOSUseCase = fetchOSUseCase,
       super(const SettingsState()) {
    on<UpdateAppVersionEvent>(_onUpdateAppVersion);
    on<UpdateOsEvent>(_onUpdateOS);
    on<UpdateLanguageEvent>(_onUpdateLanguage);
    on<UpdateTextScaleEvent>(_onUpdateTextScale);
    on<UpdateSwitchToNextEpisodeEvent>(_onUpdateSwitchToNextEpisode);
    on<UpdateShowRemainingTimeEvent>(_onShowRemainingTime);
    on<UpdatePropertiesEvent>(_onUpdateProperties);
    on<OpenDeveloperEvent>(_onOpenDeveloper);
    on<OpenFAQEvent>(_onOpenFAQ);
    on<RequestFocusOnDeveloperEvent>(_onRequestFocusOnDeveloper);
    on<RequestFocusOnLanguageEvent>(_onRequestFocusOnLanguage);
    on<RequestFocusOnTextScaleEvent>(_onRequestFocusOnTextScale);
    on<RequestFocusOnSwitchToNextEpisodeEvent>(
      _onRequestFocusOnSwitchToNextEpisode,
    );
    on<RequestFocusOnShowRemainingTimeEvent>(
      _onRequestFocusOnShowRemainingTime,
    );
    on<RequestFocusOnFAQEvent>(_onRequestFocusOnFAQ);

    _propsSub = CombineLatestStream.combine4(
      _repository.appLanguageChanges,
      _repository.textScaleChanges,
      _repository.automaticallySwitchEpisode,
      _repository.showRemainingTimeChanges,
      (lang, scale, switchToNextEpisode, showRemainingTime) {
        return SettingsProperties(
          language: lang,
          textScale: scale,
          switchToNextEpisode: switchToNextEpisode,
          showRemainingTime: showRemainingTime,
        );
      },
    ).listen((state) => add(UpdatePropertiesEvent(properties: state)));

    _fetchAppVersionUseCase(
      onSuccess: (version) => add(UpdateAppVersionEvent(appVersion: version)),
      onFailure: doNothing,
    );

    _fetchOSUseCase(
      onSuccess: (os) => add(UpdateOsEvent(os: os)),
      onFailure: () {
        add(UpdateOsEvent(os: AppPlatform.realPlatform.toString()));
      },
    );
  }

  final SettingsRepository _repository;
  final OpenUrlUseCase _openUrlUseCase;
  final FetchAppVersionUseCase _fetchAppVersionUseCase;
  final FetchOSUseCase _fetchOSUseCase;

  late final StreamSubscription<SettingsProperties> _propsSub;

  late final developerNode = FocusNode();
  late final languageNode = FocusNode();
  late final textScaleNode = FocusNode();
  late final switchToNextEpisodeNode = FocusNode();
  late final showRemainingTimeNode = FocusNode();
  late final faqNode = FocusNode();

  Future<void> _onUpdateAppVersion(
    UpdateAppVersionEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(appVersion: event.appVersion));
  }

  Future<void> _onUpdateOS(
    UpdateOsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(os: event.os));
  }

  Future<void> _onUpdateLanguage(
    UpdateLanguageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setAppLanguage(event.language);
  }

  Future<void> _onUpdateTextScale(
    UpdateTextScaleEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setTextScale(event.textScale);
  }

  Future<void> _onUpdateSwitchToNextEpisode(
    UpdateSwitchToNextEpisodeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setAutomaticallySwitchEpisode(event.switchToNextEpisode);
  }

  Future<void> _onShowRemainingTime(
    UpdateShowRemainingTimeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setShowRemainingTime(event.showRemainingTime);
  }

  Future<void> _onUpdateProperties(
    UpdatePropertiesEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(properties: event.properties));
  }

  Future<void> _onOpenDeveloper(
    OpenDeveloperEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _openUrlUseCase(
      url: 'https://github.com/dinaraparanid/twin-peaks-tv',
      onFailure: () => emitPresentation(const ShowOpenUrlErrorEffect()),
    );
  }

  Future<void> _onOpenFAQ(
    OpenFAQEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _openUrlUseCase(
      url: 'https://github.com/dinaraparanid/twin-peaks-tv',
      onFailure: () => emitPresentation(const ShowOpenUrlErrorEffect()),
    );
  }

  Future<void> _onRequestFocusOnDeveloper(
    RequestFocusOnDeveloperEvent event,
    Emitter<SettingsState> emit,
  ) async {
    developerNode.requestFocus();
  }

  Future<void> _onRequestFocusOnLanguage(
    RequestFocusOnLanguageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    languageNode.requestFocus();
  }

  Future<void> _onRequestFocusOnTextScale(
    RequestFocusOnTextScaleEvent event,
    Emitter<SettingsState> emit,
  ) async {
    textScaleNode.requestFocus();
  }

  Future<void> _onRequestFocusOnSwitchToNextEpisode(
    RequestFocusOnSwitchToNextEpisodeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    switchToNextEpisodeNode.requestFocus();
  }

  Future<void> _onRequestFocusOnShowRemainingTime(
    RequestFocusOnShowRemainingTimeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    showRemainingTimeNode.requestFocus();
  }

  Future<void> _onRequestFocusOnFAQ(
    RequestFocusOnFAQEvent event,
    Emitter<SettingsState> emit,
  ) async {
    faqNode.requestFocus();
  }

  @override
  Future<void> close() async {
    await _propsSub.cancel();
    developerNode.dispose();
    languageNode.dispose();
    textScaleNode.dispose();
    switchToNextEpisodeNode.dispose();
    showRemainingTimeNode.dispose();
    return super.close();
  }
}

extension SettingsBlocProvider on BuildContext {
  SettingsBloc get settingsBloc => BlocProvider.of<SettingsBloc>(this);
}
