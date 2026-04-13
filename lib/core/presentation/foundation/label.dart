import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';

final class AppLabel extends StatelessWidget {
  const AppLabel({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.appTheme.typography.general.label.copyWith(
        color: context.appTheme.colors.text.primary,
      ),
    );
  }
}
