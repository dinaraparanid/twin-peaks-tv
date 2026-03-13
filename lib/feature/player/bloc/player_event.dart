import 'package:flutter/foundation.dart';
import 'package:twin_peaks_tv/feature/player/bloc/controls_visibility.dart';

@immutable
sealed class PlayerEvent {
  const PlayerEvent();
}

final class PlayPauseEvent extends PlayerEvent {
  const PlayPauseEvent();
}

final class ChangeControlsVisibilityEvent extends PlayerEvent {
  const ChangeControlsVisibilityEvent({required this.visibility});
  final ControlsVisibility visibility;
}
