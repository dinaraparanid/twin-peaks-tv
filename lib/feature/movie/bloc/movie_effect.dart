import 'package:flutter/widgets.dart';

@immutable
sealed class MovieEffect {
  const MovieEffect();
}

final class UpdateTabBarOpacity extends MovieEffect {
  const UpdateTabBarOpacity({required this.opacity});
  final double opacity;
}
