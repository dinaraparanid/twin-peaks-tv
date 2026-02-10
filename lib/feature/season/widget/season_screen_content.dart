import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/movie/cast.dart';
import 'package:twin_peaks_tv/core/utils/ext/key_ext.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/season/widget/carousel/wallpaper_carousel.dart';
import 'package:twin_peaks_tv/feature/season/widget/episodes/episode_list.dart';
import 'package:twin_peaks_tv/feature/season/widget/material_season_wallpaper.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_description.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_properties.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_title.dart';

final class SeasonScreenContent extends StatelessWidget {
  const SeasonScreenContent({super.key, required this.season});

  final Season season;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: context.seasonBloc.scrollController,
      slivers: [
        SliverToBoxAdapter(child: _Info(season: season)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          sliver: EpisodeList(episodes: season.episodes),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

final class _Info extends StatefulWidget {
  const _Info({required this.season});
  final Season season;

  @override
  State<StatefulWidget> createState() => _InfoState();
}

final class _InfoState extends State<_Info> {
  final _infoContainerKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {}); // init info container size
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.topRight,
          child: MaterialSeasonWallpaper(),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Flexible(
                    key: _infoContainerKey,
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 120),
                        SeasonProperties(season: widget.season),
                        SeasonTitle(title: widget.season.title),
                        const SizedBox(height: 8),
                        SeasonDescription(
                          description: widget.season.description,
                        ),
                      ],
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: Container(
                      height: _infoContainerKey.size?.height,
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.only(left: 64),
                      child: const WallpaperCarousel(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Cast(
              actors: widget.season.actors,
              focusScopeNode: context.seasonBloc.castScopeNode,
              onUp: (_, _, _) {
                context.seasonBloc.add(const RequestFocusOnDescription());
                return KeyEventResult.handled;
              },
              onDown: (_, _, _) {
                context.seasonBloc.add(const RequestFocusOnEpisodes());
                return KeyEventResult.handled;
              },
            ),
          ],
        ),
      ],
    );
  }
}
