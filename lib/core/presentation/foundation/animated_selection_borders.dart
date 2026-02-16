import 'package:flutter/widgets.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

const _defaultDuration = Duration(milliseconds: 300);

final class AnimatedSelectionBorders extends StatefulWidget {
  const AnimatedSelectionBorders({
    super.key,
    this.focusNode,
    this.duration = _defaultDuration,
    this.autoScroll = false,
    this.paddingBuilder,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.borderWidth = 2,
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
  });

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
  State<StatefulWidget> createState() => _AnimatedSelectionBordersState();
}

final class _AnimatedSelectionBordersState
    extends State<AnimatedSelectionBorders>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _borderAnimation;

  late final FocusNode _focusNode;
  var _ownsNode = false;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _ownsNode = widget.focusNode == null;

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _borderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedSelectionBorders oldWidget) {
    final passedNode = widget.focusNode;

    if (passedNode != null && passedNode != oldWidget.focusNode) {
      _focusNode.dispose();

      _focusNode = passedNode;
      _ownsNode = false;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_ownsNode) {
      _focusNode.dispose();
    }

    _controller.dispose();
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
      onFocusChanged: (node, hasFocus) {
        if (hasFocus) {
          _controller.forward();
        } else {
          _controller.reverse();
        }

        widget.onFocusChanged?.call(node, hasFocus);
      },
      onFocusDisabledWhenWasFocused: widget.onFocusDisabledWhenWasFocused,
      builder: (context, node) => _Content(
        borderAnimation: _borderAnimation,
        paddingBuilder: widget.paddingBuilder,
        borderRadius: widget.borderRadius,
        borderWidth: widget.borderWidth,
        shape: widget.shape,
        child: widget.builder(context, node),
      ),
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
    required this.child,
  }) : super(listenable: borderAnimation);

  final EdgeInsetsGeometry Function(double)? paddingBuilder;
  final BorderRadiusGeometry borderRadius;
  final double borderWidth;
  final BoxShape shape;
  final Widget child;

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
      child: child,
    );
  }
}
