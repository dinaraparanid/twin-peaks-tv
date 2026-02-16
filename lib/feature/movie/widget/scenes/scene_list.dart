import 'package:flutter/widgets.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/movie/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/movie/widget/scenes/scene_item.dart';

final class SceneList extends StatelessWidget {
  const SceneList({super.key, required this.scenes});
  final List<String> scenes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          context.ln.movie_scenes_from_movie,
          style: context.appTheme.typography.movieInfo.label.copyWith(
            color: context.appTheme.colors.text.primary,
          ),
        ),

        SizedBox(
          height: SceneItem.thumbnailFocusedHeight,
          child: TvListView.separated(
            itemCount: scenes.length,
            scrollDirection: Axis.horizontal,
            focusScopeNode: context.movieBloc.scenesScopeNode,
            onUp: (_, _, isOutOfScope) {
              if (isOutOfScope) {
                context.movieBloc.add(const RequestFocusOnCast());
              }

              return KeyEventResult.handled;
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return SceneItem(thumbnailUrl: scenes[index]);
            },
          ),
        ),
      ],
    );
  }
}
