import 'package:flutter/material.dart';

final class OneUiThumbShape extends SliderComponentShape {
  const OneUiThumbShape({
    required this.thumbRadius,
    required this.thickness,
    required this.color,
  });

  final double thumbRadius;
  final double thickness;
  final Color color;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final strokePaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, strokePaint);

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius - (thickness / 2), fillPaint);
  }
}
