import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';

final class MaterialSeasonWallpaper extends StatefulWidget {
  const MaterialSeasonWallpaper({super.key});

  @override
  State<StatefulWidget> createState() => _MaterialSeasonWallpaperState();
}

final class _MaterialSeasonWallpaperState
    extends State<MaterialSeasonWallpaper> {
  late final _carouselController = context.seasonBloc.carouselController;

  @override
  void initState() {
    _carouselController.addListener(_listener);
    super.initState();
  }

  void _listener() => setState(() {});

  @override
  void dispose() {
    _carouselController.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.68;
    final height = MediaQuery.sizeOf(context).width * 0.45;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          BlocBuilder<SeasonBloc, SeasonState>(
            buildWhen: distinctState((x) => x.seasonState),
            builder: (context, state) {
              final thumbnails = state.seasonState.getOrNull?.thumbnailUrls;
              final thumbnail = thumbnails?.getOrNull(
                context.seasonBloc.carouselController.selectedIndex,
              );

              if (thumbnail == null) {
                return const SizedBox();
              }

              return Align(
                alignment: Alignment.topRight,
                child: CachedNetworkImage(
                  imageUrl: thumbnail,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => const SizedBox(),
                ),
              );
            },
          ),

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
