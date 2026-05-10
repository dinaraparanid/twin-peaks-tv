import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';

final class MediaFullScreenInfo extends StatelessWidget {
  const MediaFullScreenInfo({
    super.key,
    required this.properties,
    required this.title,
    required this.infoInteraction,
    required this.carousel,
    required this.cast,
  });

  final Widget properties;
  final Widget title;
  final Widget infoInteraction;
  final Widget? carousel;
  final Widget cast;

  static Widget shimmer() => const _FullScreenInfoShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.s),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 184.s),
                    properties,
                    title,
                    SizedBox(height: 8.s),
                    infoInteraction,
                  ],
                ),
              ),

              Flexible(
                flex: 1,
                child: switch (carousel) {
                  null => const SizedBox(),
                  final carousel => Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(left: 64.s),
                    child: carousel,
                  ),
                },
              ),
            ],
          ),
        ),

        SizedBox(height: 16.s),
        cast,
      ],
    );
  }
}

final class _FullScreenInfoShimmer extends StatelessWidget {
  const _FullScreenInfoShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.s),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.s,
                  children: [
                    SizedBox(height: 184.s),

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

              const Flexible(flex: 1, child: SizedBox()),
            ],
          ),
        ),

        SizedBox(height: 16.s),
        Cast.shimmer(),
      ],
    );
  }
}
