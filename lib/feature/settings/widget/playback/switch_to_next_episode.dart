import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/switch.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/block.dart';

final class SwitchToNextEpisodeItem extends StatelessWidget {
  const SwitchToNextEpisodeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: distinctState((s) => s.properties?.switchToNextEpisode),
      builder: (context, state) => SettingsItem(
        focusNode: context.settingsBloc.switchToNextEpisodeNode,
        onSelect: (_, _) {
          final value = state.properties?.switchToNextEpisode ?? false;

          context.settingsBloc.add(
            UpdateSwitchToNextEpisodeEvent(switchToNextEpisode: !value),
          );

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
              size: 12.s,
              color: context.appTheme.colors.background.primary,
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
        actionBuilder: (context, _) => AppSwitch(
          value: state.properties?.switchToNextEpisode ?? false,
          onChanged: (value) {
            context.settingsBloc.add(
              UpdateSwitchToNextEpisodeEvent(switchToNextEpisode: value),
            );
          },
        ),
      ),
    );
  }
}
