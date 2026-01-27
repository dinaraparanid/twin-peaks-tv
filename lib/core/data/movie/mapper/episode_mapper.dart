import 'package:twin_peaks_tv/core/data/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';

final class EpisodeMapper {
  const EpisodeMapper._();

  static Episode fromResponse(EpisodeResponse response) => Episode(
    title: response.title,
    rating: response.rating,
    description: response.description,
    thumbnailUrl: response.thumbnailUrl,
    videoUrl: response.videoUrl,
  );
}
