import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/ext/format.dart';
import 'package:twin_peaks_tv/core/utils/functions/functions.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/player/widget/playback_position.dart';
import 'package:twin_peaks_tv/feature/player/widget/speed.dart';
import 'package:twin_peaks_tv/feature/player/widget/volume.dart';

final class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    return DpadFocusScope(
      focusScopeNode: context.playerBloc.controlsScopeNode,
      onUp: (_, _, isOutOfScope) {
        if (!isOutOfScope) {
          return KeyEventResult.ignored;
        }

        context.playerBloc.add(
          const ChangeControlsVisibilityEvent(
            visibility: ControlsVisibility.hidden,
          ),
        );

        return KeyEventResult.handled;
      },
      onDown: (_, _, isOutOfScope) {
        if (!isOutOfScope) {
          return KeyEventResult.ignored;
        }

        context.playerBloc.add(
          const ChangeControlsVisibilityEvent(
            visibility: ControlsVisibility.episodes,
          ),
        );

        return KeyEventResult.handled;
      },
      onSelect: (_, _) {
        context.playerBloc.add(const PlayPauseEvent());
        return KeyEventResult.handled;
      },
      builder: (_, _) {
        final radius = BorderRadius.all(Radius.circular(24.r));

        return AnimatedSelectionBorders(
          borderRadius: radius,
          builder: (context) =>
              ClipRRect(borderRadius: radius, child: const _MaterialContent()),
        );
      },
    );
  }
}

final class _MaterialContent extends StatelessWidget {
  const _MaterialContent();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.s, vertical: 12.s),
        decoration: BoxDecoration(
          color: context.appTheme.colors.background.primary60,
        ),
        child: const _Content(),
      ),
    );
  }
}

final class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _MenuNode(),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: 24.s,
              children: const [
                Volume(),
                Expanded(child: _VideoTitle()),
                Speed(),
              ],
            ),

            SizedBox(height: 16.s),

            Row(
              spacing: 24.s,
              children: const [
                _Position(),
                Expanded(child: PlaybackPosition()),
                _Duration(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

final class _MenuNode extends StatelessWidget {
  const _MenuNode();

  @override
  Widget build(BuildContext context) {
    return DpadFocus(
      focusNode: context.playerBloc.controlsMenuNode,
      onLeft: (_, _) {
        context.playerBloc.add(const RequestFocusOnVolumeEvent());
        return KeyEventResult.handled;
      },
      onRight: (_, _) {
        context.playerBloc.add(const RequestFocusOnSpeedEvent());
        return KeyEventResult.handled;
      },
      onDown: (_, _) {
        context.playerBloc.add(const RequestFocusOnPositionEvent());
        return KeyEventResult.handled;
      },
      onFocusChanged: (_, hasFocus) async {
        await AnimatedSelectionBorders.of(
          context,
        ).controller.setSelected(hasFocus);
      },
      builder: (_, _) => const SizedBox(),
    );
  }
}

final class _VideoTitle extends StatelessWidget {
  const _VideoTitle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((s) => s.entry.videoTitle),
      builder: (context, state) => Text(
        state.entry.videoTitle,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: context.appTheme.typography.player.videoTitle.copyWith(
          color: context.appTheme.colors.text.primary,
        ),
      ),
    );
  }
}

final class _Position extends StatelessWidget {
  const _Position();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((s) => s.position),
      builder: (context, state) => Text(
        state.position.value.toTimestampFormat(),
        style: context.appTheme.typography.player.timestamp.copyWith(
          color: context.appTheme.colors.text.secondary,
        ),
      ),
    );
  }
}

final class _Duration extends StatelessWidget {
  const _Duration();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((s) => s.duration),
      builder: (context, state) => Text(
        state.duration.toTimestampFormat(),
        style: context.appTheme.typography.player.timestamp.copyWith(
          color: context.appTheme.colors.text.secondary,
        ),
      ),
    );
  }
}
