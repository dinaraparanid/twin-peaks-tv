import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';

final class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.loadingBuilder,
    this.errorBuilder,
  });

  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return switch (AppPlatform.targetPlatform) {
      // CachedNetworkImage is not supported on tvOS for now
      AppPlatforms.tvos => Image.network(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        loadingBuilder: loadingBuilder == null
            ? null
            : (context, _, _) {
                return loadingBuilder!(context);
              },
        errorBuilder: errorBuilder == null
            ? null
            : (context, _, _) {
                return errorBuilder!(context);
              },
      ),

      _ => CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        placeholder: loadingBuilder == null
            ? null
            : (context, _) {
                return loadingBuilder!(context);
              },
        errorWidget: errorBuilder == null
            ? null
            : (context, _, _) {
                return errorBuilder!(context);
              },
      ),
    };
  }
}
