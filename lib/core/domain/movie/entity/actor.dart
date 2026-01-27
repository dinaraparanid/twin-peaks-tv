import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor.freezed.dart';

@freezed
abstract class Actor with _$Actor {
  const factory Actor({
    required String name,
    required String character,
    required String thumbnailUrl,
  }) = _Actor;
}
