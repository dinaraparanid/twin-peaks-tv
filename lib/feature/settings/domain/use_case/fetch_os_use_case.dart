import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_info_plus_tizen/device_info_plus_tizen.dart';
import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';

@singleton
final class FetchOSUseCase {
  const FetchOSUseCase();

  Future<void> call({
    required FutureOr<void> Function(String os) onSuccess,
    required FutureOr<void> Function() onFailure,
  }) async {
    try {
      final os = await switch (AppPlatform.realPlatform) {
        AppPlatforms.android => DeviceInfoPlugin().androidInfo.then((value) {
          return 'Android TV ${value.version.release}';
        }),

        AppPlatforms.tizen => DeviceInfoPluginTizen().tizenInfo.then((value) {
          final version = value.platformVersion;
          return version != null ? 'Tizen $version' : 'Tizen';
        }),

        // TODO(paranid5): tvos plugin
        AppPlatforms.tvos => DeviceInfoPlugin().iosInfo.then((value) {
          return 'Apple TV ${value.systemVersion}';
        }),

        // TODO(paranid5): webos plugin
        AppPlatforms.webos => DeviceInfoPlugin().webBrowserInfo.then((value) {
          final version = value.appVersion;
          return version != null ? 'webOS $version' : 'webOS';
        }),
      };

      await onSuccess(os);
    } catch (e) {
      AppLogger.instance.e(e);
      await onFailure();
    }
  }
}
