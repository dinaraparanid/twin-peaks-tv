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
    @Default(SliderState(value: Duration.zero)) SliderState<Duration> position,
    @Default(Duration.zero) Duration duration,
    @Default(SliderState(value: 1)) SliderState<double> volume,
    @Default(SliderState(value: 1)) SliderState<double> speed,
  }) = _PlayerState;
}

@freezed
abstract class SliderState<T> with _$SliderState<T> {
  const factory SliderState({
    required T value,
    @Default(false) bool isDragging,
    @Default(false) bool isFocused,
  }) = _SliderState;
}
