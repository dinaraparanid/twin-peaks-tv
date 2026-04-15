import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/bloc/bloc.dart';

final class ClearRecentButton extends StatelessWidget {
  const ClearRecentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFocusSelectionBorders(
      paddingBuilder: (context, animationValue) {
        return EdgeInsets.all(lerpDouble(0, 8.s, animationValue)!);
      },
      onUp: (_, _) {
        context.encyclopediaBloc.add(const FocusOnSearchFieldEvent());
        return KeyEventResult.handled;
      },
      onDown: (_, _) {
        context.encyclopediaBloc.add(const FocusOnBrowseEvent());
        return KeyEventResult.handled;
      },
      onSelect: (_, _) {
        context.encyclopediaBloc.add(const ClearRecentsEvent());
        return KeyEventResult.handled;
      },
      builder: (context, focusNode, animation) => Text(
        context.ln.encyclopedia_recent_clear,
        style: context.appTheme.typography.encyclopedia.action.copyWith(
          color: context.appTheme.colors.text.secondary,
        ),
      ),
    );
  }
}
