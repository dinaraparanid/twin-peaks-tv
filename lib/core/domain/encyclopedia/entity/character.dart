import 'package:freezed_annotation/freezed_annotation.dart';

part 'character.freezed.dart';

@freezed
abstract class Character with _$Character {
  const factory Character({
    required String name,
    required String info,
    required String thumbnailUrl,
  }) = _Character;
}
