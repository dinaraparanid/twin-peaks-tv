import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

final class EllipticalGradientTransform extends GradientTransform {
  const EllipticalGradientTransform({
    required this.relativeCenter,
    required this.scale,
  });

  final Offset relativeCenter;
  final Scale scale;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double widthFactor;
    final double heightFactor;

    if (bounds.width > bounds.height) {
      heightFactor = scale.heightFactor;
      widthFactor = scale.widthFactor * bounds.width / bounds.height;
    } else {
      heightFactor = scale.heightFactor * bounds.height / bounds.width;
      widthFactor = scale.widthFactor;
    }

    final transformMatrix = Matrix4.identity().scaledByDouble(
      widthFactor,
      heightFactor,
      widthFactor,
      1,
    );

    final originalCenterOffset = Offset(
      bounds.left + bounds.width * relativeCenter.dx,
      bounds.top + bounds.height * relativeCenter.dy,
    );

    final offsetLocation = transformMatrix.applyToVector3Array([
      originalCenterOffset.dx,
      originalCenterOffset.dy,
      0.0,
    ]);

    final dx = originalCenterOffset.dx - offsetLocation[0];
    final dy = originalCenterOffset.dy - offsetLocation[1];

    return transformMatrix
      ..translateByDouble(dx / widthFactor, dy / heightFactor, 0, 1);
  }
}

@immutable
final class Scale {
  const Scale({required this.heightFactor, required this.widthFactor});

  final double heightFactor;
  final double widthFactor;

  Scale operator *(double factor) => Scale(
    heightFactor: heightFactor * factor,
    widthFactor: widthFactor * factor,
  );
}
