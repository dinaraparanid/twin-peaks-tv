import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';

final class AppSwitch extends StatelessWidget {
  const AppSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => _MaterialSwitch.new,
      AppPlatforms.tizen => _MaterialSwitch.new,
      AppPlatforms.tvos => _CupertinoSwitch.new,
      AppPlatforms.webos => _MaterialSwitch.new,
    }(value: value, onChanged: onChanged);
  }
}

final class _MaterialSwitch extends StatelessWidget {
  const _MaterialSwitch({required this.value, required this.onChanged});

  static const _switchInternalSize = 32.0;

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.s,
      child: Transform.scale(
        scale: 28.s / _switchInternalSize,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: context.appTheme.colors.primary.primary80,
          activeThumbColor: context.appTheme.colors.text.primary,
          inactiveTrackColor: context.appTheme.colors.background.primary,
          inactiveThumbColor: context.appTheme.colors.text.primary,
        ),
      ),
    );
  }
}

final class _CupertinoSwitch extends StatelessWidget {
  const _CupertinoSwitch({required this.value, required this.onChanged});

  final bool value;
  final void Function(bool)? onChanged;

  static const _switchInternalSize = 39.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.s,
      child: Transform.scale(
        scale: 32.s / _switchInternalSize,
        child: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: context.appTheme.colors.primary.primary80,
          thumbColor: context.appTheme.colors.text.primary,
          inactiveTrackColor: context.appTheme.colors.background.primary,
          inactiveThumbColor: context.appTheme.colors.text.primary,
        ),
      ),
    );
  }
}
