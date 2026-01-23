import 'package:flutter/material.dart';
import 'package:twin_peaks_tv/app.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/router/app_router.dart';

void main() {
  final getIt = configureDependencies();
  runApp(App(appRouter: getIt<AppRouter>()));
}
