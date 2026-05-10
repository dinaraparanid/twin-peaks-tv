import 'package:flutter/widgets.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

final class AppShimmer extends StatelessWidget {
  const AppShimmer({super.key, required this.child});

  final Widget child;

  static Widget circle({required Widget child}) {
    return ClipOval(
      clipBehavior: Clip.hardEdge,
      child: AppShimmer(child: child),
    );
  }

  static Widget rounded({
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    required Widget child,
  }) => ClipRRect(
    borderRadius: borderRadius,
    clipBehavior: Clip.hardEdge,
    child: AppShimmer(child: child),
  );

  @override
  Widget build(BuildContext context) {
    return Shimmer(child: child);
  }
}
