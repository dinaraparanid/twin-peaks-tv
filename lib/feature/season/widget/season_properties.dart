import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/star_rating.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

final class SeasonProperties extends StatelessWidget {
  const SeasonProperties({super.key, required this.season});
  final Season season;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.ln.season_year_episodes_rating(
            season.year,
            season.episodes.length,
          ),
          style: context.appTheme.typography.movieInfo.properties.copyWith(
            color: context.appTheme.colors.text.tertiary,
          ),
        ),
        StarRating(rating: season.rating),
      ],
    );
  }
}
