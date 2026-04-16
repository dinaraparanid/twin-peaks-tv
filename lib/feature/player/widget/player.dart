import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/utils/functions/functions.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';
import 'package:video_player/video_player.dart';

final class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    return DpadFocus(
      autofocus: true,
      focusNode: context.playerBloc.playerNode,
      onSelect: (_, _) {
        context.playerBloc.add(const PlayPauseEvent());
        return KeyEventResult.handled;
      },
      onUp: (_, _) {
        context.playerBloc.add(
          const ChangeControlsVisibilityEvent(
            visibility: ControlsVisibility.topBar,
          ),
        );
        return KeyEventResult.handled;
      },
      onDown: (_, _) {
        context.playerBloc.add(
          const ChangeControlsVisibilityEvent(
            visibility: ControlsVisibility.controls,
          ),
        );
        return KeyEventResult.handled;
      },
      builder: (context, _) => BlocBuilder<PlayerBloc, PlayerState>(
        buildWhen: distinctState((s) => s.entry),
        builder: (context, _) => VideoPlayer(context.playerBloc.controller),
      ),
    );
  }
}
