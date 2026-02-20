import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/season.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/season/widget/carousel/material_carousel.dart';
import 'package:twin_peaks_tv/feature/season/widget/carousel/one_ui_carousel.dart';

final class WallpaperCarousel extends StatelessWidget {
  const WallpaperCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeasonBloc, SeasonState>(
      buildWhen: distinctState((x) => x.seasonState),
      builder: (context, state) {
        return switch (state.seasonState) {
          Data<Season>(value: final season) ||
          Refreshing<Season>(
            value: Data<Season>(value: final season),
          ) => switch (AppPlatform.targetPlatform) {
            AppPlatforms.android => MaterialCarousel(season: season),
            AppPlatforms.tizen => OneUiCarousel(season: season),
            AppPlatforms.tvos => throw UnimplementedError(),
            AppPlatforms.webos => throw UnimplementedError(),
          },

          Initial<Season>() ||
          Loading<Season>() ||
          Refreshing<Season>() ||
          Success<Season>() ||
          Error<Season>() => const SizedBox(),
        };
      },
    );
  }
}
