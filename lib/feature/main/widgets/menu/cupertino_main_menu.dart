import 'package:flutter/cupertino.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';

final class CupertinoMainMenu extends StatelessWidget {
  const CupertinoMainMenu({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassLayer(
      settings: AppLiquidGlass.defaultSettings(context),
      child: FakeGlass(
        shape: LiquidRoundedRectangle(borderRadius: 24.r),
        child: Padding(
          padding: EdgeInsets.only(
            top: 32.s,
            bottom: 24.s,
            left: 8.s,
            right: 8.s,
          ),
          child: child,
        ),
      ),
    );
  }
}
