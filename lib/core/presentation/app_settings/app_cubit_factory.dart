import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/domain/settings/settings.dart';
import 'package:twin_peaks_tv/core/presentation/app_settings/app_cubit.dart';

@singleton
final class AppCubitFactory {
  AppCubitFactory({required SettingsRepository repository})
    : _repository = repository;

  final SettingsRepository _repository;

  AppCubit call() => AppCubit(repository: _repository);
}
