import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

enum TextScale {
  small,
  normal,
  big;

  factory TextScale.fromLocalized({
    required BuildContext context,
    required String value,
  }) => TextScale.values.firstWhere((l) => l.localized(context) == value);
}

extension TextScaleExt on TextScale {
  double get value => switch (this) {
    TextScale.small => -2,
    TextScale.normal => 0,
    TextScale.big => 2,
  };

  String localized(BuildContext context) => switch (this) {
    TextScale.small => context.ln.settings_ui_settings_text_scaling_small,
    TextScale.normal => context.ln.settings_ui_settings_text_scaling_normal,
    TextScale.big => context.ln.settings_ui_settings_text_scaling_big,
  };
}
