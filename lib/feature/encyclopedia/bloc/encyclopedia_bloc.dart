import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/bloc/encyclopedia_event.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/bloc/encyclopedia_state.dart';

final class EncyclopediaBloc
    extends Bloc<EncyclopediaEvent, EncyclopediaState> {
  EncyclopediaBloc({
    required BrowseCharactersUseCase browseCharactersUseCase,
    required ClearRecentCharactersUseCase clearRecentCharactersUseCase,
    required RecentCharactersUseCase recentCharactersUseCase,
  }) : _browseCharactersUseCase = browseCharactersUseCase,
       _clearRecentCharactersUseCase = clearRecentCharactersUseCase,
       _recentCharactersUseCase = recentCharactersUseCase,
       super(const EncyclopediaState()) {
    on<QueryChangeEvent>(_onQueryChange);
    on<StartSearchEvent>(_onStartSearch);
    on<ClearRecentsEvent>(_onClearRecents);
    on<CharacterClickEvent>(_onCharacterClick);

    _browseChangesSubscription = browseCharactersUseCase.charactersChanges
        .listen((charactersResult) {
          add(
            UpdateBrowsedCharactersEvent(
              state: charactersResult.fold(
                UiState.error,
                (characters) => UiState.data(value: characters),
              ),
            ),
          );
        });

    _recentChangesSubscription = recentCharactersUseCase.changes.listen((
      characters,
    ) {
      add(UpdateRecentCharactersEvent(state: UiState.data(value: characters)));
    });
  }

  final BrowseCharactersUseCase _browseCharactersUseCase;
  final ClearRecentCharactersUseCase _clearRecentCharactersUseCase;
  final RecentCharactersUseCase _recentCharactersUseCase;

  late final StreamSubscription<Either<Exception, List<Character>>>
  _browseChangesSubscription;
  late final StreamSubscription<List<Character>> _recentChangesSubscription;

  void _onQueryChange(QueryChangeEvent event, Emitter<EncyclopediaState> emit) {
    emit(state.copyWith(searchQuery: event.query));
    _browseCharactersUseCase.submitQuery(event.query);
  }

  void _onStartSearch(StartSearchEvent event, Emitter<EncyclopediaState> emit) {
    emit(state.copyWith(isSearching: true));
  }

  Future<void> _onClearRecents(
    ClearRecentsEvent event,
    Emitter<EncyclopediaState> emit,
  ) async {
    await _clearRecentCharactersUseCase();
  }

  void _onCharacterClick(
    CharacterClickEvent event,
    Emitter<EncyclopediaState> emit,
  ) {
    // TODO(paranid5): показать экран или попап
    _recentCharactersUseCase.markAsRecent(event.character);
  }

  @override
  Future<void> close() async {
    await _browseChangesSubscription.cancel();
    await _recentChangesSubscription.cancel();
    return super.close();
  }
}
