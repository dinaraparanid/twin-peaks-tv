import 'dart:async';
import 'dart:js_interop';

import 'package:dartx/dartx.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';

final class AudioOutputWeb {
  const AudioOutputWeb._();

  static Future<Map<String, String>?> getAudioOutputDevice() async {
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
            return {'name': device.label.toDart, 'type': device.outputType};
          })
          .firstOrNull;
    } catch (e) {
      AppLogger.instance.e(e);
      return null;
    }
  }
}

@JS('navigator')
external JSMediaDevicesContainer get navigator;

@JS()
@staticInterop
extension type JSMediaDevicesContainer(JSObject _) implements JSObject {
  external JSMediaDevices? get mediaDevices;
}

@JS()
@staticInterop
extension type JSMediaDevices(JSObject _) implements JSObject {
  external JSPromise<JSArray<JSMediaDeviceInfo>> enumerateDevices();
}

@JS()
@staticInterop
extension type JSMediaDeviceInfo(JSObject _) implements JSObject {
  external JSString get kind;
  external JSString get label;
}

extension AudioOutputType on JSMediaDeviceInfo {
  String get outputType {
    final labelStr = label.toDart;
    if (labelStr.contains('bluetooth')) return 'bluetooth';
    if (labelStr.contains('usb')) return 'usb';
    if (labelStr.contains('hdmi')) return 'hdmi';
    if (labelStr.contains('headphone')) return 'headphones';
    if (labelStr.contains('speaker')) return 'speaker';
    return 'other';
  }
}
