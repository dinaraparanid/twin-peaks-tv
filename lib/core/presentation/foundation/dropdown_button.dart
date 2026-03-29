import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

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
    return _MaterialDropdownButton(
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
          elevation: 0,
          decoration: BoxDecoration(
            color: context.appTheme.colors.background.primary,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          overlayColor: WidgetStateProperty.fromMap({
            WidgetState.focused: context.appTheme.colors.primary.primary80,
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
