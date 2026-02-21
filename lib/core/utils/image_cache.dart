import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';

Future<void> cacheAssetImages(BuildContext context) async {
  await precacheImage(AssetImage(Assets.images.bgSplashScreen.path), context);
}
