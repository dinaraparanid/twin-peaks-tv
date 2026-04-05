import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/block.dart';
import 'package:twin_peaks_tv/platform/audio_output/audio_output_device.dart';

final class AudioOutputDeviceItem extends StatelessWidget {
  const AudioOutputDeviceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: distinctState((s) => s.audioOutputDevice),
      builder: (context, state) => switch (state.audioOutputDevice) {
        null => const SizedBox(),
        final device => _Content(device: device),
      },
    );
  }
}

final class _Content extends StatelessWidget {
  const _Content({required this.device});
  final AudioOutputDevice device;

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      iconBuilder: (context, _) => Icon(
        switch (AppPlatform.isTvOS) {
          true => CupertinoIcons.tv_music_note,
          false => Icons.music_video_rounded,
        },
        color: context.appTheme.colors.text.primary,
        size: 20.s,
      ),
      titleBuilder: (context, _) => Text(
        context.ln.settings_playback_audio_output_device,
        style: context.appTheme.typography.settings.property.copyWith(
          color: context.appTheme.colors.text.primary,
        ),
      ),
      actionBuilder: (context, _) {
        final deviceName = device.name
            .split('_')
            .map((it) => it.capitalize())
            .join(' ');

        return Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.s,
          children: [
            Text(
              deviceName.isEmpty ? 'Default' : deviceName,
              style: context.appTheme.typography.settings.property.copyWith(
                color: context.appTheme.colors.primary.primary80,
              ),
            ),

            _DeviceIcon(deviceType: device.type),
          ],
        );
      },
    );
  }
}

final class _DeviceIcon extends StatelessWidget {
  const _DeviceIcon({required this.deviceType});
  final AudioOutputDeviceType deviceType;

  @override
  Widget build(BuildContext context) {
    return Icon(
      switch ((AppPlatform.isTvOS, deviceType)) {
        (true, AudioOutputDeviceType.bluetooth) => CupertinoIcons.bluetooth,
        (false, AudioOutputDeviceType.bluetooth) => Icons.bluetooth,
        (true, AudioOutputDeviceType.headphones) => CupertinoIcons.headphones,
        (false, AudioOutputDeviceType.headphones) => Icons.headset_rounded,
        (_, AudioOutputDeviceType.usb) => Icons.usb,
        (_, AudioOutputDeviceType.hdmi) => Icons.settings_input_hdmi_rounded,
        (true, _) => CupertinoIcons.volume_up,
        (false, _) => Icons.volume_up_rounded,
      },
      color: context.appTheme.colors.primary.primary80,
      size: 24.s,
    );
  }
}
