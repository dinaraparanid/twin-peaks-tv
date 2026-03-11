import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';

final class SandstoneMainMenu extends StatelessWidget {
  const SandstoneMainMenu({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.s, bottom: 8.s, left: 8.s, right: 8.s),
      child: child,
    );
  }
}
