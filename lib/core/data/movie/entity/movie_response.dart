import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/core/data/movie/entity/actor_response.dart';

part 'movie_response.freezed.dart';
part 'movie_response.g.dart';

@freezed
abstract class MovieResponse with _$MovieResponse {
  const factory MovieResponse({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'year') required int year,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    @JsonKey(name: 'rating') required double rating,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'video_url') required String videoUrl,
    @JsonKey(name: 'thumbnail_urls') required String thumbnailUrls,
    @JsonKey(name: 'scenes_urls') required List<String> scenesUrls,
    @JsonKey(name: 'actors') required List<ActorResponse> actors,
  }) = _MovieResponse;

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
}
