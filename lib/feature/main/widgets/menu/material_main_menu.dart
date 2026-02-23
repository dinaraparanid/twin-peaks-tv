import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

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
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 24.s, bottom: 8.s, left: 8.s, right: 8.s),
        child: child,
      ),
    );
  }
}
