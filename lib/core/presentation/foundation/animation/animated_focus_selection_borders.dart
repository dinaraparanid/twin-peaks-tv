part of 'animation.dart';

final class AnimatedFocusSelectionBorders extends StatefulWidget {
  AnimatedFocusSelectionBorders({
    super.key,
    this.controller,
    this.focusNode,
    this.duration = _defaultDuration,
    this.autoScroll = false,
    this.paddingBuilder,
    final BorderRadiusGeometry? borderRadius,
    final double? borderWidth,
    this.shape = BoxShape.rectangle,
    this.onUp,
    this.onDown,
    this.onLeft,
    this.onRight,
    this.onSelect,
    this.onBack,
    this.onKeyEvent,
    this.onFocusChanged,
    this.onFocusDisabledWhenWasFocused,
    required this.builder,
  }) : borderRadius = borderRadius ?? BorderRadius.all(Radius.circular(16.r)),
       borderWidth = borderWidth ?? 2.s;

  final AnimatedSelectionBordersController? controller;
  final FocusNode? focusNode;
  final Duration duration;
  final bool autoScroll;
  final EdgeInsetsGeometry Function(double)? paddingBuilder;
  final BorderRadiusGeometry borderRadius;
  final double borderWidth;
  final BoxShape shape;
  final DpadEventCallback? onUp;
  final DpadEventCallback? onDown;
  final DpadEventCallback? onLeft;
  final DpadEventCallback? onRight;
  final DpadEventCallback? onSelect;
  final DpadEventCallback? onBack;
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;
  final void Function(FocusNode, bool)? onFocusChanged;
  final void Function()? onFocusDisabledWhenWasFocused;
  final Widget Function(BuildContext, FocusNode) builder;

  @override
  State<StatefulWidget> createState() => _AnimatedFocusSelectionBordersState();
}

final class _AnimatedFocusSelectionBordersState
    extends State<AnimatedFocusSelectionBorders>
    with SingleTickerProviderStateMixin {
  late final AnimatedSelectionBordersController _controller;
  var _ownsController = false;

  late final FocusNode _focusNode;
  var _ownsNode = false;

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

    _focusNode = widget.focusNode ?? FocusNode();
    _ownsNode = widget.focusNode == null;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedFocusSelectionBorders oldWidget) {
    final passedController = widget.controller;

    if (passedController != null && passedController != oldWidget.controller) {
      if (_ownsController) {
        _controller.dispose();
      }

      _controller = passedController;
      _ownsController = false;
    }

    final passedNode = widget.focusNode;

    if (passedNode != null && passedNode != oldWidget.focusNode) {
      if (_ownsNode) {
        _focusNode.dispose();
      }

      _focusNode = passedNode;
      _ownsNode = false;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }

    if (_ownsNode) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focus = widget.autoScroll ? ScrollGroupDpadFocus.new : DpadFocus.new;

    return focus(
      focusNode: _focusNode,
      onUp: widget.onUp,
      onDown: widget.onDown,
      onLeft: widget.onLeft,
      onRight: widget.onRight,
      onSelect: widget.onSelect,
      onBack: widget.onBack,
      onKeyEvent: widget.onKeyEvent,
      onFocusChanged: (node, hasFocus) async {
        await _controller.setSelected(hasFocus);
        widget.onFocusChanged?.call(node, hasFocus);
      },
      onFocusDisabledWhenWasFocused: widget.onFocusDisabledWhenWasFocused,
      builder: (context, node) => AnimatedSelectionBorders(
        controller: _controller,
        duration: widget.duration,
        paddingBuilder: widget.paddingBuilder,
        borderRadius: widget.borderRadius,
        borderWidth: widget.borderWidth,
        shape: widget.shape,
        builder: (context) => widget.builder(context, node),
      ),
    );
  }
}
