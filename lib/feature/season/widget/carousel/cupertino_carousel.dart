import 'package:flutter/cupertino.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_bloc.dart';
import 'package:twin_peaks_tv/feature/season/bloc/season_event.dart';

final class CupertinoCarousel extends StatelessWidget {
  const CupertinoCarousel({super.key, required this.season});
  final Season season;

  double _itemSize({
    required int index,
    required int selectedIndex,
    required (int, int) visibleIndices,
  }) {
    if (index < visibleIndices.$1 || index > visibleIndices.$2) {
      return 0;
    }

    if (index > 0 &&
        index == visibleIndices.$1 &&
        selectedIndex > visibleIndices.$1 + 1) {
      return 6.s;
    }

    if (index > 1 &&
        index == visibleIndices.$1 + 1 &&
        selectedIndex > visibleIndices.$1 + 1) {
      return 8.s;
    }

    if (index < season.thumbnailUrls.length - 1 &&
        index == visibleIndices.$2 &&
        selectedIndex < visibleIndices.$2 - 1) {
      return 6.s;
    }

    if (index < season.thumbnailUrls.length - 2 &&
        index == visibleIndices.$2 - 1 &&
        selectedIndex < visibleIndices.$2 - 1) {
      return 8.s;
    }

    return 12.s;
  }

  @override
  Widget build(BuildContext context) {
    final carouselColors = context.appTheme.colors.carousel;

    return LiquidGlassLayer(
      settings: AppLiquidGlass.defaultSettings(
        context,
        color: context.appTheme.colors.cupertino.background,
      ),
      child: LiquidGlass(
        shape: LiquidRoundedRectangle(borderRadius: 24.r),
        child: TvScrollCarouselPager(
          height: 32.s,
          capacity: 5,
          padding: EdgeInsets.symmetric(horizontal: 12.s, vertical: 8.s),
          itemCount: season.thumbnailUrls.length,
          controller: context.seasonBloc.carouselController,
          focusScopeNode: context.seasonBloc.carouselNode,
          separatorBuilder: (context, index, selectedIndex, visibleIndices) {
            final size = _itemSize(
              index: index,
              selectedIndex: selectedIndex,
              visibleIndices: visibleIndices,
            );

            return SizedBox(width: size > 0 ? 8.s : 0);
          },
          viewportAlignment: (context, selectedIndex, visibleIndices) {
            return selectedIndex == visibleIndices.$1 ? 0.5 : null;
          },
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
          itemBuilder:
              (context, index, selectedIndex, visibleIndices, isFocused) {
                final size = _itemSize(
                  index: index,
                  selectedIndex: selectedIndex,
                  visibleIndices: visibleIndices,
                );

                final isSelected = index == selectedIndex;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: switch ((isSelected, isFocused)) {
                      (false, _) => carouselColors.content,
                      (true, true) => carouselColors.focusedContent,
                      (true, false) => carouselColors.selectedContent,
                    },
                  ),
                );
              },
        ),
      ),
    );
  }
}
