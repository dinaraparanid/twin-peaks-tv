import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';

@freezed
abstract class Episode with _$Episode {
  const factory Episode({
    required String title,
    required double rating,
    required String description,
    required String thumbnailUrl,
    required String videoUrl,
  }) = _Episode;
}
