import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/gen/assets.gen.dart';

@RoutePage()
final class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.images.bgSplashScreen.path,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
