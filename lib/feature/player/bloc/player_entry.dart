import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';

part 'player_entry.freezed.dart';

@freezed
sealed class PlayerEntry with _$PlayerEntry {
  const factory PlayerEntry.season({
    required int episodeIndex,
    required List<Episode> episodes,
  }) = PlayerEntrySeason;

  const factory PlayerEntry.movie({required Movie movie}) = PlayerEntryMovie;
}

extension PlayerEntryExt on PlayerEntry {
  String get videoUrl => switch (this) {
    PlayerEntrySeason(episodeIndex: final index, episodes: final episodes) =>
      episodes[index].videoUrl,

    PlayerEntryMovie(movie: final movie) => movie.videoUrl,
  };
}
