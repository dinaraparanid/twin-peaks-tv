import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/domain/settings/entity/lang.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/block.dart';

final class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<StatefulWidget> createState() => _LanguageState();
}

final class _LanguageState extends State<Language> {
  late final _menuOpenNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _menuOpenNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: distinctState((s) => s.properties?.language),
      builder: (context, state) => SettingsItem(
        autofocus: true,
        focusNode: context.settingsBloc.languageNode,
        // onUp: (_, _) {
        //   context.settingsBloc.developerNode.requestFocus();
        //   return KeyEventResult.handled;
        // },
        // onDown: (_, _) {
        //   context.settingsBloc.textScaleNode.requestFocus();
        //   return KeyEventResult.handled;
        // },
        onSelect: (_, _) {
          _menuOpenNotifier.value = !_menuOpenNotifier.value;
          return KeyEventResult.handled;
        },
        iconBuilder: (context, _) => Icon(
          switch (AppPlatform.isTvOS) {
            true => CupertinoIcons.globe,
            false => Icons.language,
          },
          size: 20.s,
          color: context.appTheme.colors.text.primary,
        ),
        titleBuilder: (context, _) => Text(
          context.ln.settings_ui_settings_lang,
          style: context.appTheme.typography.settings.property.copyWith(
            color: context.appTheme.colors.text.primary,
          ),
        ),
        actionBuilder: (context, animation) => AppDropdownButton(
          value: state.properties?.language?.localized(),
          menuOpenNotifier: _menuOpenNotifier,
          placeholder: context.ln.settings_ui_settings_lang_system,
          items: AppLanguage.values.map((e) => e.localized()).toList(),
          color: Color.lerp(
            context.appTheme.colors.primary.primary80,
            context.appTheme.colors.text.primary,
            animation,
          )!,
          onChanged: (value) {
            if (value != null) {
              final lang = AppLanguage.fromLocalized(value);
              context.settingsBloc.add(UpdateLanguageEvent(language: lang));
            }
          },
        ),
      ),
    );
  }
}
