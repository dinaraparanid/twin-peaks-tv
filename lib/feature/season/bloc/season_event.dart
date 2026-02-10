import 'package:flutter/foundation.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';

@immutable
sealed class SeasonEvent {
  const SeasonEvent();
}

final class UpdateSeasonState extends SeasonEvent {
  const UpdateSeasonState({required this.state});
  final UiState<Season> state;
}

final class SwitchDescriptionExpanded extends SeasonEvent {
  const SwitchDescriptionExpanded();
}

final class CollapseDescription extends SeasonEvent {
  const CollapseDescription();
}

final class RequestFocusOnDescription extends SeasonEvent {
  const RequestFocusOnDescription();
}

final class RequestFocusOnCarousel extends SeasonEvent {
  const RequestFocusOnCarousel();
}

final class RequestFocusOnCast extends SeasonEvent {
  const RequestFocusOnCast();
}

final class RequestFocusOnEpisodes extends SeasonEvent {
  const RequestFocusOnEpisodes();
}
