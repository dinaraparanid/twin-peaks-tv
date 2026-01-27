import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor_response.freezed.dart';
part 'actor_response.g.dart';

@freezed
abstract class ActorResponse with _$ActorResponse {
  const factory ActorResponse({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'character') required String character,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
  }) = _ActorResponse;

  factory ActorResponse.fromJson(Map<String, dynamic> json) =>
      _$ActorResponseFromJson(json);
}
