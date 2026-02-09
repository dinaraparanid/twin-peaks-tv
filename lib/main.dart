import 'dart:io';

import 'package:flutter/material.dart';
import 'package:twin_peaks_tv/app.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/router/app_router.dart';
import 'package:twin_peaks_tv/core/utils/ssl_overrides.dart';

void main() {
  HttpOverrides.global = SSLOverrides();
  final getIt = configureDependencies();
  runApp(App(router: getIt<AppRouter>()));
}
