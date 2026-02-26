import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

final class OneUiMainMenu extends StatelessWidget {
  const OneUiMainMenu({
    super.key,
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final collapsedGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: const [0, 0.75, 1],
      colors: [
        context.appTheme.colors.background.primary,
        context.appTheme.colors.background.primary,
        context.appTheme.colors.background.primary01,
      ],
    );

    final expandGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: const [0, 0.75, 1],
      colors: [
        context.appTheme.colors.background.primary,
        context.appTheme.colors.background.primary,
        context.appTheme.colors.background.secondary,
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: Gradient.lerp(
                collapsedGradient,
                expandGradient,
                animation.value,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 48.s, bottom: 20.s),
              child: child,
            ),
          ),
        ),

        Opacity(
          opacity: 0.8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: context.appTheme.colors.gradients.oneUiMainMenuBorder,
            ),
            child: SizedBox(width: 2.s),
          ),
        ),
      ],
    );
  }
}
