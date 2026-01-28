import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/seasons.dart';
import 'package:twin_peaks_tv/core/domain/movie/use_case/use_case.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_bloc.dart';

@singleton
final class SeasonBlocFactory {
  const SeasonBlocFactory(this._loadSeasonUseCase);
  final LoadSeasonUseCase _loadSeasonUseCase;

  SeasonBloc call({required Seasons season}) =>
      SeasonBloc(season: season, loadSeasonUseCase: _loadSeasonUseCase);
}
