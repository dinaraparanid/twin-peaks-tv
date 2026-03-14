import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/utils/ext/key_ext.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/player/widget/controls.dart';
import 'package:twin_peaks_tv/feature/player/widget/episodes.dart';

final class PositionedControlsMenu extends StatefulWidget {
  const PositionedControlsMenu({super.key});

  @override
  State<StatefulWidget> createState() => _PositionedControlsMenuState();
}

final class _PositionedControlsMenuState extends State<PositionedControlsMenu> {
  late final _controlsKey = GlobalKey();
  late final _episodesKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((x) => x.controlsVisibility),
      builder: (context, state) {
        final child = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 64.s),
              child: Controls(key: _controlsKey),
            ),

            SizedBox(height: 16.s),

            Episodes(key: _episodesKey),
          ],
        );

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          left: 0,
          right: 0,
          top: switch (state.controlsVisibility) {
            ControlsVisibility.hidden => screenHeight,

            ControlsVisibility.controls =>
              screenHeight - (_controlsKey.size?.height ?? 0) - 64.s,

            ControlsVisibility.episodes =>
              screenHeight -
                  (_controlsKey.size?.height ?? 0) -
                  (_episodesKey.size?.height ?? 0) -
                  64.s,
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
