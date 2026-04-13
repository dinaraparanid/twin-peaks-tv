part of 'animation.dart';

final class AnimatedFocusSelectionBox extends StatefulWidget {
  const AnimatedFocusSelectionBox({
    super.key,
    this.controller,
    this.focusNode,
    this.duration = _defaultDuration,
    this.autofocus = false,
    this.autoscroll = false,
    this.color,
    this.paddingBuilder,
    this.decorationBuilder,
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
  });

  final AnimatedSelectionController? controller;
  final FocusNode? focusNode;
  final Duration duration;
  final bool autofocus;
  final bool autoscroll;
  final Color? color;
  final EdgeInsetsGeometry Function(BuildContext, double)? paddingBuilder;
  final Decoration Function(BuildContext, double)? decorationBuilder;
  final DpadEventCallback? onUp;
  final DpadEventCallback? onDown;
  final DpadEventCallback? onLeft;
  final DpadEventCallback? onRight;
  final DpadEventCallback? onSelect;
  final DpadEventCallback? onBack;
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;
  final void Function(FocusNode, bool)? onFocusChanged;
  final void Function()? onFocusDisabledWhenWasFocused;
  final Widget Function(BuildContext, FocusNode, double) builder;

  @override
  State<StatefulWidget> createState() => _AnimatedFocusSelectionBoxState();
}

final class _AnimatedFocusSelectionBoxState
    extends State<AnimatedFocusSelectionBox>
    with SingleTickerProviderStateMixin {
  late final AnimatedSelectionController _controller;
  var _ownsController = false;

  late final FocusNode _focusNode;
  var _ownsNode = false;

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

    _focusNode = widget.focusNode ?? FocusNode();
    _ownsNode = widget.focusNode == null;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedFocusSelectionBox oldWidget) {
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
    final focus = widget.autoscroll ? ScrollGroupDpadFocus.new : DpadFocus.new;

    return focus(
      focusNode: _focusNode,
      autofocus: widget.autofocus,
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
      builder: (context, node) => AnimatedSelectionDecoration(
        controller: _controller,
        duration: widget.duration,
        paddingBuilder: widget.paddingBuilder,
        decorationBuilder: (context, animation) {
          return widget.decorationBuilder?.call(context, animation) ??
              BoxDecoration(
                color: Color.lerp(
                  context.appTheme.colors.transparent,
                  widget.color ?? context.appTheme.colors.primary.primary80,
                  animation,
                ),
              );
        },
        builder: (context, animation) {
          return widget.builder(context, node, animation);
        },
      ),
    );
  }
}
