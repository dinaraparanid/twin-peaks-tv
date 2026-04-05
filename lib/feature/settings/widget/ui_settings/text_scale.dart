import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/domain/settings/entity/text_scale.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/block/block.dart';

final class TextScaleItem extends StatefulWidget {
  const TextScaleItem({super.key});

  @override
  State<StatefulWidget> createState() => _TextScaleItemState();
}

final class _TextScaleItemState extends State<TextScaleItem> {
  late final _menuOpenNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _menuOpenNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: distinctState((s) => s.properties?.textScale),
      builder: (context, state) => SettingsItem(
        onSelect: (_, _) {
          _menuOpenNotifier.value = !_menuOpenNotifier.value;
          return KeyEventResult.handled;
        },
        iconBuilder: (context, _) => switch (AppPlatform.isTvOS) {
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
        titleBuilder: (context, _) => Text(
          context.ln.settings_ui_settings_text_scaling,
          style: context.appTheme.typography.settings.property.copyWith(
            color: context.appTheme.colors.text.primary,
          ),
        ),
        actionBuilder: (context, _) => AppDropdownButton(
          value: state.properties?.textScale?.localized(context),
          menuOpenNotifier: _menuOpenNotifier,
          items: TextScale.values.map((e) => e.localized(context)).toList(),
          color: context.appTheme.colors.primary.primary80,
          onChanged: (value) {
            if (value != null) {
              final scale = TextScale.fromLocalized(
                context: context,
                value: value,
              );

              context.settingsBloc.add(UpdateTextScaleEvent(textScale: scale));
            }
          },
        ),
      ),
    );
  }
}
