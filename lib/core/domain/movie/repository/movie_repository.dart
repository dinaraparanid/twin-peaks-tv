import 'package:fpdart/fpdart.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';

abstract class MovieRepository {
  Future<Either<Exception, Season>> fetchSeason({required Seasons season});
  Future<Either<Exception, Movie>> fetchMovie();
}
