import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/domain/movie/movie.dart';

@singleton
final class LoadSeasonUseCase {
  const LoadSeasonUseCase(this._repository);
  final MovieRepository _repository;

  Future<void> call({
    required Seasons season,
    required void Function(Season) onSuccess,
    required void Function(Exception) onFailure,
  }) async {
    try {
      switch (await _repository.fetchSeason(season: season)) {
        case Right<Exception, Season>(value: final data):
          onSuccess(data);

        case Left<Exception, Season>(value: final error):
          onFailure(error);
      }
    } on Exception catch (e) {
      onFailure(e);
    }
  }
}
