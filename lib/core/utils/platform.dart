import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_tizen/flutter_tizen.dart' as tizen;

const _manualPlatform = null;

final class AppPlatform {
  const AppPlatform._();

  static bool get isAndroid => targetPlatform == AppPlatforms.android;

  static bool get isTizen => targetPlatform == AppPlatforms.tizen;

  static AppPlatforms get targetPlatform {
    // ignore: unnecessary_null_comparison
    if (_manualPlatform != null) return _manualPlatform;
    if (kIsWeb) return AppPlatforms.webos;
    // ignore: dead_code
    if (Platform.isAndroid) return AppPlatforms.android;
    if (tizen.isTizen) return AppPlatforms.tizen;
    if (Platform.isIOS) return AppPlatforms.tvos;
    return AppPlatforms.webos;
  }
}

enum AppPlatforms { android, tizen, tvos, webos }
