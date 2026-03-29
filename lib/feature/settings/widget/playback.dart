import 'package:flutter/cupertino.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/block.dart';

final class Playback extends StatelessWidget {
  const Playback({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsBlock(
      label: context.ln.settings_playback_label,
      children: [
        SettingsItem(
          focusNode: context.settingsBloc.switchToNextEpisodeNode,
          onUp: (_, _) {
            context.settingsBloc.textScaleNode.requestFocus();
            return KeyEventResult.handled;
          },
          onDown: (_, _) {
            context.settingsBloc.showRemainingTimeNode.requestFocus();
            return KeyEventResult.handled;
          },
          iconBuilder: (context, _) => switch (AppPlatform.isTvOS) {
            true => Container(
              padding: EdgeInsets.all(4.s),
              decoration: BoxDecoration(
                color: context.appTheme.colors.text.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.forward_end_fill,
                size: 16.s,
                color: context.appTheme.colors.settings.block,
              ),
            ),

            false => Assets.icons.switchNext.svg(
              width: 20.s,
              height: 20.s,
              fit: BoxFit.cover,
            ),
          },
          titleBuilder: (context, _) => Text(
            context.ln.settings_playback_switch_to_next_episode,
            style: context.appTheme.typography.settings.property.copyWith(
              color: context.appTheme.colors.text.primary,
            ),
          ),
          actionBuilder: (context, _) => const SizedBox(),
        ),

        SettingsItem(
          focusNode: context.settingsBloc.showRemainingTimeNode,
          onUp: (_, _) {
            context.settingsBloc.switchToNextEpisodeNode.requestFocus();
            return KeyEventResult.handled;
          },
          onDown: (_, _) {
            context.settingsBloc.faqNode.requestFocus();
            return KeyEventResult.handled;
          },
          iconBuilder: (context, _) => switch (AppPlatform.isTvOS) {
            true => Icon(
              CupertinoIcons.time,
              color: context.appTheme.colors.text.primary,
              size: 20.s,
            ),

            false => Assets.icons.time.svg(
              width: 20.s,
              height: 20.s,
              fit: BoxFit.cover,
              colorFilter: context.appTheme.colors.text.primary.toColorFilter(),
            ),
          },
          titleBuilder: (context, _) => Text(
            context.ln.settings_playback_show_remaining_time,
            style: context.appTheme.typography.settings.property.copyWith(
              color: context.appTheme.colors.text.primary,
            ),
          ),
          actionBuilder: (context, _) => const SizedBox(),
        ),
      ],
    );
  }
}
