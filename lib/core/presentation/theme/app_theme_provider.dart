import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme.dart';

final class AppThemeProvider extends InheritedWidget {
  const AppThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  final AppTheme theme;

  static AppTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppThemeProvider>()!.theme;

  @override
  bool updateShouldNotify(covariant AppThemeProvider oldWidget) =>
      theme != oldWidget.theme;
}

extension GetAppTheme on BuildContext {
  AppTheme get appTheme => AppThemeProvider.of(this);
}
