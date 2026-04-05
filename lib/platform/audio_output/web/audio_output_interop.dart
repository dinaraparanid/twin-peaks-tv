import 'dart:js_interop';

import 'package:twin_peaks_tv/platform/audio_output/audio_output_device.dart';

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

extension AudioOutputTypeMapper on JSMediaDeviceInfo {
  AudioOutputDeviceType get outputType {
    final labelStr = label.toDart;
    if (labelStr.contains('bluetooth')) return AudioOutputDeviceType.bluetooth;
    if (labelStr.contains('usb')) return AudioOutputDeviceType.usb;
    if (labelStr.contains('hdmi')) return AudioOutputDeviceType.hdmi;
    if (labelStr.contains('headphone')) return AudioOutputDeviceType.headphones;
    if (labelStr.contains('speaker')) return AudioOutputDeviceType.speaker;
    return AudioOutputDeviceType.other;
  }
}
