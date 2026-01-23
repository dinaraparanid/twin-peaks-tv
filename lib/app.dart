import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twin_peaks_tv/core/l10n/app_localizations.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/router/app_router.dart';

final class App extends StatelessWidget {
  const App({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return AppThemeProvider(
      theme: AppTheme(typography: AppTypography(context: context)),
      child: _MaterialUi(appRouter: appRouter),
    );
  }
}

final class _MaterialUi extends StatelessWidget {
  const _MaterialUi({required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Twin Peaks TV',
      routerConfig: appRouter.config(),
      localizationsDelegates: [AppLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
