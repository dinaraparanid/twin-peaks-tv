import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';

final class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.action,
    this.autofocus = false,
    required this.focusNode,
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

  final Widget icon;
  final Widget title;
  final Widget action;
  final bool autofocus;
  final FocusNode focusNode;
  final DpadEventCallback? onUp;
  final DpadEventCallback? onDown;
  final DpadEventCallback? onLeft;
  final DpadEventCallback? onRight;
  final DpadEventCallback? onSelect;
  final DpadEventCallback? onBack;
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;
  final void Function(FocusNode, bool)? onFocusChanged;
  final void Function()? onFocusDisabledWhenWasFocused;

  @override
  Widget build(BuildContext context) {
    return switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => _MaterialSettingsItem.new,
      AppPlatforms.tizen => _OneUiSettingsItem.new,
      AppPlatforms.tvos => _CupertinoSettingsItem.new,
      AppPlatforms.webos => _SandstoneSettingsItem.new,
    }(
      icon: icon,
      title: title,
      action: action,
      autofocus: autofocus,
      focusNode: focusNode,
      onUp: onUp,
      onDown: onDown,
      onLeft: onLeft,
      onRight: onRight,
      onSelect: onSelect,
      onBack: onBack,
      onKeyEvent: onKeyEvent,
      onFocusChanged: onFocusChanged,
      onFocusDisabledWhenWasFocused: onFocusDisabledWhenWasFocused,
    );
  }
}

final class _MaterialSettingsItem extends StatelessWidget {
  const _MaterialSettingsItem({
    required this.icon,
    required this.title,
    required this.action,
    required this.autofocus,
    required this.focusNode,
    required this.onUp,
    required this.onDown,
    required this.onLeft,
    required this.onRight,
    required this.onSelect,
    required this.onBack,
    required this.onKeyEvent,
    required this.onFocusChanged,
    required this.onFocusDisabledWhenWasFocused,
  });

  final Widget icon;
  final Widget title;
  final Widget action;
  final bool autofocus;
  final FocusNode focusNode;
  final DpadEventCallback? onUp;
  final DpadEventCallback? onDown;
  final DpadEventCallback? onLeft;
  final DpadEventCallback? onRight;
  final DpadEventCallback? onSelect;
  final DpadEventCallback? onBack;
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;
  final void Function(FocusNode, bool)? onFocusChanged;
  final void Function()? onFocusDisabledWhenWasFocused;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.appTheme.colors.settings.block,
      child: AnimatedFocusSelectionBox(
        focusNode: focusNode,
        autofocus: autofocus,
        autoscroll: true,
        onUp: onUp,
        onDown: onDown,
        onLeft: onLeft,
        onRight: onRight,
        onSelect: onSelect,
        onBack: onBack,
        onKeyEvent: onKeyEvent,
        onFocusChanged: onFocusChanged,
        onFocusDisabledWhenWasFocused: onFocusDisabledWhenWasFocused,
        paddingBuilder: (context, animation) =>
            EdgeInsets.all(16.s * lerpDouble(1.0, 1.2, animation)!),
        builder: (context, _, animation) {
          final scale = lerpDouble(1.0, 1.2, animation)!;
          final spacerScale = lerpDouble(1.0, 2.4, animation)!;
          final spacer = SizedBox(width: 8.s * spacerScale);

          return Row(
            children: [
              Transform.scale(scale: scale, child: icon),
              spacer,
              Transform.scale(scale: scale, child: title),
              spacer,
              const Expanded(child: SizedBox()),
              spacer,
              Transform.scale(scale: scale, child: action),
            ],
          );
        },
      ),
    );
  }
}

final class _CupertinoSettingsItem extends StatelessWidget {
  const _CupertinoSettingsItem({
    required this.icon,
    required this.title,
    required this.action,
    required this.autofocus,
    required this.focusNode,
    required this.onUp,
    required this.onDown,
    required this.onLeft,
    required this.onRight,
    required this.onSelect,
    required this.onBack,
    required this.onKeyEvent,
    required this.onFocusChanged,
    required this.onFocusDisabledWhenWasFocused,
  });

  final Widget icon;
  final Widget title;
  final Widget action;
  final bool autofocus;
  final FocusNode focusNode;
  final DpadEventCallback? onUp;
  final DpadEventCallback? onDown;
  final DpadEventCallback? onLeft;
  final DpadEventCallback? onRight;
  final DpadEventCallback? onSelect;
  final DpadEventCallback? onBack;
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;
  final void Function(FocusNode, bool)? onFocusChanged;
  final void Function()? onFocusDisabledWhenWasFocused;

  @override
  Widget build(BuildContext context) {
    return AnimatedFocusSelectionBox(
      focusNode: focusNode,
      autofocus: autofocus,
      autoscroll: true,
      onUp: onUp,
      onDown: onDown,
      onLeft: onLeft,
      onRight: onRight,
      onSelect: onSelect,
      onBack: onBack,
      onKeyEvent: onKeyEvent,
      onFocusChanged: onFocusChanged,
      onFocusDisabledWhenWasFocused: onFocusDisabledWhenWasFocused,
      paddingBuilder: (context, animation) =>
          EdgeInsets.all(16.s * lerpDouble(1.0, 1.2, animation)!),
      builder: (context, _, animation) {
        final scale = lerpDouble(1.0, 1.2, animation)!;
        final spacerScale = lerpDouble(1.0, 2.4, animation)!;
        final spacer = SizedBox(width: 8.s * spacerScale);

        return Row(
          children: [
            Transform.scale(scale: scale, child: icon),
            spacer,
            Transform.scale(scale: scale, child: title),
            spacer,
            const Expanded(child: SizedBox()),
            spacer,
            Transform.scale(scale: scale, child: action),
          ],
        );
      },
    );
  }
}

