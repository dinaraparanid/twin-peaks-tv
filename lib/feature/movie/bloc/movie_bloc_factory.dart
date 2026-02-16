import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/domain/movie/use_case/use_case.dart';
import 'package:twin_peaks_tv/feature/movie/bloc/movie_bloc.dart';

@singleton
final class MovieBlocFactory {
  const MovieBlocFactory(this._loadMovieUseCase);
  final LoadMovieUseCase _loadMovieUseCase;

  MovieBloc call() => MovieBloc(loadMovieUseCase: _loadMovieUseCase);
}
