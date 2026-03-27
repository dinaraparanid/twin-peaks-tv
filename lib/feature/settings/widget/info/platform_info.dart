import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/settings/bloc/bloc.dart';

final class PlatformInfo extends StatelessWidget {
  const PlatformInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: distinctState((s) => (s.appVersion, s.os)),
      builder: (context, state) {
        final versionText = switch (state.appVersion) {
          final String appVersion => context.ln.settings_app_version_info(
            appVersion,
          ),

          null => null,
        };

        return Text(
          [versionText, state.os].nonNulls.join(' | '),
          style: context.appTheme.typography.settings.label.copyWith(
            color: context.appTheme.colors.text.secondary,
          ),
        );
      },
    );
  }
}
