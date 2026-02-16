import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';

part 'movie_state.freezed.dart';

@freezed
abstract class MovieState with _$MovieState {
  const factory MovieState({
    @Default(UiState.initial()) UiState<Movie> movieState,
    @Default(false) bool isDescriptionExpanded,
  }) = _MovieState;
}
