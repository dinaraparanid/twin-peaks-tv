import 'package:flutter/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/colors.dart';
import 'package:twin_peaks_tv/core/presentation/theme/typography.dart';

@immutable
final class AppTheme {
  const AppTheme({required this.typography, this.colors = const AppColors()});

  final AppTypography typography;
  final AppColors colors;
}
