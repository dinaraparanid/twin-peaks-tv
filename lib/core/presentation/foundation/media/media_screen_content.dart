import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/media/media_full_screen_info.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/media/webos_full_screen_info.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';
import 'package:twin_peaks_tv/feature/main/main_screen.dart';

final class MediaScreenContent extends StatelessWidget {
  const MediaScreenContent({
    super.key,
    required this.scrollController,
    required this.wallpaperBuilder,
    required this.properties,
    required this.title,
    required this.infoInteraction,
    this.carousel,
    this.onScrollToPreviousPicture,
    this.onScrollToNextPicture,
    required this.cast,
    required this.sliverContent,
  });

  final ScrollController scrollController;
  final Widget Function(BuildContext) wallpaperBuilder;
  final Widget properties;
  final Widget title;
  final Widget infoInteraction;
  final Widget? carousel;
  final VoidCallback? onScrollToPreviousPicture;
  final VoidCallback? onScrollToNextPicture;
  final Widget cast;
  final Widget sliverContent;

  static Widget shimmer({required Widget contentShimmer}) {
    return _MediaScreenContentShimmer(contentShimmer: contentShimmer);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        if (AppPlatform.isWebOS)
          SliverToBoxAdapter(child: SizedBox(height: 64.s)),

        SliverStack(
          children: [
            ?switch (AppPlatform.targetPlatform) {
              AppPlatforms.android => SliverPositioned(
                top: 0,
                right: 0,
                child: Builder(builder: wallpaperBuilder),
              ),

              AppPlatforms.webos => null,

              _ => SliverPositioned(
                top: 0,
                right: 0,
                left: 0,
                child: Builder(builder: wallpaperBuilder),
              ),
            },

            _SliverContentPadding(
              sliver: MultiSliver(
                children: [
                  SliverToBoxAdapter(
                    child: switch (AppPlatform.targetPlatform) {
                      AppPlatforms.android ||
                      AppPlatforms.tizen ||
                      AppPlatforms.tvos => MediaFullScreenInfo(
                        properties: properties,
                        title: title,
                        infoInteraction: infoInteraction,
                        carousel: carousel,
                        cast: cast,
                      ),

                      AppPlatforms.webos => WebOSInfo(
                        properties: properties,
                        title: title,
                        infoInteraction: infoInteraction,
                        wallpaperBuilder: wallpaperBuilder,
                        carousel: carousel,
                        onScrollToPreviousPicture: onScrollToPreviousPicture,
                        onScrollToNextPicture: onScrollToNextPicture,
                        cast: cast,
                      ),
                    },
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 12.s)),

                  sliverContent,

                  SliverToBoxAdapter(child: SizedBox(height: 32.s)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

final class _MediaScreenContentShimmer extends StatelessWidget {
  const _MediaScreenContentShimmer({required this.contentShimmer});
  final Widget contentShimmer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (AppPlatform.isWebOS) SizedBox(height: 64.s),

          _ContentPadding(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                switch (AppPlatform.targetPlatform) {
                  AppPlatforms.android ||
                  AppPlatforms.tizen ||
                  AppPlatforms.tvos => MediaFullScreenInfo.shimmer(),

                  AppPlatforms.webos => WebOSInfo.shimmer(),
                },

                SizedBox(height: 12.s),

                contentShimmer,

                SizedBox(height: 32.s),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _ContentPadding extends StatelessWidget {
  const _ContentPadding({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (AppPlatform.isTvOS) {
      return Padding(
        padding: EdgeInsets.only(left: 64.s),
        child: child,
      );
    }

    if (AppPlatform.isTizen) {
      return AnimatedBuilder(
        animation: OneUiTvNavigationDrawer.animationOf(context),
        builder: (context, _) => Padding(
          padding: EdgeInsets.only(
            left: lerpDouble(
              MainScreen.oneUiMenuConstraints.minWidth,
              0,
              OneUiTvNavigationDrawer.animationOf(context).value,
            )!,
          ),
          child: child,
        ),
      );
    }

    return child;
  }
}

final class _SliverContentPadding extends StatelessWidget {
  const _SliverContentPadding({required this.sliver});
  final Widget sliver;

  @override
  Widget build(BuildContext context) {
    if (AppPlatform.isTvOS) {
      return SliverPadding(
        padding: EdgeInsets.only(left: 64.s),
        sliver: sliver,
      );
    }

    if (AppPlatform.isTizen) {
      return AnimatedBuilder(
        animation: OneUiTvNavigationDrawer.animationOf(context),
        builder: (context, _) => SliverPadding(
          padding: EdgeInsets.only(
            left: lerpDouble(
              MainScreen.oneUiMenuConstraints.minWidth,
              0,
              OneUiTvNavigationDrawer.animationOf(context).value,
            )!,
          ),
          sliver: sliver,
        ),
      );
    }

    return sliver;
  }
}
