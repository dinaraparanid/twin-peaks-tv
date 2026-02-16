import 'dart:ui';

extension ColorExt on Color {
  ColorFilter toColorFilter() => ColorFilter.mode(this, BlendMode.srcIn);
}
