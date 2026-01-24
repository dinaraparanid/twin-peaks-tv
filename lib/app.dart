import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twin_peaks_tv/core/l10n/app_localizations.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/router/app_router.dart';

final class App extends StatelessWidget {
  const App({super.key, required this.router});

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme(typography: AppTypography(context: context));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return AppThemeProvider(
      theme: theme,
      child: _MaterialUi(router: router, theme: theme),
    );
  }
}

final class _MaterialUi extends StatelessWidget {
  const _MaterialUi({required this.router, required this.theme});

  final AppRouter router;
  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Twin Peaks TV',
      routerConfig: router.config(),
      color: theme.colors.background.primary,
      localizationsDelegates: [AppLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
