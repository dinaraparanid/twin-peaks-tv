import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/media/wallpaper.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/movie/bloc/bloc.dart';

final class MovieWallpaper extends StatelessWidget {
  const MovieWallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: distinctState((x) => x.movieState),
      builder: (context, state) {
        final wallpaper = state.movieState.getOrNull?.wallpaperUrl;

        if (wallpaper == null) {
          return const SizedBox();
        }

        return Wallpaper(thumbnailUrl: wallpaper);
      },
    );
  }
}
