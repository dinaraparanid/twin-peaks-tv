import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';

final class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.focusNode,
    required this.onClick,
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

  final FocusNode? focusNode;
  final VoidCallback onClick;
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
      paddingBuilder: (_, _) => EdgeInsets.all(4.s),
      decorationBuilder: (context, animation, child) {
        return switch (AppPlatform.targetPlatform) {
          AppPlatforms.android => _MaterialDecoration.new,
          AppPlatforms.tizen => _OneUiDecoration.new,
          AppPlatforms.tvos => _CupertinoDecoration.new,
          AppPlatforms.webos => _SandstoneDecoration.new,
        }(focusAnimation: animation, child: child);
      },
      onUp: onUp,
      onDown: onDown,
      onLeft: onLeft,
      onRight: onRight,
      onSelect: onSelect,
      onBack: onBack,
      onKeyEvent: onKeyEvent,
      onFocusChanged: onFocusChanged,
      onFocusDisabledWhenWasFocused: onFocusDisabledWhenWasFocused,
      builder: (context, focusNode, animation) {
        return _BackIcon(onClick: onClick);
      },
    );
  }
}

final class _MaterialDecoration extends StatelessWidget {
  const _MaterialDecoration({
    required this.focusAnimation,
    required this.child,
  });

  final double focusAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.r,
          color: Color.lerp(
            context.appTheme.colors.transparent,
            context.appTheme.colors.button.filled.focusedContainer,
            focusAnimation,
          )!,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(1.s, 1.s),
            blurRadius: 1.s,
            blurStyle: BlurStyle.outer,
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}

final class _CupertinoDecoration extends StatelessWidget {
  const _CupertinoDecoration({
    required this.focusAnimation,
    required this.child,
  });

  final double focusAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassLayer(
      settings: AppLiquidGlass.defaultSettings(
        context,
        color: Color.lerp(
          context.appTheme.colors.transparent,
          context.appTheme.colors.primary.primary10,
          focusAnimation,
        ),
      ),
      child: LiquidGlass(shape: const LiquidOval(), child: child),
    );
  }
}

final class _OneUiDecoration extends StatelessWidget {
  const _OneUiDecoration({required this.focusAnimation, required this.child});

  final double focusAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.r,
          color: Color.lerp(
            context.appTheme.colors.transparent,
            context.appTheme.colors.button.filled.focusedContainer,
            focusAnimation,
          )!,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(1.s, 1.s),
            blurRadius: 1.s,
            blurStyle: BlurStyle.outer,
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}

final class _SandstoneDecoration extends StatelessWidget {
  const _SandstoneDecoration({
    required this.focusAnimation,
    required this.child,
  });

  final double focusAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
        color: Color.lerp(
          context.appTheme.colors.transparent,
          context.appTheme.colors.button.filled.focusedContainer,
          focusAnimation,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(1.s, 1.s),
            blurRadius: 1.s,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: child,
    );
  }
}

final class _BackIcon extends StatelessWidget {
  const _BackIcon({required this.onClick});

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Icon(
        switch (AppPlatform.targetPlatform) {
          AppPlatforms.android => Icons.arrow_back,
          AppPlatforms.tizen => Icons.chevron_left_rounded,
          AppPlatforms.tvos => CupertinoIcons.back,
          AppPlatforms.webos => Icons.chevron_left_sharp,
        },
        size: 24.s,
        color: context.appTheme.colors.button.filled.content,
      ),
    );
  }
}