final class _OneUiSettingsItem extends StatelessWidget {
  const _OneUiSettingsItem({
    required this.icon,
    required this.title,
    required this.action,
    required this.autofocus,
    required this.focusNode,
    required this.onUp,
    required this.onDown,
    required this.onLeft,
    required this.onRight,
    required this.onSelect,
    required this.onBack,
    required this.onKeyEvent,
    required this.onFocusChanged,
    required this.onFocusDisabledWhenWasFocused,
  });

  final Widget icon;
  final Widget title;
  final Widget action;
  final bool autofocus;
  final FocusNode focusNode;
  final DpadEventCallback? onUp;
  final DpadEventCallback? onDown;
  final DpadEventCallback? onLeft;
  final DpadEventCallback? onRight;
  final DpadEventCallback? onSelect;
  final DpadEventCallback? onBack;
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;
  final void Function(FocusNode, bool)? onFocusChanged;
  final void Function()? onFocusDisabledWhenWasFocused;

  static Widget _buildDivider(BuildContext context) => Container(
    height: 16.s,
    width: 1.s,
    decoration: BoxDecoration(
      color: context.appTheme.colors.settings.divider,
      borderRadius: BorderRadius.all(Radius.circular(0.5.r)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedFocusSelectionBox(
      focusNode: focusNode,
      autofocus: autofocus,
      autoscroll: true,
      onUp: onUp,
      onDown: onDown,
      onLeft: onLeft,
      onRight: onRight,
      onSelect: onSelect,
      onBack: onBack,
      onKeyEvent: onKeyEvent,
      onFocusChanged: onFocusChanged,
      onFocusDisabledWhenWasFocused: onFocusDisabledWhenWasFocused,
      paddingBuilder: (context, animation) =>
          EdgeInsets.all(16.s * lerpDouble(1.0, 1.2, animation)!),
      builder: (context, _, animation) {
        final scale = lerpDouble(1.0, 1.2, animation)!;
        final spacerScale = lerpDouble(1.0, 2.4, animation)!;
        final spacer = SizedBox(width: 8.s * spacerScale);

        return Row(
          children: [
            Transform.scale(scale: scale, child: icon),
            spacer,
            Transform.scale(scale: scale, child: title),
            spacer,
            const Expanded(child: SizedBox()),
            spacer,
            Transform.scale(scale: scale, child: _buildDivider(context)),
            spacer,
            Transform.scale(scale: scale, child: action),
          ],
        );
      },
    );
  }
}

final class _SandstoneSettingsItem extends StatelessWidget {
  const _SandstoneSettingsItem({
    required this.icon,
    required this.title,
    required this.action,
    required this.autofocus,
    required this.focusNode,
    required this.onUp,
    required this.onDown,
    required this.onLeft,
    required this.onRight,
    required this.onSelect,
    required this.onBack,
    required this.onKeyEvent,
    required this.onFocusChanged,
    required this.onFocusDisabledWhenWasFocused,
  });

  final Widget icon;
  final Widget title;
  final Widget action;
  final bool autofocus;
  final FocusNode focusNode;
  final DpadEventCallback? onUp;
  final DpadEventCallback? onDown;
  final DpadEventCallback? onLeft;
  final DpadEventCallback? onRight;
  final DpadEventCallback? onSelect;
  final DpadEventCallback? onBack;
  final KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent;
  final void Function(FocusNode, bool)? onFocusChanged;
  final void Function()? onFocusDisabledWhenWasFocused;

  @override
  Widget build(BuildContext context) {
    return AnimatedFocusSelectionBox(
      focusNode: focusNode,
      autofocus: autofocus,
      autoscroll: true,
      onUp: onUp,
      onDown: onDown,
      onLeft: onLeft,
      onRight: onRight,
      onSelect: onSelect,
      onBack: onBack,
      onKeyEvent: onKeyEvent,
      onFocusChanged: onFocusChanged,
      onFocusDisabledWhenWasFocused: onFocusDisabledWhenWasFocused,
      paddingBuilder: (context, animation) =>
          EdgeInsets.all(16.s * lerpDouble(1.0, 1.2, animation)!),
      builder: (context, _, animation) {
        final scale = lerpDouble(1.0, 1.2, animation)!;
        final spacerScale = lerpDouble(1.0, 2.4, animation)!;
        final spacer = SizedBox(width: 8.s * spacerScale);

        return Row(
          children: [
            Transform.scale(scale: scale, child: icon),
            spacer,
            Transform.scale(scale: scale, child: title),
            spacer,
            const Expanded(child: SizedBox()),
            spacer,
            Transform.scale(scale: scale, child: action),
          ],
        );
      },
    );
  }
}
