import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/presentation/theme/strings.dart';

enum MainTab { home, encyclopedia, settings }

extension Title on MainTab {
  String title(BuildContext context) => switch (this) {
    MainTab.home => context.ln.main_menu_home,
    MainTab.encyclopedia => context.ln.main_menu_encyclopedia,
    MainTab.settings => context.ln.main_menu_settings,
  };
}
