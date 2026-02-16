import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/media/cast.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/media/media_screen_content.dart';
import 'package:twin_peaks_tv/feature/movie/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/movie/widget/movie_info_interaction.dart';
import 'package:twin_peaks_tv/feature/movie/widget/movie_properties.dart';
import 'package:twin_peaks_tv/feature/movie/widget/movie_title.dart';
import 'package:twin_peaks_tv/feature/movie/widget/movie_wallpaper.dart';
import 'package:twin_peaks_tv/feature/movie/widget/scenes/scene_list.dart';

final class MovieScreenContent extends StatelessWidget {
  const MovieScreenContent({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return MediaScreenContent(
      scrollController: context.movieBloc.scrollController,
      wallpaper: const MovieWallpaper(),
      properties: MovieProperties(movie: movie),
      title: MovieTitle(title: movie.title),
      infoInteraction: MovieInfoInteraction(movie: movie),
      cast: _Cast(actors: movie.actors),
      sliverContent: SliverToBoxAdapter(
        child: SceneList(scenes: movie.scenesUrls),
      ),
    );
  }
}

final class _Cast extends StatelessWidget {
  const _Cast({required this.actors});
  final List<Actor> actors;

  @override
  Widget build(BuildContext context) {
    return Cast(
      actors: actors,
      focusScopeNode: context.movieBloc.castScopeNode,
      onUp: (_, _, _) {
        context.movieBloc.add(const RequestFocusOnPlayButton());
        return KeyEventResult.handled;
      },
      onDown: (_, _, _) {
        context.movieBloc.add(const RequestFocusOnScenes());
        return KeyEventResult.handled;
      },
    );
  }
}
