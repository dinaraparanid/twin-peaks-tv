import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

final class SeasonTitle extends StatelessWidget {
  const SeasonTitle({super.key, required this.title});
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
