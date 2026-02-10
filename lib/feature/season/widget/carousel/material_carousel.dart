import 'package:flutter/material.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_bloc.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_event.dart';

final class MaterialCarousel extends StatelessWidget {
  const MaterialCarousel({super.key, required this.season});
  final Season season;

  @override
  Widget build(BuildContext context) {
    final carouselColors = context.appTheme.colors.carousel;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: carouselColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TvCarouselPager(
        itemCount: season.thumbnailUrls.length,
        controller: context.seasonBloc.carouselController,
        focusNode: context.seasonBloc.carouselNode,
        spacing: 8,
        onDown: (_, _) {
          context.seasonBloc.add(const RequestFocusOnCast());
          return KeyEventResult.handled;
        },
        onLeft: (_, _, hasReachedBoundary) {
          if (hasReachedBoundary) {
            context.seasonBloc.add(const RequestFocusOnDescription());
          }

          return KeyEventResult.handled;
        },
        onRight: (_, _, _) => KeyEventResult.handled,
        itemBuilder: (context, index, isSelected, isFocused) => Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: switch ((isSelected, isFocused)) {
              (false, _) => carouselColors.content,
              (true, true) => carouselColors.focusedContent,
              (true, false) => carouselColors.selectedContent,
            },
          ),
        ),
      ),
    );
  }
}
