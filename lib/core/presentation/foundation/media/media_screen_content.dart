import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
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
                      AppPlatforms.tvos => _FullScreenInfo(
                        properties: properties,
                        title: title,
                        infoInteraction: infoInteraction,
                        carousel: carousel,
                        cast: cast,
                      ),

                      AppPlatforms.webos => _WebOSInfo(
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

final class _FullScreenInfo extends StatelessWidget {
  const _FullScreenInfo({
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

final class _WebOSInfo extends StatelessWidget {
  const _WebOSInfo({
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
