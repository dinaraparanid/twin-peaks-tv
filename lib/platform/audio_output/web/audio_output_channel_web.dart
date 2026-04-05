import 'dart:async';
import 'dart:js_interop';

import 'package:dartx/dartx.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';
import 'package:twin_peaks_tv/platform/audio_output/audio_output_device.dart';
import 'package:twin_peaks_tv/platform/audio_output/web/audio_output_interop.dart';

final class AudioOutputChannel {
  const AudioOutputChannel._();

  static Future<AudioOutputDevice?> getAudioOutputDevice() async {
    try {
      final mediaDevices = navigator.mediaDevices;

      if (mediaDevices == null) {
        return null;
      }

      final jsDevices = await mediaDevices.enumerateDevices().toDart;
      final deviceList = jsDevices.toDart;

      return deviceList
          .where((device) => device.kind.toDart == 'audiooutput')
          .map((device) {
            return AudioOutputDevice(
              name: device.label.toDart,
              type: device.outputType,
            );
          })
          .firstOrNull;
    } catch (e) {
      AppLogger.instance.e(e);
      return null;
    }
  }
}
