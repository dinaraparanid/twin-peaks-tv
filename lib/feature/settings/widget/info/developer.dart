import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';

final class Developer extends StatelessWidget {
  const Developer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFocusSelectionBorders(
      focusNode: context.settingsBloc.developerNode,
      autofocus: true,
      autoscroll: true,
      paddingBuilder: (animationValue) {
        return EdgeInsets.all(lerpDouble(0, 8.s, animationValue)!);
      },
      onSelect: (_, _) {
        context.settingsBloc.add(const OpenDeveloperEvent());
        return KeyEventResult.handled;
      },
      onDown: (_, _) {
        context.settingsBloc.add(const RequestFocusOnLanguageEvent());
        return KeyEventResult.handled;
      },
      builder: (_, _) => BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: ignoreState(),
        builder: (context, state) => Text(
          context.ln.settings_developer,
          style: context.appTheme.typography.settings.property.copyWith(
            color: context.appTheme.colors.text.secondary,
          ),
        ),
      ),
    );
  }
}
