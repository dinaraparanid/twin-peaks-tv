import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/domain/movie/movie.dart';

@singleton
final class LoadMovieUseCase {
  const LoadMovieUseCase(this._repository);
  final MovieRepository _repository;

  Future<void> call({
    required void Function(Movie) onSuccess,
    required void Function(Exception) onFailure,
  }) async {
    try {
      switch (await _repository.fetchMovie()) {
        case Right<Exception, Movie>(value: final data):
          onSuccess(data);

        case Left<Exception, Movie>(value: final error):
          onFailure(error);
      }
    } on Exception catch (e) {
      onFailure(e);
    }
  }
}
