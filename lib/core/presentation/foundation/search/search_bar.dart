import 'package:flutter/widgets.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/search/cupertino_search_bar.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';

final class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.searchController,
    this.currentLocale,
    required this.placeholder,
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
  });

  final TvSearchController? searchController;
  final Locale? currentLocale;
  final String placeholder;
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

  @override
  State<StatefulWidget> createState() => _AppSearchBarState();
}

final class _AppSearchBarState extends State<AppSearchBar> {
  late final TvSearchController _searchController;
  var _ownsController = false;

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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => CupertinoSearchBar(
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

      AppPlatforms.tizen => CupertinoSearchBar(
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

      AppPlatforms.webos => CupertinoSearchBar(
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
    };
  }
}
