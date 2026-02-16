import 'package:flutter/widgets.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/season/widget/episodes/episode_item.dart';

final class EpisodeList extends StatelessWidget {
  const EpisodeList({super.key, required this.episodes});
  final List<Episode> episodes;

  @override
  Widget build(BuildContext context) {
    return SliverTVScrollAdapter(
      focusScopeNode: context.seasonBloc.episodesScopeNode,
      onUp: (_, _, isOutOfScope) {
        if (isOutOfScope) {
          context.seasonBloc.add(const RequestFocusOnCast());
        }

        return KeyEventResult.handled;
      },
      sliver: SliverList.separated(
        itemCount: episodes.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) => EpisodeItem(episode: episodes[index]),
      ),
    );
  }
}
