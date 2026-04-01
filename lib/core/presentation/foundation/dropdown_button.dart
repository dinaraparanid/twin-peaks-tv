import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';

final class AppDropdownButton extends StatefulWidget {
  const AppDropdownButton({
    super.key,
    required this.value,
    required this.menuOpenNotifier,
    this.placeholder,
    required this.items,
    required this.color,
    this.focusNode,
    required this.onChanged,
  });

  final String? value;
  final ValueListenable<bool> menuOpenNotifier;
  final String? placeholder;
  final List<String> items;
  final Color color;
  final FocusNode? focusNode;
  final void Function(String?) onChanged;

  @override
  State<StatefulWidget> createState() => _AppDropdownButtonState();
}

final class _AppDropdownButtonState extends State<AppDropdownButton> {
  late final _valueListenable = ValueNotifier<String?>(widget.value);

  @override
  void didUpdateWidget(covariant AppDropdownButton oldWidget) {
    final passedValue = widget.value;

    if (passedValue != oldWidget.value) {
      _valueListenable.value = passedValue;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _valueListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => _MaterialDropdownButton.new,
      AppPlatforms.tizen => _OneUiDropdownButton.new,
      AppPlatforms.tvos => _CupertinoDropdownButton.new,
      AppPlatforms.webos => _SandstoneDropdownButton.new,
    }(
      value: _valueListenable,
      menuOpenNotifier: widget.menuOpenNotifier,
      placeholder: widget.placeholder,
      items: widget.items,
      color: widget.color,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
    );
  }
}

final class _MaterialDropdownButton extends StatelessWidget {
  const _MaterialDropdownButton({
    required this.value,
    required this.menuOpenNotifier,
    required this.placeholder,
    required this.items,
    required this.color,
    required this.focusNode,
    required this.onChanged,
  });

