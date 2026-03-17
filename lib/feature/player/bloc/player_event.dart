import 'package:flutter/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/feature/player/bloc/controls_visibility.dart';

@immutable
sealed class PlayerEvent {
  const PlayerEvent();
}

final class UpdatePlayerStateEvent extends PlayerEvent {
  const UpdatePlayerStateEvent({required this.state});
  final UiState<void> state;
}

final class PlayPauseEvent extends PlayerEvent {
  const PlayPauseEvent();
}

final class ChangeControlsVisibilityEvent extends PlayerEvent {
  const ChangeControlsVisibilityEvent({required this.visibility});
  final ControlsVisibility visibility;
}

final class SelectEpisodeEvent extends PlayerEvent {
  const SelectEpisodeEvent({required this.index});
  final int index;
}

final class SeekPositionsEvent extends PlayerEvent {
  const SeekPositionsEvent({required this.position, required this.duration});
  final Duration position;
  final Duration duration;
}

final class UpdatePositionEvent extends PlayerEvent {
  const UpdatePositionEvent({required this.position});
  final Duration position;
}

final class StartPositionDragEvent extends PlayerEvent {
  const StartPositionDragEvent();
}

final class SetPositionEvent extends PlayerEvent {
  const SetPositionEvent({required this.position});
  final Duration position;
}

final class UpdatePositionFocusEvent extends PlayerEvent {
  const UpdatePositionFocusEvent({required this.isFocused});
  final bool isFocused;
}

final class SeekVolumeEvent extends PlayerEvent {
  const SeekVolumeEvent({required this.volume});
  final double volume;
}

final class UpdateVolumeEvent extends PlayerEvent {
  const UpdateVolumeEvent({required this.volume});
  final double volume;
}

final class StartVolumeDragEvent extends PlayerEvent {
  const StartVolumeDragEvent();
}

final class SetVolumeEvent extends PlayerEvent {
  const SetVolumeEvent({required this.volume});
  final double volume;
}

final class UpdateVolumeFocusEvent extends PlayerEvent {
  const UpdateVolumeFocusEvent({required this.isFocused});
  final bool isFocused;
}

final class SeekSpeedEvent extends PlayerEvent {
  const SeekSpeedEvent({required this.speed});
  final double speed;
}

final class UpdateSpeedEvent extends PlayerEvent {
  const UpdateSpeedEvent({required this.speed});
  final double speed;
}

final class StartSpeedDragEvent extends PlayerEvent {
  const StartSpeedDragEvent();
}

final class SetSpeedEvent extends PlayerEvent {
  const SetSpeedEvent({required this.speed});
  final double speed;
}

final class UpdateSpeedFocusEvent extends PlayerEvent {
  const UpdateSpeedFocusEvent({required this.isFocused});
  final bool isFocused;
}

final class RequestFocusOnControlsMenuEvent extends PlayerEvent {
  const RequestFocusOnControlsMenuEvent();
}

final class RequestFocusOnVolumeEvent extends PlayerEvent {
  const RequestFocusOnVolumeEvent();
}

final class RequestFocusOnSpeedEvent extends PlayerEvent {
  const RequestFocusOnSpeedEvent();
}

final class RequestFocusOnPositionEvent extends PlayerEvent {
  const RequestFocusOnPositionEvent();
}
