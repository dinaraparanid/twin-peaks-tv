part of 'animation.dart';

final class AnimatedSelectionBorders extends StatefulWidget {
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

  final AnimatedSelectionBordersController? controller;
  final Duration duration;
  final EdgeInsetsGeometry Function(double)? paddingBuilder;
  final BorderRadiusGeometry borderRadius;
  final double borderWidth;
  final BoxShape shape;
  final Widget Function(BuildContext) builder;

  static AnimatedSelectionBordersState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<AnimatedSelectionBordersState>();

  static AnimatedSelectionBordersState of(BuildContext context) =>
      maybeOf(context)!;

  @override
  State<StatefulWidget> createState() => AnimatedSelectionBordersState();
}

final class AnimatedSelectionBordersState
    extends State<AnimatedSelectionBorders>
    with SingleTickerProviderStateMixin {
  late AnimatedSelectionBordersController _controller;
  var _ownsController = false;

  AnimatedSelectionBordersController get controller => _controller;

  @override
  void initState() {
    _controller =
        widget.controller ??
        AnimatedSelectionBordersController(
          animationController: AnimationController(
            vsync: this,
            duration: widget.duration,
          ),
        );

    _ownsController = widget.controller == null;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedSelectionBorders oldWidget) {
    final passedController = widget.controller;

    if (passedController != null && passedController != oldWidget.controller) {
      if (_ownsController) {
        _controller.dispose();
      }

      _controller = passedController;
      _ownsController = false;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Content(
      borderAnimation: _controller.borderAnimation,
      paddingBuilder: widget.paddingBuilder,
      borderRadius: widget.borderRadius,
      borderWidth: widget.borderWidth,
      shape: widget.shape,
      builder: widget.builder,
    );
  }
}

final class _Content extends AnimatedWidget {
  const _Content({
    required Animation<double> borderAnimation,
    required this.paddingBuilder,
    required this.borderRadius,
    required this.borderWidth,
    required this.shape,
    required this.builder,
  }) : super(listenable: borderAnimation);

  final EdgeInsetsGeometry Function(double)? paddingBuilder;
  final BorderRadiusGeometry borderRadius;
  final double borderWidth;
  final BoxShape shape;
  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    final borderAnimation = listenable as Animation<double>;

    return Container(
      padding: paddingBuilder?.call(borderAnimation.value),
      decoration: BoxDecoration(
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
        border: GradientBoxBorder(
          gradient: Gradient.lerp(
            context.appTheme.colors.gradients.transparent,
            context.appTheme.colors.gradients.selection,
            borderAnimation.value,
          )!,
          width: borderWidth,
        ),
        shape: shape,
      ),
      child: builder(context),
    );
  }
}
