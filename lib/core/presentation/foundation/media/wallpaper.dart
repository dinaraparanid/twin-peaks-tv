import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tizen/flutter_tizen.dart' as tizen;
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

final class Wallpaper extends StatelessWidget {
  const Wallpaper({super.key, required this.thumbnailUrl});
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return _MaterialWallpaper(thumbnailUrl: thumbnailUrl);
    }

    if (Platform.isIOS) {
      return _CupertinoWallpaper(thumbnailUrl: thumbnailUrl);
    }

    if (tizen.isTizen) {
      return _OneUiWallpaper(thumbnailUrl: thumbnailUrl);
    }

    return const SizedBox();
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
            child: CachedNetworkImage(
              imageUrl: thumbnailUrl,
              fit: BoxFit.cover,
              httpHeaders: {
                'User-Agent':
                    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36',
              },
              placeholder: (_, _) => const SizedBox(),
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
            child: CachedNetworkImage(
              imageUrl: thumbnailUrl,
              fit: BoxFit.cover,
              placeholder: (_, _) => const SizedBox(),
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
            child: CachedNetworkImage(
              imageUrl: thumbnailUrl,
              fit: BoxFit.cover,
              placeholder: (_, _) => const SizedBox(),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: gradients.cupertinoBottomWallpaperScrim,
              ),
              child: SizedBox(width: width, height: height / 2),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: gradients.cupertinoStartWallpaperScrim,
              ),
              child: SizedBox(width: width / 2, height: height),
            ),
          ),
        ],
      ),
    );
  }
}
