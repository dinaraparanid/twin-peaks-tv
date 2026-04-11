import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_response.freezed.dart';
part 'character_response.g.dart';

@freezed
abstract class CharacterResponse with _$CharacterResponse {
  const factory CharacterResponse({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'info') required String info,
    @JsonKey(name: 'thumbnail_url') required String thumbnailUrl,
  }) = _CharacterResponse;

  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseFromJson(json);
}
