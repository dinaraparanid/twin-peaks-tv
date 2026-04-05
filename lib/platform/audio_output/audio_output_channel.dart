import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';
import 'package:twin_peaks_tv/platform/audio_output/audio_output_device.dart';
import 'package:twin_peaks_tv/platform/audio_output/audio_output_web.dart';

final class AudioOutputChannel {
  const AudioOutputChannel._();

  static const _platform = MethodChannel(
    'com.paranid5.twin_peaks_tv/audio_output',
  );

  static Future<AudioOutputDevice?> getAudioOutputDevice() async {
    try {
      final result = await switch (kIsWeb) {
        true => AudioOutputWeb.getAudioOutputDevice(),
        false => _platform.invokeMethod<Map>('getAudioOutputDevice'),
      };

      final json = result?.cast<String, dynamic>();

      if (json == null) {
        return null;
      }

      return AudioOutputDevice.fromJson(json);
    } on PlatformException catch (e) {
      AppLogger.instance.e(e);
      return null;
    }
  }
}
