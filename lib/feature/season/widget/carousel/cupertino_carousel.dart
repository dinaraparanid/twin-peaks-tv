import 'package:flutter/cupertino.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_bloc.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_event.dart';

final class CupertinoCarousel extends StatelessWidget {
  const CupertinoCarousel({super.key, required this.season});
  final Season season;

  @override
  Widget build(BuildContext context) {
    final carouselColors = context.appTheme.colors.carousel;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.s, vertical: 8.s),
      decoration: BoxDecoration(
        color: carouselColors.background,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: TvCarouselPager(
        itemCount: season.thumbnailUrls.length,
        controller: context.seasonBloc.carouselController,
        focusNode: context.seasonBloc.carouselNode,
        spacing: 8.s,
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
          width: 12.s,
          height: 12.s,
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
