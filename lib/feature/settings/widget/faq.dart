import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/block.dart';

final class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsBlock(
      children: [
        SettingsItem(
          onClick: () => context.settingsBloc.add(const OpenFAQEvent()),
          onSelect: (_, _) {
            context.settingsBloc.add(const OpenFAQEvent());
            return KeyEventResult.handled;
          },
          iconBuilder: (context, _) => Icon(
            switch (AppPlatform.isTvOS) {
              true => CupertinoIcons.info,
              false => Icons.info,
            },
            size: 20.s,
            color: context.appTheme.colors.text.primary,
          ),
          titleBuilder: (context, _) => Text(
            context.ln.settings_faq,
            style: context.appTheme.typography.settings.property.copyWith(
              color: context.appTheme.colors.text.primary,
            ),
          ),
          actionBuilder: (context, _) => switch (AppPlatform.isTvOS) {
            true => Icon(
              CupertinoIcons.chevron_forward,
              size: 24.s,
              color: context.appTheme.colors.text.primary,
            ),

            false => Icon(
              Icons.chevron_right,
              size: 32.s,
              color: context.appTheme.colors.text.primary,
            ),
          },
        ),
      ],
    );
  }
}
