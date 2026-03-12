import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_entry.dart';

part 'player_state.freezed.dart';

@freezed
abstract class PlayerState with _$PlayerState {
  const factory PlayerState({required PlayerEntry entry}) = _PlayerState;
}
