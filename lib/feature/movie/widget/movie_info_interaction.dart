import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/feature/movie/widget/movie_description.dart';
import 'package:twin_peaks_tv/feature/movie/widget/movie_play_button.dart';

final class MovieInfoInteraction extends StatelessWidget {
  const MovieInfoInteraction({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        MovieDescription(description: movie.description),
        MoviePlayButton(videoUrl: movie.videoUrl),
      ],
    );
  }
}
