part of 'animation.dart';

final class AnimatedSelectionDecoration extends StatefulWidget {
  const AnimatedSelectionDecoration({
    super.key,
    this.controller,
    this.duration = _defaultDuration,
    this.paddingBuilder,
    required this.decorationBuilder,
    required this.builder,
  });

  final AnimatedSelectionController? controller;
  final Duration duration;
  final EdgeInsetsGeometry Function(BuildContext, double)? paddingBuilder;
  final Widget Function(BuildContext, double, Widget) decorationBuilder;
  final Widget Function(BuildContext, double) builder;

  static AnimatedSelectionDecorationState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<AnimatedSelectionDecorationState>();

  static AnimatedSelectionDecorationState of(BuildContext context) =>
      maybeOf(context)!;

  @override
  State<StatefulWidget> createState() => AnimatedSelectionDecorationState();
}

final class AnimatedSelectionDecorationState
    extends State<AnimatedSelectionDecoration>
    with SingleTickerProviderStateMixin {
  late AnimatedSelectionController _controller;
  var _ownsController = false;

  AnimatedSelectionController get controller => _controller;

  @override
  void initState() {
    _controller =
        widget.controller ??
        AnimatedSelectionController(
          animationController: AnimationController(
            vsync: this,
            duration: widget.duration,
          ),
        );

    _ownsController = widget.controller == null;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedSelectionDecoration oldWidget) {
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
    return _AnimatedDecorationContent(
      borderAnimation: _controller.borderAnimation,
      paddingBuilder: widget.paddingBuilder,
      decorationBuilder: widget.decorationBuilder,
      builder: widget.builder,
    );
  }
}

final class _AnimatedDecorationContent extends AnimatedWidget {
  const _AnimatedDecorationContent({
    required Animation<double> borderAnimation,
    required this.paddingBuilder,
    required this.decorationBuilder,
    required this.builder,
  }) : super(listenable: borderAnimation);

  final EdgeInsetsGeometry Function(BuildContext, double)? paddingBuilder;
  final Widget Function(BuildContext, double, Widget) decorationBuilder;
  final Widget Function(BuildContext, double) builder;

  @override
  Widget build(BuildContext context) {
    final borderAnimation = listenable as Animation<double>;

    return decorationBuilder(
      context,
      borderAnimation.value,
      switch (paddingBuilder) {
        null => builder(context, borderAnimation.value),
        final f => Padding(
          padding: f(context, borderAnimation.value),
          child: builder(context, borderAnimation.value),
        ),
      },
    );
  }
}
