import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/utils/ext/key_ext.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/player/widget/controls/controls.dart';
import 'package:twin_peaks_tv/feature/player/widget/episode/episodes.dart';

final class PositionedPlaybackMenu extends StatefulWidget {
  const PositionedPlaybackMenu({super.key});

  @override
  State<StatefulWidget> createState() => _PositionedPlaybackMenuState();
}

final class _PositionedPlaybackMenuState extends State<PositionedPlaybackMenu> {
  late final _controlsKey = GlobalKey();
  late final _episodesKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((x) => (x.controlsVisibility, x.entry)),
      builder: (context, state) {
        final entry = state.entry;

        final child = Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.s,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 64.s),
              child: Controls(key: _controlsKey),
            ),

            if (entry is PlayerEntrySeason)
              Episodes(key: _episodesKey, episodes: entry.episodes),
          ],
        );

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          left: 0,
          right: 0,
          top: switch (state.controlsVisibility) {
            ControlsVisibility.hidden ||
            ControlsVisibility.topBar => screenHeight,

            ControlsVisibility.controls =>
              screenHeight - (_controlsKey.size?.height ?? 0) - 80.s,

            ControlsVisibility.episodes =>
              screenHeight -
                  (_controlsKey.size?.height ?? 0) -
                  (_episodesKey.size?.height ?? 0) -
                  32.s,
          },
          child: switch (AppPlatform.isTvOS) {
            true => child,
            false => Material(color: Colors.transparent, child: child),
          },
        );
      },
    );
  }
}
