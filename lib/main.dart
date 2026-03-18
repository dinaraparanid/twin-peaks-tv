import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twin_peaks_tv/app.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';
import 'package:twin_peaks_tv/core/router/app_router.dart';
import 'package:twin_peaks_tv/core/utils/ssl_overrides.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) {
        AppLogger.instance.e('Flutter error: ${details.exception}');
      };

      PlatformDispatcher.instance.onError = (e, st) {
        AppLogger.instance.e('PlatformDispatcher error: $e\n$st');
        return true;
      };

      HttpOverrides.global = SSLOverrides();
      final getIt = configureDependencies();
      runApp(App(router: getIt<AppRouter>()));
    },
    (e, st) {
      AppLogger.instance.e('Zone guarded error: $e\n$st');
    },
  );
}
