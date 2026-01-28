import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/presentation/theme/strings.dart';

enum HomeTab { season1, season2, movie, season3 }

extension Properties on HomeTab {
  String buildTitle(BuildContext context) => switch (this) {
    HomeTab.season1 => context.ln.home_tab_season1,
    HomeTab.season2 => context.ln.home_tab_season2,
    HomeTab.movie => context.ln.home_tab_movie,
    HomeTab.season3 => context.ln.home_tab_season3,
  };
}
