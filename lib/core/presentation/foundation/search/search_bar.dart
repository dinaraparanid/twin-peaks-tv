import 'package:flutter/widgets.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/search/cupertino_search_bar.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/search/material_search_bar.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/search/sandstone_search_bar.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';

final class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.searchController,
    this.currentLocale,
    required this.placeholder,
    this.focusScopeNode,
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

  final TvSearchController? searchController;
  final Locale? currentLocale;
  final String placeholder;
  final FocusScopeNode? focusScopeNode;
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
  State<StatefulWidget> createState() => _AppSearchBarState();
}

final class _AppSearchBarState extends State<AppSearchBar> {
  late final TvSearchController _searchController;
  var _ownsController = false;

  late final _focusNode = FocusNode();

  @override
  void initState() {
    _searchController = widget.searchController ?? TvSearchController();
    _ownsController = widget.searchController == null;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppSearchBar oldWidget) {
    final passedController = widget.searchController;

    if (passedController != null &&
        passedController != oldWidget.searchController) {
      if (_ownsController) {
        _searchController.dispose();
      }

      _searchController = passedController;
      _ownsController = false;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_ownsController) {
      _searchController.dispose();
    }

    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => DpadFocusScope(
        focusScopeNode: widget.focusScopeNode,
        onUp: widget.onUp,
        onDown: widget.onDown,
        onLeft: widget.onLeft,
        onRight: widget.onRight,
        onSelect: widget.onSelect,
        onBack: widget.onBack,
        onKeyEvent: widget.onKeyEvent,
        onFocusDisabledWhenWasFocused: widget.onFocusDisabledWhenWasFocused,
        onFocusChanged: (node, isFocused) {
          if (isFocused) {
            _focusNode.requestFocus();
          }

          widget.onFocusChanged?.call(node, isFocused);
        },
        builder: (context, _) => MaterialSearchBar(
          searchController: _searchController,
          placeholder: widget.placeholder,
          focusNode: _focusNode,
          autofocus: widget.autofocus,
        ),
      ),

      AppPlatforms.tizen => DpadFocusScope(
        focusScopeNode: widget.focusScopeNode,
        onUp: widget.onUp,
        onDown: widget.onDown,
        onLeft: widget.onLeft,
        onRight: widget.onRight,
        onSelect: widget.onSelect,
        onBack: widget.onBack,
        onKeyEvent: widget.onKeyEvent,
        onFocusDisabledWhenWasFocused: widget.onFocusDisabledWhenWasFocused,
        onFocusChanged: (node, isFocused) {
          if (isFocused) {
            _focusNode.requestFocus();
          }

          widget.onFocusChanged?.call(node, isFocused);
        },
        builder: (context, _) => MaterialSearchBar(
          searchController: _searchController,
          placeholder: widget.placeholder,
          focusNode: _focusNode,
          autofocus: widget.autofocus,
        ),
      ),

      AppPlatforms.tvos => CupertinoSearchBar(
        searchController: _searchController,
        placeholder: widget.placeholder,
        currentLocale: widget.currentLocale,
        focusScopeNode: widget.focusScopeNode,
        onUp: widget.onUp,
        onDown: widget.onDown,
        onLeft: widget.onLeft,
        onRight: widget.onRight,
        onSelect: widget.onSelect,
        onBack: widget.onBack,
        onKeyEvent: widget.onKeyEvent,
        onFocusChanged: widget.onFocusChanged,
        onFocusDisabledWhenWasFocused: widget.onFocusDisabledWhenWasFocused,
      ),

      AppPlatforms.webos => DpadFocusScope(
        focusScopeNode: widget.focusScopeNode,
        onUp: widget.onUp,
        onDown: widget.onDown,
        onLeft: widget.onLeft,
        onRight: widget.onRight,
        onSelect: widget.onSelect,
        onBack: widget.onBack,
        onKeyEvent: widget.onKeyEvent,
        onFocusDisabledWhenWasFocused: widget.onFocusDisabledWhenWasFocused,
        onFocusChanged: (node, isFocused) {
          if (isFocused) {
            _focusNode.requestFocus();
          }

          widget.onFocusChanged?.call(node, isFocused);
        },
        builder: (context, _) => SandstoneSearchBar(
          searchController: _searchController,
          placeholder: widget.placeholder,
          focusNode: _focusNode,
          autofocus: widget.autofocus,
        ),
      ),
    };
  }
}
