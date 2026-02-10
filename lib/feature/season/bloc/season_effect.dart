import 'package:flutter/widgets.dart';

@immutable
sealed class SeasonEffect {
  const SeasonEffect();
}

final class UpdateTabBarOpacity extends SeasonEffect {
  const UpdateTabBarOpacity({required this.opacity});
  final double opacity;
}
