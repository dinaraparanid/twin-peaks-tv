import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

final class CupertinoSearchBar extends StatefulWidget {
  const CupertinoSearchBar({
    super.key,
    required this.searchController,
    required this.placeholder,
    required this.currentLocale,
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

  final TvSearchController searchController;
  final String placeholder;
  final Locale? currentLocale;
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
  State<StatefulWidget> createState() => _CupertinoSearchBarState();
}

final class _CupertinoSearchBarState extends State<CupertinoSearchBar> {
  late final CupertinoTvSearchController _controller;

  static CupertinoTvSearchBarThemeData _buildThemeData(BuildContext context) {
    return CupertinoTvSearchBarThemeData(
      queryStyle: TextStyle(
        fontSize: 32.fz,
        color: const Color(0xCCFFFFFF),
        fontWeight: FontWeight.w700,
        fontFamily: context.appTheme.typography.fontFamily,
      ),
      placeholderStyle: TextStyle(
        fontSize: 32.fz,
        color: const Color(0xCCC4C7C5),
        fontWeight: FontWeight.w700,
        fontFamily: context.appTheme.typography.fontFamily,
      ),
      letterTextStyle: WidgetStateProperty.fromMap({
        WidgetState.focused: TextStyle(
          fontSize: 24.fz,
          color: const Color(0xCC000000),
          fontWeight: FontWeight.w700,
          fontFamily: context.appTheme.typography.fontFamily,
        ),
        WidgetState.any: TextStyle(
          fontSize: 24.fz,
          color: const Color(0xCCC4C7C5),
          fontWeight: FontWeight.w700,
          fontFamily: context.appTheme.typography.fontFamily,
        ),
      }),
      buttonTextStyle: WidgetStateProperty.fromMap({
        WidgetState.focused: TextStyle(
          fontSize: 18.fz,
          color: CupertinoColors.white,
          fontWeight: FontWeight.w700,
          height: 1.5,
          fontFamily: context.appTheme.typography.fontFamily,
        ),
        WidgetState.any: TextStyle(
          fontSize: 18.fz,
          color: const Color(0xCCC4C7C5),
          fontWeight: FontWeight.w700,
          height: 1.5,
          fontFamily: context.appTheme.typography.fontFamily,
        ),
      }),
      keyboardTypeExpandedTextStyle: WidgetStateProperty.fromMap({
        WidgetState.focused: TextStyle(
          fontSize: 16.fz,
          color: CupertinoColors.white,
          fontWeight: FontWeight.w700,
          height: 1.5,
          fontFamily: context.appTheme.typography.fontFamily,
        ),
        WidgetState.any: TextStyle(
          fontSize: 16.fz,
          color: const Color(0xCCFFFFFF),
          fontWeight: FontWeight.w700,
          height: 1.5,
          fontFamily: context.appTheme.typography.fontFamily,
        ),
      }),
      letterDecoration: WidgetStateProperty.fromMap({
        WidgetState.focused: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4.8.s),
              blurRadius: 4.8.r,
              color: const Color(0x40000000),
            ),
          ],
        ),
        WidgetState.any: const BoxDecoration(),
      }),
      keyboardTypeExpandedDecoration: WidgetStateProperty.fromMap({
        WidgetState.focused: BoxDecoration(
          color: const Color(0xCC000000),
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
        WidgetState.any: BoxDecoration(
          color: const Color(0x99000000),
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
      }),
      buttonContentColor: const WidgetStateProperty.fromMap({
        WidgetState.focused: CupertinoColors.white,
        WidgetState.any: Color(0xCCC4C7C5),
      }),
      keyboardTypeExpandedBackgroundColor: const Color(0xFFC4C7C5),
      switchLocaleIconFocusPadding: EdgeInsets.symmetric(
        vertical: 12.s,
        horizontal: 8.s,
      ),
      letterFocusPadding: EdgeInsets.symmetric(vertical: 8.s, horizontal: 12.s),
      buttonFillPadding: EdgeInsets.symmetric(vertical: 4.s, horizontal: 8.s),
      buttonFocusPadding: EdgeInsets.symmetric(vertical: 8.s, horizontal: 8.s),
      buttonRadius: BorderRadius.all(Radius.circular(4.r)),
      keyboardTypeExpandedRadius: BorderRadius.all(Radius.circular(12.r)),
      switchLocaleIconSize: 24.s,
      spaceBetweenQueryAndInput: 24.s,
    );
  }

  static CupertinoTvSearchBarLocalization _buildLocalization() {
    return CupertinoTvSearchBarLocalization(
      supportedAlphabets: LinkedHashMap.of({
        const Locale('en'): 'abcdefghijklmnopqrstuvwxyz'.split(''),
        const Locale('ru'): 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'.split(''),
      }),
      spaceTranslation: {
        const Locale('en'): 'SPACE',
        const Locale('ru'): 'ПРОБЕЛ',
      },
      keyboardLayoutTranslation: {
        const Locale('en'): 'English (US)',
        const Locale('ru'): 'Русская',
      },
      keyboardTypeTranslation: {
        const Locale('en'): 'abc',
        const Locale('ru'): 'абв',
      },
    );
  }

  @override
  void initState() {
    _controller = CupertinoTvSearchController(
      controller: widget.searchController,
      focusScopeNode: widget.focusScopeNode,
      currentLocale: widget.currentLocale ?? const Locale('en'),
      localization: _buildLocalization(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTvSearchBar(
      controller: _controller,
      placeholder: widget.placeholder,
      theme: _buildThemeData(context),
      autofocus: true,
      onUp: widget.onUp,
      onDown: widget.onDown,
      onLeft: widget.onLeft,
      onRight: widget.onRight,
      onSelect: widget.onSelect,
      onBack: widget.onBack,
      onKeyEvent: widget.onKeyEvent,
      onFocusChanged: (scopeNode, isFocused) {
        if (isFocused) {
          _controller.requestFocusOnFirstLetter();
        }

        widget.onFocusChanged?.call(scopeNode, isFocused);
      },
      onFocusDisabledWhenWasFocused: widget.onFocusDisabledWhenWasFocused,
      searchIcon: Padding(
        padding: EdgeInsets.only(right: 20.s),
        child: Icon(
          CupertinoIcons.search,
          size: 64.s,
          color: const Color(0xCCC4C7C5),
        ),
      ),
    );
  }
}
