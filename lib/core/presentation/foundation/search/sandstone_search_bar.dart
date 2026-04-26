import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

final class SandstoneSearchBar extends StatefulWidget {
  const SandstoneSearchBar({
    super.key,
    required this.searchController,
    required this.placeholder,
    this.focusNode,
    this.autofocus = false,
    this.onUp,
    this.onDown,
    this.onLeft,
    this.onRight,
    this.onSelect,
    this.onBack,
    this.onKeyEvent,
    this.onFocusChanged,
    this.onFocusDisabledWhenWasFocused,
  });

  final TvSearchController searchController;
  final String placeholder;
  final FocusNode? focusNode;
  final bool autofocus;
  final DpadScopeEventCallback? onUp;
  final DpadScopeEventCallback? onDown;
  final DpadScopeEventCallback? onLeft;
  final DpadScopeEventCallback? onRight;
  final DpadEventCallback? onSelect;
  final DpadEventCallback? onBack;
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;
  final void Function(FocusScopeNode, bool)? onFocusChanged;
  final void Function(FocusScopeNode)? onFocusDisabledWhenWasFocused;

  @override
  State<StatefulWidget> createState() => _SandstoneSearchBarState();
}

final class _SandstoneSearchBarState extends State<SandstoneSearchBar>
    with SingleTickerProviderStateMixin {
  late final FocusNode _focusNode;
  var _ownsNode = false;

  late final AnimatedSelectionController _animatedSelectionController;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _ownsNode = widget.focusNode == null;

    _focusNode.addListener(_focusListener);

    _animatedSelectionController = AnimatedSelectionController(
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    super.initState();
  }

  void _focusListener() {
    _animatedSelectionController.setSelected(_focusNode.hasFocus);
  }

  @override
  void didUpdateWidget(covariant SandstoneSearchBar oldWidget) {
    final passedFocusNode = widget.focusNode;

    if (passedFocusNode != null && passedFocusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_focusListener);

      if (_ownsNode) {
        _focusNode.dispose();
      }

      _focusNode = passedFocusNode..addListener(_focusListener);
      _ownsNode = false;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);

    if (_ownsNode) {
      _focusNode.dispose();
    }

    _animatedSelectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.all(Radius.circular(8.r));

    return AnimatedSelectionDecoration(
      controller: _animatedSelectionController,
      decorationBuilder: (context, animation, child) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          border: BoxBorder.lerp(
            BoxBorder.all(color: Colors.transparent, width: 4.s),
            BoxBorder.all(
              color: context.appTheme.colors.primary.primary80,
              width: 4.s,
            ),
            animation,
          ),
        ),
        child: child,
      ),
      builder: (context, animation) => TextField(
        controller: widget.searchController.textEditingController,
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        style: context.appTheme.typography.searchBar.primary.copyWith(
          color: context.appTheme.colors.text.primary,
        ),
        textInputAction: TextInputAction.search,
        cursorColor: context.appTheme.colors.primary.primary,
        keyboardAppearance: Brightness.dark,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 24.s, right: 4.s),
            child: Icon(Icons.search_rounded, size: 32.s),
          ),
          prefixIconColor: context.appTheme.colors.searchBar.input,
          hint: Text(
            widget.placeholder,
            style: context.appTheme.typography.searchBar.primary.copyWith(
              color: context.appTheme.colors.text.secondary,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16.s),
          filled: true,
          fillColor: context.appTheme.colors.searchBar.background,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: radius,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: radius,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: radius,
          ),
        ),
      ),
    );
  }
}
