import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/l10n/app_localizations.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/router/app_router.dart';
import 'package:twin_peaks_tv/core/utils/image_cache.dart';

final class App extends StatelessWidget {
  const App({super.key, required this.router});
  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return FutureBuilder(
      future: cacheAssetImages(context),
      builder: (context, snapshot) => ScalifyProvider(
        config: const ScalifyConfig(designWidth: 1280, designHeight: 720),
        builder: (context, _) {
          final theme = AppTheme(typography: AppTypography(context: context));

          return AppThemeProvider(
            theme: theme,
            child: snapshot.connectionState == ConnectionState.done
                ? _MaterialUi(router: router, theme: theme)
                : const SizedBox(),
          );
        },
      ),
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
