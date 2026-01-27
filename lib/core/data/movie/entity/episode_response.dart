import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode_response.freezed.dart';
part 'episode_response.g.dart';

@freezed
abstract class EpisodeResponse with _$EpisodeResponse {
  const factory EpisodeResponse({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'rating') required double rating,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
    @JsonKey(name: 'video_url') required String videoUrl,
  }) = _EpisodeResponse;

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) =>
      _$EpisodeResponseFromJson(json);
}
