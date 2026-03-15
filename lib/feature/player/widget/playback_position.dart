import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';

final class PlaybackPosition extends StatelessWidget {
  const PlaybackPosition({super.key});

  static const double _stepSeconds = 10;

  @override
  Widget build(BuildContext context) => switch (AppPlatform.targetPlatform) {
    AppPlatforms.android => const _MaterialPlaybackPosition(),
    AppPlatforms.tizen => const _MaterialPlaybackPosition(),
    AppPlatforms.tvos => const _CupertinoPlaybackPosition(),
    AppPlatforms.webos => const _MaterialPlaybackPosition(),
  };
}

final class _MaterialPlaybackPosition extends StatelessWidget {
  const _MaterialPlaybackPosition();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((s) => (s.position, s.duration)),
      builder: (context, state) => TvSlider(
        focusNode: context.playerBloc.positionNode,
        value: state.position.value.inSeconds.toDouble(),
        max: state.duration.inSeconds.toDouble(),
        step: PlaybackPosition._stepSeconds,
        activeColor: context.appTheme.colors.primary.primary60,
        thumbColor: switch (state.position.isFocused) {
          true => Colors.white,
          false => Colors.grey,
        },
        padding: EdgeInsets.zero,
        onChanged: (value) {
          if (!state.position.isDragging) {
            context.playerBloc.add(const StartPositionDragEvent());
          }

          context.playerBloc.add(
            UpdatePositionEvent(position: Duration(seconds: value.round())),
          );
        },
        onChangeStart: (value) {
          context.playerBloc.add(const StartPositionDragEvent());
        },
        onChangeEnd: (value) {
          context.playerBloc.add(
            SetPositionEvent(position: Duration(seconds: value.round())),
          );
        },
        onUp: (_, _) {
          context.playerBloc.add(const RequestFocusOnControlsMenuEvent());
          return KeyEventResult.handled;
        },
      ),
    );
  }
}

final class _CupertinoPlaybackPosition extends StatelessWidget {
  const _CupertinoPlaybackPosition();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((s) => (s.position, s.duration)),
      builder: (context, state) => CupertinoTvSlider(
        focusNode: context.playerBloc.positionNode,
        value: state.position.value.inSeconds.toDouble(),
        max: state.duration.inSeconds.toDouble(),
        step: PlaybackPosition._stepSeconds,
        activeColor: context.appTheme.colors.primary.primary60,
        thumbColor: switch (state.position.isFocused) {
          true => CupertinoColors.white,
          false => CupertinoColors.systemGrey,
        },
        onChanged: (value) {
          if (!state.position.isDragging) {
            context.playerBloc.add(const StartPositionDragEvent());
          }

          context.playerBloc.add(
            UpdatePositionEvent(position: Duration(seconds: value.round())),
          );
        },
        onChangeStart: (value) {
          context.playerBloc.add(const StartPositionDragEvent());
        },
        onChangeEnd: (value) {
          context.playerBloc.add(
            SetPositionEvent(position: Duration(seconds: value.round())),
          );
        },
        onUp: (_, _) {
          context.playerBloc.add(const RequestFocusOnControlsMenuEvent());
          return KeyEventResult.handled;
        },
      ),
    );
  }
}
