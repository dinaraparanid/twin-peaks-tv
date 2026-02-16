import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/media/cast.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/media/media_screen_content.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/season/widget/carousel/wallpaper_carousel.dart';
import 'package:twin_peaks_tv/feature/season/widget/episodes/episode_list.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_wallpaper.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_description.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_properties.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_title.dart';

final class SeasonScreenContent extends StatelessWidget {
  const SeasonScreenContent({super.key, required this.season});
  final Season season;

  @override
  Widget build(BuildContext context) {
    return MediaScreenContent(
      scrollController: context.seasonBloc.scrollController,
      wallpaper: const SeasonWallpaper(),
      properties: SeasonProperties(season: season),
      title: SeasonTitle(title: season.title),
      infoInteraction: SeasonDescription(description: season.description),
      carousel: const WallpaperCarousel(),
      cast: _Cast(actors: season.actors),
      sliverContent: EpisodeList(episodes: season.episodes),
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
      focusScopeNode: context.seasonBloc.castScopeNode,
      onUp: (_, _, _) {
        context.seasonBloc.add(const RequestFocusOnDescription());
        return KeyEventResult.handled;
      },
      onDown: (_, _, _) {
        context.seasonBloc.add(const RequestFocusOnEpisodes());
        return KeyEventResult.handled;
      },
    );
  }
}
