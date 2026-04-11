import 'package:fpdart/fpdart.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';

abstract base class MovieRepository {
  const MovieRepository();

  Future<Either<Exception, Season>> fetchSeason({required Seasons season});
  Future<Either<Exception, Movie>> fetchMovie();
}
