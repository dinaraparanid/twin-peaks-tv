import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/actor.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/minutes.dart';

part 'movie.freezed.dart';

@freezed
abstract class Movie with _$Movie {
  const factory Movie({
    required String title,
    required int year,
    required Minutes durationMinutes,
    required double rating,
    required String description,
    required String videoUrl,
    required String wallpaperUrl,
    required List<String> scenesUrls,
    required List<Actor> actors,
  }) = _Movie;
}
