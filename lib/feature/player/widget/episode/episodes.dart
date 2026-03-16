import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/player/widget/episode/episode_item.dart';

final class Episodes extends StatelessWidget {
  const Episodes({super.key, required this.episodes});
  final List<Episode> episodes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.s,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 64.s),
          child: Text(
            context.ln.player_watch_next,
            style: context.appTheme.typography.player.label.copyWith(
              color: context.appTheme.colors.text.primary,
            ),
          ),
        ),

        SizedBox(
          height: 250.s,
          child: TvListView.separated(
            focusScopeNode: context.playerBloc.episodesScopeNode,
            itemCount: episodes.length,
            padding: EdgeInsets.symmetric(horizontal: 64.s),
            scrollDirection: Axis.horizontal,
            onUp: (_, _, isOutOfScope) {
              if (!isOutOfScope) {
                return KeyEventResult.ignored;
              }

              context.playerBloc.add(
                const ChangeControlsVisibilityEvent(
                  visibility: ControlsVisibility.controls,
                ),
              );

              return KeyEventResult.handled;
            },
            separatorBuilder: (_, _) => SizedBox(height: 2.s),
            itemBuilder: (context, index) => EpisodeItem(
              episode: episodes[index],
              focusNode: context.playerBloc.episodesNodes[index],
              onSelect: () {
                context.playerBloc.add(SelectEpisodeEvent(index: index));
              },
            ),
          ),
        ),
      ],
    );
  }
}
