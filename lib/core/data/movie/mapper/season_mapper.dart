import 'package:twin_peaks_tv/core/data/movie/entity/season_response.dart';
import 'package:twin_peaks_tv/core/data/movie/mapper/actor_mapper.dart';
import 'package:twin_peaks_tv/core/data/movie/mapper/episode_mapper.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';

final class SeasonMapper {
  const SeasonMapper._();

  static Season fromResponse(SeasonResponse response) => Season(
    title: response.title,
    year: response.year,
    rating: response.rating,
    description: response.description,
    thumbnailUrls: response.thumbnailUrls,
    episodes: response.episodes.map(EpisodeMapper.fromResponse).toList(),
    actors: response.actors.map(ActorMapper.fromResponse).toList(),
  );
}
