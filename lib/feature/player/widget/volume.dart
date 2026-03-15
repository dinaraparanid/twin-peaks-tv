import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';

final class Volume extends StatelessWidget {
  const Volume({super.key});

  @override
  Widget build(BuildContext context) {
    return switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => const _MaterialVolume(),
      AppPlatforms.tizen => const _MaterialVolume(),
      AppPlatforms.tvos => const _CupertinoVolume(),
      AppPlatforms.webos => const _MaterialVolume(),
    };
  }
}

final class _MaterialVolume extends StatelessWidget {
  const _MaterialVolume();

  static IconData _buildVolumeIcon(double volume) {
    if (volume == 0) return Icons.volume_off;
    if (volume < 0.5) return Icons.volume_mute;
    if (volume < 1) return Icons.volume_down;
    return Icons.volume_up;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((s) => s.volume),
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 12.s,
        children: [
          Icon(
            _buildVolumeIcon(state.volume.value),
            size: 24.s,
            color: context.appTheme.colors.text.secondary,
          ),

          SizedBox(
            width: 100.s,
            child: TvSlider(
              focusNode: context.playerBloc.volumeNode,
              value: state.volume.value,
              step: 0.1,
              label: state.volume.value.toStringAsFixed(1),
              activeColor: context.appTheme.colors.primary.primary60,
              thumbColor: switch (state.volume.isFocused) {
                true => Colors.white,
                false => Colors.grey,
              },
              padding: EdgeInsets.zero,
              onChanged: (value) {
                context.playerBloc.add(UpdateVolumeEvent(volume: value));
              },
              onChangeStart: (value) {
                context.playerBloc.add(const StartVolumeDragEvent());
              },
              onChangeEnd: (value) {
                context.playerBloc.add(SetVolumeEvent(volume: value));
              },
              onRight: (_, _) {
                context.playerBloc.add(const RequestFocusOnControlsMenuEvent());
                return KeyEventResult.handled;
              },
            ),
          ),
        ],
      ),
    );
  }
}

final class _CupertinoVolume extends StatelessWidget {
  const _CupertinoVolume();

  static IconData _buildVolumeIcon(double volume) {
    if (volume == 0) return CupertinoIcons.volume_off;
    if (volume < 0.5) return CupertinoIcons.volume_mute;
    if (volume < 1) return CupertinoIcons.volume_down;
    return CupertinoIcons.volume_up;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((s) => s.volume),
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 12.s,
        children: [
          Icon(
            _buildVolumeIcon(state.volume.value),
            size: 24.s,
            color: context.appTheme.colors.text.secondary,
          ),

          SizedBox(
            width: 100.s,
            child: CupertinoTvSlider(
              focusNode: context.playerBloc.volumeNode,
              value: state.volume.value,
              step: 0.1,
              activeColor: context.appTheme.colors.primary.primary60,
              thumbColor: switch (state.volume.isFocused) {
                true => CupertinoColors.white,
                false => CupertinoColors.systemGrey,
              },
              onChanged: (value) {
                context.playerBloc.add(UpdateVolumeEvent(volume: value));
              },
              onChangeStart: (value) {
                context.playerBloc.add(const StartVolumeDragEvent());
              },
              onChangeEnd: (value) {
                context.playerBloc.add(SetVolumeEvent(volume: value));
              },
              onRight: (_, _) {
                context.playerBloc.add(const RequestFocusOnControlsMenuEvent());
                return KeyEventResult.handled;
              },
              onDown: (_, _) {
                context.playerBloc.add(const RequestFocusOnPositionEvent());
                return KeyEventResult.handled;
              },
            ),
          ),
        ],
      ),
    );
  }
}
