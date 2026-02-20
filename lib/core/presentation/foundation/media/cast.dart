import 'package:flutter/widgets.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

final class Cast extends StatefulWidget {
  const Cast({
    super.key,
    this.focusScopeNode,
    this.onUp,
    this.onDown,
    this.onLeft,
    this.onRight,
    this.onSelect,
    this.onBack,
    this.onKeyEvent,
    this.onFocusChanged,
    this.onFocusDisabledWhenWasFocused,
    required this.actors,
  });

  final FocusScopeNode? focusScopeNode;
  final DpadScopeEventCallback? onUp;
  final DpadScopeEventCallback? onDown;
  final DpadScopeEventCallback? onLeft;
  final DpadScopeEventCallback? onRight;
  final DpadEventCallback? onSelect;
  final DpadEventCallback? onBack;
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;
  final void Function(FocusScopeNode, bool)? onFocusChanged;
  final void Function(FocusScopeNode)? onFocusDisabledWhenWasFocused;
  final List<Actor> actors;

  @override
  State<StatefulWidget> createState() => _CastState();
}

final class _CastState extends State<Cast> {
  late final FocusScopeNode _focusScopeNode;
  var _ownsNode = false;

  late final _focusNodes = List.generate(
    widget.actors.length,
    (_) => FocusNode(),
  );

  @override
  void initState() {
    _focusScopeNode = widget.focusScopeNode ?? FocusScopeNode();
    _ownsNode = widget.focusScopeNode == null;

    _focusScopeNode.addListener(_scopeListener);
    super.initState();
  }

  void _scopeListener() {
    if (_focusScopeNode.hasFocus && _focusScopeNode.focusedChild == null) {
      _focusNodes[0].requestFocus();
    }
  }

  @override
  void didUpdateWidget(covariant Cast oldWidget) {
    final passedScopeNode = widget.focusScopeNode;

    if (passedScopeNode != null &&
        passedScopeNode != oldWidget.focusScopeNode) {
      _focusScopeNode.removeListener(_scopeListener);
      _focusScopeNode.dispose();

      _focusScopeNode = passedScopeNode..addListener(_scopeListener);
      _ownsNode = false;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _focusScopeNode.removeListener(_scopeListener);

    if (_ownsNode) {
      _focusScopeNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const contentPadding = EdgeInsets.symmetric(horizontal: 32);

    return DpadFocusScope(
      focusScopeNode: _focusScopeNode,
      onUp: widget.onUp,
      onDown: widget.onDown,
      onLeft: widget.onLeft,
      onRight: widget.onRight,
      onSelect: widget.onSelect,
      onBack: widget.onBack,
      onKeyEvent: widget.onKeyEvent,
      onFocusChanged: widget.onFocusChanged,
      onFocusDisabledWhenWasFocused: widget.onFocusDisabledWhenWasFocused,
      builder: (context, _) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Padding(
            padding: contentPadding,
            child: Text(
              context.ln.movie_cast,
              style: context.appTheme.typography.movieInfo.label.copyWith(
                color: context.appTheme.colors.text.primary,
              ),
            ),
          ),

          SizedBox(
            height: 120,
            child: TvListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.actors.length,
              padding: contentPadding,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (_, index) => ActorItem(
                focusNode: _focusNodes[index],
                actor: widget.actors[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
