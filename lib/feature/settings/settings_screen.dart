import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/main/main_screen.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/faq.dart';
import 'package:twin_peaks_tv/feature/settings/widget/info/info.dart';
import 'package:twin_peaks_tv/feature/settings/widget/playback/playback.dart';
import 'package:twin_peaks_tv/feature/settings/widget/ui_settings/ui_settings.dart';

@RoutePage()
final class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (_) => di<SettingsBlocFactory>()(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: ignoreState(),
        builder: (context, state) {
          final contentPadding = EdgeInsets.symmetric(
            vertical: 12.s,
            horizontal: 16.s,
          );

          return Padding(
            padding: EdgeInsets.only(
              left: switch (AppPlatform.isTizen) {
                true => MainScreen.oneUiMenuConstraints.minWidth,
                false => 0.s,
              },
            ),
            child: DpadFocusScope(
              builder: (context, focusScopeNode) => SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12.s),
                    const Info(),
                    Padding(padding: contentPadding, child: const UISettings()),
                    Padding(padding: contentPadding, child: const Playback()),
                    Padding(padding: contentPadding, child: const FAQ()),
                    SizedBox(height: 12.s),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
