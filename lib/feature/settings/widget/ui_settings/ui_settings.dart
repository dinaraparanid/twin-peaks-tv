import 'package:flutter/cupertino.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/block.dart';
import 'package:twin_peaks_tv/feature/settings/widget/ui_settings/language.dart';
import 'package:twin_peaks_tv/feature/settings/widget/ui_settings/text_scale.dart';

final class UISettings extends StatelessWidget {
  const UISettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsBlock(
      label: context.ln.settings_ui_settings_label,
      children: const [LanguageItem(), TextScaleItem()],
    );
  }
}
