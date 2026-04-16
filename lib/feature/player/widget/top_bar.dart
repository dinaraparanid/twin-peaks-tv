import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/back_button.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';

final class PositionedTopBar extends StatelessWidget {
  const PositionedTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: distinctState((x) => x.controlsVisibility),
      builder: (context, state) {
        final child = DpadFocusScope(
          focusScopeNode: context.playerBloc.topBarScopeNode,
          onDown: (_, _, isOutOfScope) {
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
          builder: (context, _) => DecoratedBox(
            decoration: BoxDecoration(
              gradient: context.appTheme.colors.gradients.topBarScrim,
            ),
            child: Row(
              children: [
                SizedBox(width: 32.s),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.s),
                  child: AppBackButton(
                    focusNode: context.playerBloc.backButtonNode,
                    onClick: context.pop,
                    onSelect: (_, _) {
                      context.pop();
                      return KeyEventResult.handled;
                    },
                  ),
                ),
              ],
            ),
          ),
        );

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          left: 0,
          right: 0,
          top: switch (state.controlsVisibility) {
            ControlsVisibility.hidden ||
            ControlsVisibility.controls ||
            ControlsVisibility.episodes => -64.s,

            ControlsVisibility.topBar => 0,
          },
          child: child,
        );
      },
    );
  }
}
