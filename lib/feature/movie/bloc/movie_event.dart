import 'package:flutter/foundation.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';

@immutable
sealed class MovieEvent {
  const MovieEvent();
}

final class UpdateMovieState extends MovieEvent {
  const UpdateMovieState({required this.state});
  final UiState<Movie> state;
}

final class SwitchDescriptionExpanded extends MovieEvent {
  const SwitchDescriptionExpanded();
}

final class CollapseDescription extends MovieEvent {
  const CollapseDescription();
}

final class RequestFocusOnDescription extends MovieEvent {
  const RequestFocusOnDescription();
}

final class RequestFocusOnPlayButton extends MovieEvent {
  const RequestFocusOnPlayButton();
}

final class RequestFocusOnCast extends MovieEvent {
  const RequestFocusOnCast();
}

final class RequestFocusOnScenes extends MovieEvent {
  const RequestFocusOnScenes();
}
