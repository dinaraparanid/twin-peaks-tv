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

  static BoxDecoration buildDecoration({
    required BuildContext context,
    required double animation,
    BorderRadiusGeometry? borderRadius,
    double? borderWidth,
    BoxShape shape = BoxShape.rectangle,
  }) => BoxDecoration(
    borderRadius: shape == BoxShape.circle
        ? null
        : borderRadius ?? BorderRadius.all(Radius.circular(16.r)),
    border: GradientBoxBorder(
      gradient: Gradient.lerp(
        context.appTheme.colors.gradients.transparent,
        context.appTheme.colors.gradients.selection,
        animation,
      )!,
      width: borderWidth ?? 2.s,
    ),
    boxShadow: [
      ?BoxShadow.lerp(
        BoxShadow(color: context.appTheme.colors.transparent),
        BoxShadow(
          color: context.appTheme.colors.primary.primary80,
          blurRadius: 8.r,
          blurStyle: BlurStyle.outer,
        ),
        animation,
      ),
    ],
    shape: shape,
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedSelectionDecoration(
      controller: controller,
      duration: duration,
      paddingBuilder: paddingBuilder,
      decorationBuilder: (context, animation, child) => Container(
        clipBehavior: Clip.hardEdge,
        decoration: buildDecoration(
          context: context,
          animation: animation,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
          shape: shape,
        ),
        child: child,
      ),
      builder: builder,
    );
  }
}
