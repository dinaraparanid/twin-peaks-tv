import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';

final class WebOSInfo extends StatelessWidget {
  const WebOSInfo({
    super.key,
    required this.properties,
    required this.title,
    required this.infoInteraction,
    required this.wallpaperBuilder,
    this.carousel,
    this.onScrollToPreviousPicture,
    this.onScrollToNextPicture,
    required this.cast,
  });

  static const _arrowsColor = Color(0xCCFFFFFF);

  static Widget shimmer() => const _WebOSInfoShimmer();

  final Widget properties;
  final Widget title;
  final Widget infoInteraction;
  final Widget Function(BuildContext) wallpaperBuilder;
  final Widget? carousel;
  final VoidCallback? onScrollToPreviousPicture;
  final VoidCallback? onScrollToNextPicture;
  final Widget cast;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 1,
              child: Stack(
                children: [
                  Builder(builder: wallpaperBuilder),

                  if (carousel != null) ...[
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 16.s,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: carousel!,
                      ),
                    ),

                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 12.s,
                      child: GestureDetector(
                        onTap: onScrollToPreviousPicture,
                        child: Assets.icons.chevronLeft.svg(
                          width: 24.iz,
                          height: 24.iz,
                          colorFilter: _arrowsColor.toColorFilter(),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 12,
                      child: GestureDetector(
                        onTap: onScrollToNextPicture,
                        child: Assets.icons.chevronRight.svg(
                          width: 24.iz,
                          height: 24.iz,
                          colorFilter: _arrowsColor.toColorFilter(),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 32.s),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    properties,
                    title,
                    SizedBox(height: 8.s),
                    infoInteraction,
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.s),
        cast,
      ],
    );
  }
}

final class _WebOSInfoShimmer extends StatelessWidget {
  const _WebOSInfoShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 1,
              child: AppShimmer.rounded(
                borderRadius: BorderRadius.all(Radius.circular(24.r)),
                child: SizedBox.fromSize(size: Size.fromHeight(324.s)),
              ),
            ),

            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.s),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 8.s,
                  children: [
                    AppShimmer.rounded(
                      borderRadius: BorderRadius.circular(4.r),
                      child: SizedBox(width: 312.s, height: 18.s),
                    ),

                    AppShimmer.rounded(
                      borderRadius: BorderRadius.circular(4.r),
                      child: SizedBox(width: 542.s, height: 32.s),
                    ),

                    AppShimmer.rounded(
                      borderRadius: BorderRadius.circular(4.r),
                      child: SizedBox(width: 542.s, height: 64.s),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.s),
        Cast.shimmer(),
      ],
    );
  }
}
