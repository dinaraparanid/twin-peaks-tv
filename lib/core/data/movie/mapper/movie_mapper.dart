import 'package:twin_peaks_tv/core/data/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/data/movie/mapper/actor_mapper.dart';
import 'package:twin_peaks_tv/core/domain/movie/movie.dart';

final class MovieMapper {
  const MovieMapper._();

  static Movie fromResponse(MovieResponse response) => Movie(
    title: response.title,
    year: response.year,
    durationMinutes: response.durationMinutes,
    rating: response.rating,
    description: response.description,
    videoUrl: response.videoUrl,
    thumbnailUrls: response.thumbnailUrls,
    scenesUrls: response.scenesUrls,
    actors: response.actors.map(ActorMapper.fromResponse).toList(),
  );
}
