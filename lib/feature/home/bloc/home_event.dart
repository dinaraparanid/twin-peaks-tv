import 'package:flutter/foundation.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

final class UpdateTabBarOpacity extends HomeEvent {
  const UpdateTabBarOpacity({required this.opacity});
  final double opacity;
}
