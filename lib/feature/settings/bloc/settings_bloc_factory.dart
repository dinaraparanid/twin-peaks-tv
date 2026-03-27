import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/domain/open_url_use_case.dart';
import 'package:twin_peaks_tv/core/domain/settings/repository/settings_repository.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/settings_bloc.dart';
import 'package:twin_peaks_tv/feature/settings/domain/use_case/use_case.dart';

@singleton
final class SettingsBlocFactory {
  const SettingsBlocFactory(
    this._repository,
    this._openUrlUseCase,
    this._fetchAppVersionUseCase,
    this._fetchOSUseCase,
  );

  final SettingsRepository _repository;
  final OpenUrlUseCase _openUrlUseCase;
  final FetchAppVersionUseCase _fetchAppVersionUseCase;
  final FetchOSUseCase _fetchOSUseCase;

  SettingsBloc call() => SettingsBloc(
    repository: _repository,
    openUrlUseCase: _openUrlUseCase,
    fetchAppVersionUseCase: _fetchAppVersionUseCase,
    fetchOSUseCase: _fetchOSUseCase,
  );
}
