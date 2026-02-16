import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/ext/format.dart';

final class MovieProperties extends StatelessWidget {
  const MovieProperties({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.ln.movie_year_duration_rating(
            movie.year,
            movie.durationMinutes.toDurationFormat(),
          ),
          style: context.appTheme.typography.movieInfo.properties.copyWith(
            color: context.appTheme.colors.text.tertiary,
          ),
        ),
        StarRating(rating: movie.rating),
      ],
    );
  }
}
