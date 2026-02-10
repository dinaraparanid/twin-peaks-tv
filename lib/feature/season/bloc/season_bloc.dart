import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/domain/movie/use_case/use_case.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';
import 'package:twin_peaks_tv/core/utils/ext/focus_scope_node_ext.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_effect.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_event.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_state.dart';

const _offsetInvisible = 80.0;

final class SeasonBloc extends Bloc<SeasonEvent, SeasonState>
    with BlocPresentationMixin<SeasonState, SeasonEffect> {
  SeasonBloc({
    required Seasons season,
    required LoadSeasonUseCase loadSeasonUseCase,
  }) : _loadSeasonUseCase = loadSeasonUseCase,
       super(SeasonState(season: season)) {
    on<UpdateSeasonState>((event, emit) {
      emit(state.copyWith(seasonState: event.state));
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

    on<RequestFocusOnCarousel>((event, emit) {
      carouselNode.requestFocus();
    });

    on<RequestFocusOnCast>((event, emit) {
      castScopeNode.requestFocusOnChild();
    });

    on<RequestFocusOnEpisodes>((event, emit) {
      episodesScopeNode.requestFocusOnChild();
    });

    _loadSeasonUseCase(
      season: season,
      onSuccess: (data) {
        add(UpdateSeasonState(state: UiState.data(value: data)));
        carouselController.reset(count: data.thumbnailUrls.length);
      },
      onFailure: (e) {
        add(UpdateSeasonState(state: UiState.error(e)));
      },
    );

    scrollController.addListener(_scrollListener);
  }

  final LoadSeasonUseCase _loadSeasonUseCase;

  final descriptionNode = FocusNode();
  final castScopeNode = FocusScopeNode();
  final episodesScopeNode = FocusScopeNode();
  final carouselNode = FocusNode();
  final carouselController = TvCarouselController(itemCount: 1);
  final scrollController = ScrollController();

  void _scrollListener() {
    final opacity = 1 - scrollController.offset / _offsetInvisible;
    emitPresentation(UpdateTabBarOpacity(opacity: opacity.clamp(0, 1)));
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_scrollListener);
    descriptionNode.dispose();
    castScopeNode.dispose();
    episodesScopeNode.dispose();
    carouselNode.dispose();
    carouselController.dispose();
    scrollController.dispose();
    return super.close();
  }
}

extension SeasonBlocProvider on BuildContext {
  SeasonBloc get seasonBloc => BlocProvider.of<SeasonBloc>(this);
}
