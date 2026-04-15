import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';
import 'package:twin_peaks_tv/core/utils/ext/focus_node_ext.dart';
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
    on<UpdateBrowsedCharactersEvent>(_onUpdateBrowsedCharacters);
    on<UpdateRecentCharactersEvent>(_onUpdateRecentCharacters);
    on<QueryChangeEvent>(_onQueryChange);
    on<StartSearchEvent>(_onStartSearch);
    on<ClearRecentsEvent>(_onClearRecents);
    on<CharacterClickEvent>(_onCharacterClick);
    on<FocusOnSearchFieldEvent>(_onFocusOnSearchField);
    on<FocusOnClearRecentsEvent>(_onFocusOnClearRecents);
    on<FocusOnRecentsEvent>(_onFocusOnRecents);
    on<FocusOnBrowseEvent>(_onFocusOnBrowse);
    on<FocusUpFromBrowseEvent>(_onFocusUpFromBrowse);
    on<FocusDownFromSearchEvent>(_onFocusDownFromSearch);

    _browseChangesSubscription = browseCharactersUseCase.changes.listen((
      charactersResult,
    ) {
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

    _browseCharactersUseCase.submitQuery(null);
  }

  final BrowseCharactersUseCase _browseCharactersUseCase;
  final ClearRecentCharactersUseCase _clearRecentCharactersUseCase;
  final RecentCharactersUseCase _recentCharactersUseCase;

  late final FocusNode searchFieldNode = FocusNode();
  late final FocusNode clearRecentsNode = FocusNode();
  late final FocusScopeNode recentsScopeNode = FocusScopeNode();
  late final FocusScopeNode browseScopeNode = FocusScopeNode();

  late final StreamSubscription<Either<Exception, List<Character>>>
  _browseChangesSubscription;
  late final StreamSubscription<List<Character>> _recentChangesSubscription;

  void _onUpdateBrowsedCharacters(
    UpdateBrowsedCharactersEvent event,
    Emitter<EncyclopediaState> emit,
  ) {
    emit(state.copyWith(browseCharacters: event.state));
  }

  void _onUpdateRecentCharacters(
    UpdateRecentCharactersEvent event,
    Emitter<EncyclopediaState> emit,
  ) {
    emit(state.copyWith(recentCharacters: event.state));
  }

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

  void _onFocusOnSearchField(
    FocusOnSearchFieldEvent event,
    Emitter<EncyclopediaState> emit,
  ) {
    searchFieldNode.requestFocus();
  }

  void _onFocusOnClearRecents(
    FocusOnClearRecentsEvent event,
    Emitter<EncyclopediaState> emit,
  ) {
    clearRecentsNode.requestFocus();
  }

  void _onFocusOnRecents(
    FocusOnRecentsEvent event,
    Emitter<EncyclopediaState> emit,
  ) {
    recentsScopeNode.requestFocusOnChild();
  }

  void _onFocusOnBrowse(
    FocusOnBrowseEvent event,
    Emitter<EncyclopediaState> emit,
  ) {
    browseScopeNode.requestFocusOnChild();
  }

  void _onFocusUpFromBrowse(
    FocusUpFromBrowseEvent event,
    Emitter<EncyclopediaState> emit,
  ) {
    if (state.isRecentsVisible) {
      add(const FocusOnRecentsEvent());
      return;
    }

    add(const FocusOnSearchFieldEvent());
  }

  void _onFocusDownFromSearch(
    FocusDownFromSearchEvent event,
    Emitter<EncyclopediaState> emit,
  ) {
    if (state.isRecentsVisible) {
      add(const FocusOnClearRecentsEvent());
      return;
    }

    add(const FocusOnBrowseEvent());
  }

  @override
  Future<void> close() async {
    await _browseChangesSubscription.cancel();
    await _recentChangesSubscription.cancel();

    searchFieldNode.dispose();
    clearRecentsNode.dispose();
    recentsScopeNode.dispose();
    browseScopeNode.dispose();
    return super.close();
  }
}

extension EncyclopediaBlocProvider on BuildContext {
  EncyclopediaBloc get encyclopediaBloc => BlocProvider.of(this);
}
