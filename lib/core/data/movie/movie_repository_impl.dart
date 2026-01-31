import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/data/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/data/movie/mapper/mapper.dart';
import 'package:twin_peaks_tv/core/dio/dio.dart';
import 'package:twin_peaks_tv/core/domain/movie/movie.dart';

@Singleton(as: MovieRepository)
final class MovieRepositoryImpl extends MovieRepository {
  MovieRepositoryImpl({required this.dio});

  final AppDio dio;

  @override
  Future<Either<Exception, Movie>> fetchMovie() async {
    try {
      final response = await dio.value.get<Map<String, dynamic>>(
        '/movies/movie',
      );
      final data = MovieMapper.fromResponse(
        MovieResponse.fromJson(response.data!),
      );
      return right(data);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, Season>> fetchSeason({
    required Seasons season,
  }) async {
    try {
      final response = await dio.value.get<Map<String, dynamic>>(
        '/movies/${season.path}',
      );

      final data = SeasonMapper.fromResponse(
        SeasonResponse.fromJson(response.data!),
      );

      return right(data);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
