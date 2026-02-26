import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

final class AppLiquidGlass {
  const AppLiquidGlass._();

  static LiquidGlassSettings defaultSettings(BuildContext context) {
    return LiquidGlassSettings.figma(
      refraction: 80,
      depth: 20,
      dispersion: 50,
      frost: 50,
      glassColor: context.appTheme.colors.cupertino.background,
    );
  }
}
