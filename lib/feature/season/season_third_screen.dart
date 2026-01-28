import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/feature/season/season_screen.dart';

@RoutePage()
final class SeasonThreeScreen extends StatelessWidget {
  const SeasonThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SeasonScreen(season: Seasons.third);
  }
}
