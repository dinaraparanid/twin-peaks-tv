import 'package:flutter/cupertino.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';

final class SettingsBlock extends StatelessWidget {
  const SettingsBlock({super.key, this.label, required this.children});
  final String? label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.s,
      children: [
        if (label != null)
          Text(
            label!,
            style: context.appTheme.typography.settings.label.copyWith(
              color: context.appTheme.colors.text.primary,
            ),
          ),

        switch (AppPlatform.targetPlatform) {
          AppPlatforms.android => _MaterialSettingsContainer(children),
          AppPlatforms.tizen => _OneUiSettingsContainer(children),
          AppPlatforms.tvos => _CupertinoSettingsContainer(children),
          AppPlatforms.webos => _SandstoneSettingsContainer(children),
        },
      ],
    );
  }
}

final class _MaterialSettingsContainer extends StatelessWidget {
  const _MaterialSettingsContainer(this.children);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.s,
      children: [
        for (final (index, child) in children.indexed)
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(index == 0 ? 8.r : 0),
              topRight: Radius.circular(index == 0 ? 8.r : 0),
              bottomLeft: Radius.circular(
                index == children.length - 1 ? 8.r : 0,
              ),
              bottomRight: Radius.circular(
                index == children.length - 1 ? 8.r : 0,
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: child,
          ),
      ],
    );
  }
}

final class _CupertinoSettingsContainer extends StatelessWidget {
  const _CupertinoSettingsContainer(this.children);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassLayer(
      settings: AppLiquidGlass.defaultSettings(
        context,
        color: CupertinoColors.transparent,
      ),
      child: FakeGlass(
        shape: LiquidRoundedRectangle(borderRadius: 8.r),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: context.appTheme.colors.settings.blockGradient,
          ),
          child: Column(
            children: [
              for (final (index, child) in children.indexed) ...[
                if (index != 0) const _SettingsDivider(),
                child,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

final class _OneUiSettingsContainer extends StatelessWidget {
  const _OneUiSettingsContainer(this.children);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
      clipBehavior: Clip.hardEdge,
      child: ColoredBox(
        color: context.appTheme.colors.settings.block,
        child: Column(
          children: [
            for (final (index, child) in children.indexed) ...[
              if (index != 0) const _SettingsDivider(),
              child,
            ],
          ],
        ),
      ),
    );
  }
}

final class _SandstoneSettingsContainer extends StatelessWidget {
  const _SandstoneSettingsContainer(this.children);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          for (final (index, child) in children.indexed) ...[
            if (index != 0) const _SettingsDivider(),
            child,
          ],
        ],
      ),
    );
  }
}

final class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.5.s,
      decoration: BoxDecoration(
        color: context.appTheme.colors.settings.divider,
        borderRadius: BorderRadius.all(Radius.circular(0.5.r)),
      ),
    );
  }
}
