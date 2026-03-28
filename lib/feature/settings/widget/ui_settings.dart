import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/settings_block.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/settings_item.dart';

final class UISettings extends StatelessWidget {
  const UISettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsBlock(
      label: context.ln.settings_ui_settings_label,
      children: [
        SettingsItem(
          autofocus: true,
          focusNode: context.settingsBloc.languageNode,
          onUp: (_, _) {
            context.settingsBloc.developerNode.requestFocus();
            return KeyEventResult.handled;
          },
          onDown: (_, _) {
            context.settingsBloc.textScaleNode.requestFocus();
            return KeyEventResult.handled;
          },
          icon: Icon(
            switch (AppPlatform.isTvOS) {
              true => CupertinoIcons.globe,
              false => Icons.language,
            },
            size: 20.s,
            color: context.appTheme.colors.text.primary,
          ),
          title: Text(
            context.ln.settings_ui_settings_lang,
            style: context.appTheme.typography.settings.property.copyWith(
              color: context.appTheme.colors.text.primary,
            ),
          ),
          action: const SizedBox(), // TODO(paranid5): toggle
        ),

        SettingsItem(
          focusNode: context.settingsBloc.textScaleNode,
          onUp: (_, _) {
            context.settingsBloc.languageNode.requestFocus();
            return KeyEventResult.handled;
          },
          onDown: (_, _) {
            context.settingsBloc.switchToNextEpisodeNode.requestFocus();
            return KeyEventResult.handled;
          },
          icon: switch (AppPlatform.isTvOS) {
            true => Icon(
              CupertinoIcons.arrow_up_left_arrow_down_right,
              color: context.appTheme.colors.text.primary,
              size: 20.s,
            ),

            false => Assets.icons.textScale.svg(
              width: 20.s,
              height: 20.s,
              fit: BoxFit.cover,
              colorFilter: context.appTheme.colors.text.primary.toColorFilter(),
            ),
          },
          title: Text(
            context.ln.settings_ui_settings_text_scaling,
            style: context.appTheme.typography.settings.property.copyWith(
              color: context.appTheme.colors.text.primary,
            ),
          ),
          action: const SizedBox(), // TODO(paranid5): toggle
        ),
      ],
    );
  }
}
