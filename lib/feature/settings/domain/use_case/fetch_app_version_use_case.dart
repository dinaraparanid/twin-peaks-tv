import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';

@singleton
final class FetchAppVersionUseCase {
  const FetchAppVersionUseCase();

  Future<void> call({
    required FutureOr<void> Function(String version) onSuccess,
    required FutureOr<void> Function() onFailure,
  }) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      await onSuccess(packageInfo.version);
    } catch (e) {
      AppLogger.instance.e(e);
      await onFailure();
    }
  }
}
