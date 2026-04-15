import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';

part 'encyclopedia_state.freezed.dart';

@freezed
abstract class EncyclopediaState with _$EncyclopediaState {
  const factory EncyclopediaState({
    @Default('') String searchQuery,
    @Default(false) bool isSearching,
    @Default(UiState.initial()) UiState<List<Character>> recentCharacters,
    @Default(UiState.initial()) UiState<List<Character>> browseCharacters,
  }) = _EncyclopediaState;
}

extension Properties on EncyclopediaState {
  bool get isRecentsVisible {
    return !isSearching && recentCharacters.getOrNull?.isNotEmpty == true;
  }
}
