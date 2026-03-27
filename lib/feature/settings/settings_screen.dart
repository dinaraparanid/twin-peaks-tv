import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/settings/widget/info/info.dart';

@RoutePage()
final class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (_) => di<SettingsBlocFactory>()(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: ignoreState(),
        builder: (context, state) => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.s),
              const Info(),
              SizedBox(height: 12.s),
            ],
          ),
        ),
      ),
    );
  }
}
