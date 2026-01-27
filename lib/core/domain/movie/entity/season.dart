import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/actor.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/episode.dart';

part 'season.freezed.dart';

@freezed
abstract class Season with _$Season {
  const factory Season({
    required String title,
    required int year,
    required double rating,
    required String description,
    required String thumbnailUrls,
    required List<Episode> episodes,
    required List<Actor> actors,
  }) = _Season;
}
