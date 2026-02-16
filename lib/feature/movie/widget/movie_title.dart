import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

final class MovieTitle extends StatelessWidget {
  const MovieTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.appTheme.typography.movieInfo.title.copyWith(
        color: context.appTheme.colors.text.primary,
      ),
    );
  }
}
