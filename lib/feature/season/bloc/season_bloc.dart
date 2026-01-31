import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/domain/movie/use_case/use_case.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_event.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_state.dart';

final class SeasonBloc extends Bloc<SeasonEvent, SeasonState> {
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

    _loadSeasonUseCase(
      season: season,
      onSuccess: (data) {
        add(UpdateSeasonState(state: UiState.data(value: data)));
      },
      onFailure: (e) {
        add(UpdateSeasonState(state: UiState.error(e)));
      },
    );
  }

  final LoadSeasonUseCase _loadSeasonUseCase;
}

extension SeasonBlocProvider on BuildContext {
  SeasonBloc get seasonBloc => BlocProvider.of<SeasonBloc>(this);
}
