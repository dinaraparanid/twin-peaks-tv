import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/media/wallpaper.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';

final class SeasonWallpaper extends StatefulWidget {
  const SeasonWallpaper({super.key});

  @override
  State<StatefulWidget> createState() => _SeasonWallpaperState();
}

final class _SeasonWallpaperState extends State<SeasonWallpaper> {
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
    return BlocBuilder<SeasonBloc, SeasonState>(
      buildWhen: distinctState((x) => x.seasonState),
      builder: (context, state) {
        final thumbnails = state.seasonState.getOrNull?.thumbnailUrls;

        final thumbnail = thumbnails?.getOrNull(
          context.seasonBloc.carouselController.selectedIndex,
        );

        return thumbnail == null
            ? const SizedBox()
            : Wallpaper(thumbnailUrl: thumbnail);
      },
    );
  }
}
