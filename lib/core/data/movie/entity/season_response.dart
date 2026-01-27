import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/core/data/movie/entity/actor_response.dart';
import 'package:twin_peaks_tv/core/data/movie/entity/episode_response.dart';

part 'season_response.freezed.dart';
part 'season_response.g.dart';

@freezed
abstract class SeasonResponse with _$SeasonResponse {
  const factory SeasonResponse({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'year') required int year,
    @JsonKey(name: 'rating') required double rating,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'thumbnail_urls') required String thumbnailUrls,
    @JsonKey(name: 'episodes') required List<EpisodeResponse> episodes,
    @JsonKey(name: 'actors') required List<ActorResponse> actors,
  }) = _SeasonResponse;

  factory SeasonResponse.fromJson(Map<String, dynamic> json) =>
      _$SeasonResponseFromJson(json);
}
