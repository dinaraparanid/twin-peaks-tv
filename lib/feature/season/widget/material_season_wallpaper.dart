import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

final class MaterialSeasonWallpaper extends StatelessWidget {
  const MaterialSeasonWallpaper({super.key, required this.thumbnailUrl});

  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.68;
    final height = MediaQuery.sizeOf(context).width * 0.73;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          CachedNetworkImage(imageUrl: thumbnailUrl, fit: BoxFit.cover),

          DecoratedBox(
            decoration: BoxDecoration(
              gradient: context.appTheme.colors.gradients.wallpaperScrim,
            ),
            child: SizedBox.square(dimension: width),
          ),
        ],
      ),
    );
  }
}
