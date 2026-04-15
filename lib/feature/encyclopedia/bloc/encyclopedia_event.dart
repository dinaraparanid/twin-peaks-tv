import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';

sealed class EncyclopediaEvent {
  const EncyclopediaEvent();
}

final class UpdateBrowsedCharactersEvent extends EncyclopediaEvent {
  const UpdateBrowsedCharactersEvent({required this.state});
  final UiState<List<Character>> state;
}

final class UpdateRecentCharactersEvent extends EncyclopediaEvent {
  const UpdateRecentCharactersEvent({required this.state});
  final UiState<List<Character>> state;
}

final class QueryChangeEvent extends EncyclopediaEvent {
  const QueryChangeEvent({required this.query});
  final String query;
}

final class StartSearchEvent extends EncyclopediaEvent {
  const StartSearchEvent();
}

final class ClearRecentsEvent extends EncyclopediaEvent {
  const ClearRecentsEvent();
}

final class CharacterClickEvent extends EncyclopediaEvent {
  const CharacterClickEvent({required this.character});
  final Character character;
}

final class FocusOnSearchFieldEvent extends EncyclopediaEvent {
  const FocusOnSearchFieldEvent();
}

final class FocusOnClearRecentsEvent extends EncyclopediaEvent {
  const FocusOnClearRecentsEvent();
}

final class FocusOnRecentsEvent extends EncyclopediaEvent {
  const FocusOnRecentsEvent();
}

final class FocusOnBrowseEvent extends EncyclopediaEvent {
  const FocusOnBrowseEvent();
}

final class FocusUpFromBrowseEvent extends EncyclopediaEvent {
  const FocusUpFromBrowseEvent();
}

final class FocusDownFromSearchEvent extends EncyclopediaEvent {
  const FocusDownFromSearchEvent();
}
