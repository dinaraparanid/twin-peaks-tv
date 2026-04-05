import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_output_device.freezed.dart';
part 'audio_output_device.g.dart';

@freezed
abstract class AudioOutputDevice with _$AudioOutputDevice {
  const factory AudioOutputDevice({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'type') required AudioOutputDeviceType type,
  }) = _AudioOutputDevice;

  factory AudioOutputDevice.fromJson(Map<String, dynamic> json) =>
      _$AudioOutputDeviceFromJson(json);
}

enum AudioOutputDeviceType { speaker, bluetooth, usb, hdmi, headphones, other }
