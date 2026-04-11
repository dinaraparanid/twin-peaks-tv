import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/switch.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/block.dart';

final class ShowRemainingTimeItem extends StatelessWidget {
  const ShowRemainingTimeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: distinctState((s) => s.properties?.showRemainingTime),
      builder: (context, state) => SettingsItem(
        onClick: () {
          final value = state.properties?.showRemainingTime ?? false;

          context.settingsBloc.add(
            UpdateShowRemainingTimeEvent(showRemainingTime: !value),
          );
        },
        onSelect: (_, _) {
          final value = state.properties?.showRemainingTime ?? false;

          context.settingsBloc.add(
            UpdateShowRemainingTimeEvent(showRemainingTime: !value),
          );

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
        actionBuilder: (context, _) => AppSwitch(
          value: state.properties?.showRemainingTime ?? false,
          onChanged: (value) {
            context.settingsBloc.add(
              UpdateShowRemainingTimeEvent(showRemainingTime: value),
            );
          },
        ),
      ),
    );
  }
}
