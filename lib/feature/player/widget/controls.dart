import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/ext/format.dart';
import 'package:twin_peaks_tv/core/utils/functions/functions.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';

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
      builder: (_, _) => DpadFocus(builder: (_, _) => const _MaterialContent()),
    );
  }
}

final class _MaterialContent extends StatelessWidget {
  const _MaterialContent();

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.all(Radius.circular(24.r));

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.s, vertical: 12.s),
          decoration: BoxDecoration(
            color: context.appTheme.colors.background.primary60,
            borderRadius: radius,
          ),
          child: const _Content(),
        ),
      ),
    );
  }
}

final class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          spacing: 8.s,
          children: const [
            SizedBox(), // TODO(paranid5): volume
            Expanded(child: _VideoTitle()),
            SizedBox(), // TODO(paranid5): speed
          ],
        ),

        SizedBox(height: 16.s),

        Row(
          spacing: 8.s,
          children: const [
            _Position(),
            Expanded(child: SizedBox()), // TODO(paranid5): progress
            _Duration(),
          ],
        ),
      ],
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
        state.position.toTimestampFormat(),
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
