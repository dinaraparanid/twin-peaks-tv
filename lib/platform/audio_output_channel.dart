import 'package:flutter/services.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';

final class AudioOutputChannel {
  const AudioOutputChannel._();

  static const _platform = MethodChannel(
    'com.paranid5.twin_peaks_tv/audio_output',
  );

  static Future<String?> getAudioOutputDevice() async {
    try {
      return await _platform.invokeMethod<String>('getAudioOutputDevice');
    } on PlatformException catch (e) {
      AppLogger.instance.e(e);
      return null;
    }
  }
}
