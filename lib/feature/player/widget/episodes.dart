import 'package:flutter/material.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';

final class Episodes extends StatelessWidget {
  const Episodes({super.key});

  @override
  Widget build(BuildContext context) {
    return DpadFocusScope(
      focusScopeNode: context.playerBloc.episodesScopeNode,
      onUp: (_, _, isOutOfScope) {
        if (!isOutOfScope) {
          return KeyEventResult.ignored;
        }

        context.playerBloc.add(
          const ChangeControlsVisibilityEvent(
            visibility: ControlsVisibility.controls,
          ),
        );

        return KeyEventResult.handled;
      },
      // TODO(paranid5): stub
      builder: (_, _) => DpadFocus(
        builder: (_, _) =>
            Container(color: Colors.cyan, width: 800, height: 400),
      ),
    );
  }
}
