import 'package:flutter/material.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';

final class MaterialMainMenu extends StatelessWidget {
  const MaterialMainMenu({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0, 0.5, 1],
          colors: [
            context.appTheme.colors.background.primary,
            context.appTheme.colors.background.primary80,
            context.appTheme.colors.background.primary01,
          ],
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(20), child: child),
    );
  }
}
