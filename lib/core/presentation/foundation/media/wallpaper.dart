import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/network_image.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';

final class Wallpaper extends StatelessWidget {
  const Wallpaper({super.key, required this.thumbnailUrl});
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => _MaterialWallpaper(thumbnailUrl: thumbnailUrl),
      AppPlatforms.tizen => _OneUiWallpaper(thumbnailUrl: thumbnailUrl),
      AppPlatforms.tvos => _CupertinoWallpaper(thumbnailUrl: thumbnailUrl),
      AppPlatforms.webos => _WebOSWallpaper(thumbnailUrl: thumbnailUrl),
    };
  }
}

final class _MaterialWallpaper extends StatelessWidget {
  const _MaterialWallpaper({required this.thumbnailUrl});
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.68;
    final height = MediaQuery.sizeOf(context).height * 0.73;
    final gradients = context.appTheme.colors.gradients;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: AppNetworkImage(
              imageUrl: thumbnailUrl,
              width: width,
              height: height,
              alignment: Alignment.topCenter,
            ),
          ),

          DecoratedBox(
            decoration: BoxDecoration(
              gradient: gradients.materialWallpaperScrim,
            ),
            child: SizedBox.square(dimension: width),
          ),
        ],
      ),
    );
  }
}

final class _OneUiWallpaper extends StatelessWidget {
  const _OneUiWallpaper({required this.thumbnailUrl});
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AppNetworkImage(
              imageUrl: thumbnailUrl,
              width: width,
              height: height,
              alignment: Alignment.topCenter,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: context.appTheme.colors.gradients.oneUiWallpaperScrim,
              ),
              child: SizedBox(width: width, height: height / 2),
            ),
          ),
        ],
      ),
    );
  }
}

final class _CupertinoWallpaper extends StatelessWidget {
  const _CupertinoWallpaper({required this.thumbnailUrl});
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final gradients = context.appTheme.colors.gradients;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AppNetworkImage(
              imageUrl: thumbnailUrl,
              width: width,
              height: height,
              alignment: Alignment.topCenter,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: gradients.cupertinoVerticalWallpaperScrim,
              ),
              child: SizedBox(width: width, height: height / 2),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: gradients.cupertinoHorizontalWallpaperScrim,
              ),
              child: SizedBox(width: width / 2, height: height),
            ),
          ),
        ],
      ),
    );
  }
}

final class _WebOSWallpaper extends StatelessWidget {
  const _WebOSWallpaper({required this.thumbnailUrl});
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final gradients = context.appTheme.colors.gradients;

    return AspectRatio(
      aspectRatio: 1.8,
      child: Stack(
        children: [
          Padding(
            // in order to prevent weird border scrim
            // animation during drawer collapse
            padding: EdgeInsets.all(2.s),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
              child: AppNetworkImage(
                imageUrl: thumbnailUrl,
                width: double.infinity,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: gradients.webOSVerticalScrim),
            ),
          ),

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: gradients.webOSHorizontalScrim,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