  final ValueListenable<String?> value;
  final ValueListenable<bool> menuOpenNotifier;
  final String? placeholder;
  final List<String> items;
  final Color color;
  final FocusNode? focusNode;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        focusNode: focusNode,
        valueListenable: value,
        openDropdownListenable: menuOpenNotifier,
        onChanged: onChanged,
        style: context.appTheme.typography.settings.property.copyWith(
          color: color,
        ),
        hint: Text(
          placeholder ?? '',
          style: context.appTheme.typography.settings.property.copyWith(
            color: color,
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(Icons.arrow_drop_down, size: 24.s, color: color),
        ),
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        dropdownStyleData: DropdownStyleData(
          useRootNavigator: true,
          decoration: BoxDecoration(
            color: context.appTheme.colors.background.primary,
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return context.appTheme.colors.settings.block;
            }

            return Colors.transparent;
          }),
        ),
        items: [
          for (final item in items)
            DropdownItem(
              value: item,
              height: 32.s,
              child: Text(
                item,
                style: context.appTheme.typography.settings.property.copyWith(
                  color: color,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final class _OneUiDropdownButton extends StatelessWidget {
  const _OneUiDropdownButton({
    required this.value,
    required this.menuOpenNotifier,
    required this.placeholder,
    required this.items,
    required this.color,
    required this.focusNode,
    required this.onChanged,
  });

  final ValueListenable<String?> value;
  final ValueListenable<bool> menuOpenNotifier;
  final String? placeholder;
  final List<String> items;
  final Color color;
  final FocusNode? focusNode;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        focusNode: focusNode,
        valueListenable: value,
        openDropdownListenable: menuOpenNotifier,
        onChanged: onChanged,
        style: context.appTheme.typography.settings.property.copyWith(
          color: color,
        ),
        hint: Text(
          placeholder ?? '',
          style: context.appTheme.typography.settings.property.copyWith(
            color: color,
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 24.s,
            color: color,
          ),
        ),
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        dropdownStyleData: DropdownStyleData(
          useRootNavigator: true,
          decoration: const BoxDecoration(color: Colors.transparent),
          dropdownBuilder: (context, child) => ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(24.r)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.s, vertical: 12.s),
                decoration: BoxDecoration(
                  color: context.appTheme.colors.background.primary80,
                ),
                child: child,
              ),
            ),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          overlayColor: WidgetStateProperty.fromMap({
            WidgetState.focused: context.appTheme.colors.settings.block,
            WidgetState.any: Colors.transparent,
          }),
        ),
        items: [
          for (final item in items)
            DropdownItem(
              value: item,
              height: 32.s,
              child: Text(
                item,
                style: context.appTheme.typography.settings.property.copyWith(
                  color: color,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final class _SandstoneDropdownButton extends StatelessWidget {
  const _SandstoneDropdownButton({
    required this.value,
    required this.menuOpenNotifier,
    required this.placeholder,
    required this.items,
    required this.color,
    required this.focusNode,
    required this.onChanged,
  });

  final ValueListenable<String?> value;
  final ValueListenable<bool> menuOpenNotifier;
  final String? placeholder;
  final List<String> items;
  final Color color;
  final FocusNode? focusNode;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        focusNode: focusNode,
        valueListenable: value,
        openDropdownListenable: menuOpenNotifier,
        onChanged: onChanged,
        style: context.appTheme.typography.settings.property.copyWith(
          color: color,
        ),
        hint: Text(
          placeholder ?? '',
          style: context.appTheme.typography.settings.property.copyWith(
            color: color,
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 24.s,
            color: color,
          ),
        ),
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        dropdownStyleData: DropdownStyleData(
          useRootNavigator: true,
          decoration: const BoxDecoration(color: Colors.transparent),
          dropdownBuilder: (context, child) => Container(
            padding: EdgeInsets.symmetric(horizontal: 12.s, vertical: 8.s),
            decoration: BoxDecoration(
              color: context.appTheme.colors.background.primary,
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            child: child,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          overlayColor: WidgetStateProperty.fromMap({
            WidgetState.focused: context.appTheme.colors.settings.block,
            WidgetState.any: Colors.transparent,
          }),
        ),
        items: [
          for (final item in items)
            DropdownItem(
              value: item,
              height: 32.s,
              child: Text(
                item,
                style: context.appTheme.typography.settings.property.copyWith(
                  color: color,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final class _CupertinoDropdownButton extends StatelessWidget {
  const _CupertinoDropdownButton({
    required this.value,
    required this.menuOpenNotifier,
    required this.placeholder,
    required this.items,
    required this.color,
    required this.focusNode,
    required this.onChanged,
  });

  final ValueListenable<String?> value;
  final ValueListenable<bool> menuOpenNotifier;
  final String? placeholder;
  final List<String> items;
  final Color color;
  final FocusNode? focusNode;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          focusNode: focusNode,
          valueListenable: value,
          openDropdownListenable: menuOpenNotifier,
          onChanged: onChanged,
          style: context.appTheme.typography.settings.property.copyWith(
            color: color,
          ),
          hint: Text(
            placeholder ?? '',
            style: context.appTheme.typography.settings.property.copyWith(
              color: color,
            ),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              CupertinoIcons.chevron_up_chevron_down,
              size: 24.s,
              color: color,
            ),
          ),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.zero,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            elevation: 0,
          ),
          dropdownStyleData: DropdownStyleData(
            useRootNavigator: true,
            decoration: const BoxDecoration(color: CupertinoColors.transparent),
            dropdownBuilder: (context, child) => LiquidGlassLayer(
              settings: AppLiquidGlass.defaultSettings(
                context,
                color: Colors.transparent,
              ),
              child: FakeGlass(
                shape: LiquidRoundedRectangle(borderRadius: 16.r),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.r)),
                    border: BoxBorder.all(
                      color: context.appTheme.colors.cupertino.glassBorder,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.s,
                    vertical: 4.s,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            overlayColor: WidgetStateProperty.fromMap({
              WidgetState.focused: context.appTheme.colors.settings.block,
              WidgetState.any: Colors.transparent,
            }),
          ),
          items: [
            for (final item in items)
              DropdownItem(
                value: item,
                height: 32.s,
                child: Text(
                  item,
                  maxLines: 1,
                  style: context.appTheme.typography.settings.property.copyWith(
                    color: color,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
