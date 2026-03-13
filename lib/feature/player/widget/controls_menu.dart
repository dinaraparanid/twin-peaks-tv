import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/utils/ext/key_ext.dart';
import 'package:twin_peaks_tv/core/utils/functions/functions.dart';
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
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Controls(key: _controlsKey),
              Episodes(key: _episodesKey),
            ],
          ),
        );
      },
    );
  }
}
