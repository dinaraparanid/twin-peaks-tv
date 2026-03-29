import 'package:flutter/cupertino.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/block.dart';
import 'package:twin_peaks_tv/feature/settings/widget/playback/show_remaining_time.dart';
import 'package:twin_peaks_tv/feature/settings/widget/playback/switch_to_next_episode.dart';

final class Playback extends StatelessWidget {
  const Playback({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsBlock(
      label: context.ln.settings_playback_label,
      children: const [SwitchToNextEpisodeItem(), ShowRemainingTimeItem()],
    );
  }
}
