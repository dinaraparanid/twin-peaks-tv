import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/domain/movie/use_case/use_case.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';
import 'package:twin_peaks_tv/core/utils/ext/focus_scope_node_ext.dart';
import 'package:twin_peaks_tv/feature/movie/bloc/movie_effect.dart';
import 'package:twin_peaks_tv/feature/movie/bloc/movie_event.dart';
import 'package:twin_peaks_tv/feature/movie/bloc/movie_state.dart';

const _offsetInvisible = 80.0;

final class MovieBloc extends Bloc<MovieEvent, MovieState>
    with BlocPresentationMixin<MovieState, MovieEffect> {
  MovieBloc({required LoadMovieUseCase loadMovieUseCase})
    : _loadMovieUseCase = loadMovieUseCase,
      super(const MovieState()) {
    on<UpdateMovieState>((event, emit) {
      emit(state.copyWith(movieState: event.state));
    });

    on<SwitchDescriptionExpanded>((event, emit) {
      emit(state.copyWith(isDescriptionExpanded: !state.isDescriptionExpanded));
    });

    on<CollapseDescription>((event, emit) {
      emit(state.copyWith(isDescriptionExpanded: false));
    });

    on<RequestFocusOnDescription>((event, emit) {
      descriptionNode.requestFocus();
    });

    on<RequestFocusOnPlayButton>((event, emit) {
      playButtonNode.requestFocus();
    });

    on<RequestFocusOnCast>((event, emit) {
      castScopeNode.requestFocusOnChild();
    });

    on<RequestFocusOnScenes>((event, emit) {
      scenesScopeNode.requestFocusOnChild();
    });

    _loadMovieUseCase(
      onSuccess: (data) {
        add(UpdateMovieState(state: UiState.data(value: data)));
      },
      onFailure: (e) {
        add(UpdateMovieState(state: UiState.error(e)));
      },
    );

    scrollController.addListener(_scrollListener);
  }

  final LoadMovieUseCase _loadMovieUseCase;

  final descriptionNode = FocusNode();
  final playButtonNode = FocusNode();
  final castScopeNode = FocusScopeNode();
  final scenesScopeNode = FocusScopeNode();
  final scrollController = ScrollController();

  void _scrollListener() {
    final opacity = 1 - scrollController.offset / _offsetInvisible;
    emitPresentation(UpdateTabBarOpacity(opacity: opacity.clamp(0, 1)));
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_scrollListener);
    descriptionNode.dispose();
    playButtonNode.dispose();
    castScopeNode.dispose();
    scenesScopeNode.dispose();
    scrollController.dispose();
    return super.close();
  }
}

extension MovieBlocProvider on BuildContext {
  MovieBloc get movieBloc => BlocProvider.of<MovieBloc>(this);
}
