import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/block.dart';
import 'package:twin_peaks_tv/feature/settings/widget/playback/audio_output_device.dart';
import 'package:twin_peaks_tv/feature/settings/widget/playback/show_remaining_time.dart';
import 'package:twin_peaks_tv/feature/settings/widget/playback/switch_to_next_episode.dart';

final class Playback extends StatelessWidget {
  const Playback({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: distinctState((s) => s.audioOutputDevice != null),
      builder: (context, state) => SettingsBlock(
        label: context.ln.settings_playback_label,
        children: [
          const SwitchToNextEpisodeItem(),
          if (state.audioOutputDevice != null) const AudioOutputDeviceItem(),
          const ShowRemainingTimeItem(),
        ],
      ),
    );
  }
}
