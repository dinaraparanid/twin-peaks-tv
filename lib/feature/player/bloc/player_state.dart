import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/feature/player/bloc/controls_visibility.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_entry.dart';

part 'player_state.freezed.dart';

@freezed
abstract class PlayerState with _$PlayerState {
  const factory PlayerState({
    required PlayerEntry entry,
    @Default(false) bool isPlaying,
    @Default(ControlsVisibility.hidden) ControlsVisibility controlsVisibility,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration duration,
  }) = _PlayerState;
}
