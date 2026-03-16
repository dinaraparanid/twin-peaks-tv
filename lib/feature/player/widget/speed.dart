import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';

final class Speed extends StatelessWidget {
  const Speed({super.key});

  static const _divisions = 6;
  static const _minSpeed = 0.5;
  static const _maxSpeed = 2.0;

  @override
  Widget build(BuildContext context) => switch (AppPlatform.targetPlatform) {
    AppPlatforms.android => const _MaterialSpeed(),
    AppPlatforms.tizen => const _MaterialSpeed(),
    AppPlatforms.tvos => const _CupertinoSpeed(),
    AppPlatforms.webos => const _MaterialSpeed(),
  };
}

final class _MaterialSpeed extends StatelessWidget {
  const _MaterialSpeed();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((s) => s.speed),
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 12.s,
        children: [
          Icon(
            Icons.speed,
            size: 24.s,
            color: context.appTheme.colors.text.secondary,
          ),

          SizedBox(
            width: 100.s,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                year2023: false,
                trackHeight: 8.s,
                thumbSize: WidgetStateProperty.fromMap({
                  WidgetState.focused: Size(2.s, 24.s),
                  WidgetState.any: Size(4.s, 24.s),
                }),
              ),
              child: TvSlider(
                focusNode: context.playerBloc.speedNode,
                value: state.speed.value,
                divisions: Speed._divisions,
                min: Speed._minSpeed,
                max: Speed._maxSpeed,
                label: state.speed.value.toStringAsFixed(2),
                showValueIndicator: ShowValueIndicator.never,
                activeColor: context.appTheme.colors.primary.primary60,
                thumbColor: switch (state.speed.isFocused) {
                  true => Colors.white,
                  false => Colors.grey,
                },
                padding: EdgeInsets.zero,
                onChanged: (value) {
                  if (!state.speed.isDragging) {
                    context.playerBloc.add(const StartSpeedDragEvent());
                  }

                  context.playerBloc.add(UpdateSpeedEvent(speed: value));
                },
                onChangeStart: (value) {
                  context.playerBloc.add(const StartSpeedDragEvent());
                },
                onChangeEnd: (value) {
                  context.playerBloc.add(SetSpeedEvent(speed: value));
                },
                onLeft: (_, _) {
                  context.playerBloc.add(
                    const RequestFocusOnControlsMenuEvent(),
                  );
                  return KeyEventResult.handled;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _CupertinoSpeed extends StatelessWidget {
  const _CupertinoSpeed();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((s) => s.speed),
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 12.s,
        children: [
          Icon(
            CupertinoIcons.speedometer,
            size: 24.s,
            color: context.appTheme.colors.text.secondary,
          ),

          SizedBox(
            width: 100.s,
            child: CupertinoTvSlider(
              focusNode: context.playerBloc.speedNode,
              value: state.speed.value,
              divisions: Speed._divisions,
              min: Speed._minSpeed,
              max: Speed._maxSpeed,
              activeColor: context.appTheme.colors.primary.primary60,
              thumbColor: switch (state.speed.isFocused) {
                true => CupertinoColors.white,
                false => CupertinoColors.systemGrey,
              },
              onChanged: (value) {
                context.playerBloc.add(UpdateSpeedEvent(speed: value));
              },
              onChangeStart: (value) {
                context.playerBloc.add(const StartSpeedDragEvent());
              },
              onChangeEnd: (value) {
                context.playerBloc.add(SetSpeedEvent(speed: value));
              },
              onLeft: (_, _) {
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
