import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

@singleton
final class OpenUrlUseCase {
  const OpenUrlUseCase();

  Future<void> call({
    required String url,
    required FutureOr<void> Function() onFailure,
  }) async {
    try {
      if (!await launchUrl(Uri.parse(url))) {
        await onFailure();
      }
    } catch (e) {
      AppLogger.instance.e(e);
      await onFailure();
    }
  }
}
