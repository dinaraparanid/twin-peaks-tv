import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';

part 'season_state.freezed.dart';

@freezed
abstract class SeasonState with _$SeasonState {
  const factory SeasonState({
    required Seasons season,
    @Default(UiState.initial()) UiState<Season> seasonState,
    @Default(false) bool isDescriptionExpanded,
  }) = _SeasonState;
}
