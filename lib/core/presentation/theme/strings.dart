import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/l10n/app_localizations.dart';

extension AppString on BuildContext {
  AppLocalizations get ln => AppLocalizations.of(this)!;
}
