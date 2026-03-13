import 'package:flutter/material.dart';
import 'package:tv_plus/tv_plus.dart';
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
      // TODO(paranid5): stub
      builder: (_, _) => DpadFocus(
        builder: (_, _) =>
            Container(color: Colors.pink, width: 400, height: 200),
      ),
    );
  }
}
