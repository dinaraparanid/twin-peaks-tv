import 'package:flutter/widgets.dart';

extension GlobalKeyExt on GlobalKey {
  Size? get size {
    final renderBox = currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.hasSize == true ? renderBox?.size : null;
  }
}
