part of 'animation.dart';

final class AnimatedSelectionBorders extends StatelessWidget {
  AnimatedSelectionBorders({
    super.key,
    this.controller,
    this.duration = _defaultDuration,
    this.paddingBuilder,
    final BorderRadiusGeometry? borderRadius,
    final double? borderWidth,
    this.shape = BoxShape.rectangle,
    required this.builder,
  }) : borderRadius = borderRadius ?? BorderRadius.all(Radius.circular(16.r)),
       borderWidth = borderWidth ?? 2.s;

  final AnimatedSelectionController? controller;
  final Duration duration;
  final EdgeInsetsGeometry Function(BuildContext, double)? paddingBuilder;
  final BorderRadiusGeometry borderRadius;
  final double borderWidth;
  final BoxShape shape;
  final Widget Function(BuildContext, double) builder;

  @override
  Widget build(BuildContext context) {
    return AnimatedSelectionDecoration(
      controller: controller,
      duration: duration,
      paddingBuilder: paddingBuilder,
      decorationBuilder: (context, animation) => BoxDecoration(
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
        border: GradientBoxBorder(
          gradient: Gradient.lerp(
            context.appTheme.colors.gradients.transparent,
            context.appTheme.colors.gradients.selection,
            animation,
          )!,
          width: borderWidth,
        ),
        shape: shape,
      ),
      builder: builder,
    );
  }
}
