import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/l10n/app_localizations.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/router/app_router.dart';
import 'package:twin_peaks_tv/core/utils/image_cache.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';

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
          final theme = AppTheme(typography: AppTypography());

          return AppThemeProvider(
            theme: theme,
            child: switch ((
              snapshot.connectionState,
              AppPlatform.targetPlatform,
            )) {
              (ConnectionState.done, AppPlatforms.tvos) => _CupertinoUi(
                router: router,
                theme: theme,
              ),

              (ConnectionState.done, _) => _MaterialUi(
                router: router,
                theme: theme,
              ),

              _ => const SizedBox(),
            },
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
      localizationsDelegates: const [AppLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

final class _CupertinoUi extends StatelessWidget {
  const _CupertinoUi({required this.router, required this.theme});

  final AppRouter router;
  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: 'Twin Peaks TV',
      routerConfig: router.config(),
      color: theme.colors.background.primary,
      localizationsDelegates: const [AppLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
