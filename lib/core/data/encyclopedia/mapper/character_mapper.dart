import 'dart:convert';

import 'package:twin_peaks_tv/core/data/encyclopedia/entity/entity.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/entity/entity.dart';

final class CharacterMapper {
  const CharacterMapper._();

  static Character fromResponse(CharacterResponse response) => Character(
    name: response.name,
    info: response.info,
    thumbnailUrl: response.thumbnailUrl,
  );

  static CharacterResponse toResponse(Character character) => CharacterResponse(
    name: character.name,
    info: character.info,
    thumbnailUrl: character.thumbnailUrl,
  );

  static List<Character> fromJsonList(List<String> jsons) {
    return jsons
        .map((json) => jsonDecode(json) as Map<String, dynamic>)
        .map(CharacterResponse.fromJson)
        .map(CharacterMapper.fromResponse)
        .toList(growable: false);
  }

  static List<String> toJsonList(List<Character> characters) {
    return characters
        .map((c) => CharacterMapper.toResponse(c).toJson())
        .map(jsonEncode)
        .toList(growable: false);
  }
}
