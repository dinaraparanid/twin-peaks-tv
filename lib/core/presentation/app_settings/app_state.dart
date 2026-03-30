import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/core/domain/settings/entity/entity.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({AppLanguage? language, TextScale? textScale}) =
      _AppState;
}
