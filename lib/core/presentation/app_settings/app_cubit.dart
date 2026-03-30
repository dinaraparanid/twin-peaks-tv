import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twin_peaks_tv/core/domain/settings/settings.dart';
import 'package:twin_peaks_tv/core/presentation/app_settings/app_state.dart';

final class AppCubit extends Cubit<AppState> {
  AppCubit({required SettingsRepository repository}) : super(const AppState()) {
    _changesSub = CombineLatestStream.combine2(
      repository.appLanguageChanges,
      repository.textScaleChanges,
      (lang, scale) => AppState(language: lang, textScale: scale),
    ).listen(emit);
  }

  late final StreamSubscription<AppState> _changesSub;

  @override
  Future<void> close() async {
    await _changesSub.cancel();
    return super.close();
  }
}
