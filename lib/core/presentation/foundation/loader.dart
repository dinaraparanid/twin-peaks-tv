import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';

final class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.borderRadius,
    this.strokeWidth,
    this.radius,
  });

  final BorderRadiusGeometry? borderRadius;
  final double? strokeWidth;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return switch (AppPlatform.targetPlatform) {
      AppPlatforms.android => _MaterialLoader(
        borderRadius: borderRadius,
        strokeWidth: strokeWidth,
        radius: radius,
      ),

      AppPlatforms.tizen => _OneUiLoader(
        borderRadius: borderRadius,
        strokeWidth: strokeWidth,
        radius: radius,
      ),

      AppPlatforms.tvos => _CupertinoLoader(radius: radius),

      AppPlatforms.webos => _SandstoneLoader(
        borderRadius: borderRadius,
        strokeWidth: strokeWidth,
        radius: radius,
      ),
    };
  }
}

final class _MaterialLoader extends StatelessWidget {
  const _MaterialLoader({this.borderRadius, this.strokeWidth, this.radius});

  final BorderRadiusGeometry? borderRadius;
  final double? strokeWidth;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final diameter = (radius ?? 12.s) * 2;

    return SizedBox.square(
      dimension: diameter,
      child: ProgressIndicatorTheme(
        data: ProgressIndicatorThemeData(
          color: context.appTheme.colors.primary.primary,
          borderRadius: borderRadius,
          strokeWidth: strokeWidth,
          circularTrackPadding: EdgeInsets.zero,
          // ignore: deprecated_member_use
          year2023: false,
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

final class _CupertinoLoader extends StatelessWidget {
  const _CupertinoLoader({this.radius});
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: context.appTheme.colors.primary.primary,
      radius: radius ?? 24.s,
    );
  }
}

final class _OneUiLoader extends StatefulWidget {
  const _OneUiLoader({this.borderRadius, this.strokeWidth, this.radius});

  final BorderRadiusGeometry? borderRadius;
  final double? strokeWidth;
  final double? radius;

  @override
  State<StatefulWidget> createState() => _OneUiLoaderState();
}

final class _OneUiLoaderState extends State<_OneUiLoader>
    with TickerProviderStateMixin {
  static const _durationSpin = Duration(seconds: 1);

  late final AnimationController _controller;

  late final Animation<double> _spin;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _durationSpin)
      ..repeat();

    _spin = CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final diameter = (widget.radius ?? 12.s) * 2;

    return SizedBox.square(
      dimension: diameter,
      child: Transform.rotate(
        angle: -math.pi / 4,
        child: Stack(
          children: [
            _OneUiAnimatedPrimaryLoader(
              borderRadius: widget.borderRadius,
              strokeWidth: widget.strokeWidth,
              radius: widget.radius,
              spin: _spin,
            ),

            _OneUiAnimatedSecondaryLoader(
              borderRadius: widget.borderRadius,
              strokeWidth: widget.strokeWidth,
              radius: widget.radius,
              spin: ReverseAnimation(_spin),
            ),
          ],
        ),
      ),
    );
  }
}

final class _OneUiAnimatedPrimaryLoader extends AnimatedWidget {
  const _OneUiAnimatedPrimaryLoader({
    this.borderRadius,
    this.strokeWidth,
    this.radius,
    required Animation<double> spin,
  }) : super(listenable: spin);

  final BorderRadiusGeometry? borderRadius;
  final double? strokeWidth;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final spin = listenable as Animation<double>;

    return RotationTransition(
      turns: spin,
      child: ProgressIndicatorTheme(
        data: ProgressIndicatorThemeData(
          color: context.appTheme.colors.primary.primary,
          borderRadius: borderRadius,
          strokeWidth: strokeWidth,
          circularTrackPadding: EdgeInsets.zero,
          strokeCap: StrokeCap.round,
        ),
        child: const CircularProgressIndicator(value: 0.4),
      ),
    );
  }
}

final class _OneUiAnimatedSecondaryLoader extends AnimatedWidget {
  const _OneUiAnimatedSecondaryLoader({
    this.borderRadius,
    this.strokeWidth,
    this.radius,
    required Animation<double> spin,
  }) : super(listenable: spin);

  final BorderRadiusGeometry? borderRadius;
  final double? strokeWidth;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final spin = listenable as Animation<double>;

    return RotationTransition(
      turns: spin,
      child: Transform.flip(
        flipX: true,
        child: ProgressIndicatorTheme(
          data: ProgressIndicatorThemeData(
            color: context.appTheme.colors.primary.primary04,
            borderRadius: borderRadius,
            strokeWidth: strokeWidth,
            circularTrackPadding: EdgeInsets.zero,
            strokeCap: StrokeCap.round,
          ),
          child: const CircularProgressIndicator(value: 0.4),
        ),
      ),
    );
  }
}

final class _SandstoneLoader extends StatelessWidget {
  const _SandstoneLoader({this.borderRadius, this.strokeWidth, this.radius});

  final BorderRadiusGeometry? borderRadius;
  final double? strokeWidth;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final diameter = (radius ?? 12.s) * 2;

    return SizedBox.square(
      dimension: diameter,
      child: ProgressIndicatorTheme(
        data: ProgressIndicatorThemeData(
          color: context.appTheme.colors.primary.primary,
          circularTrackColor: context.appTheme.colors.primary.primary04,
          borderRadius: borderRadius,
          strokeWidth: strokeWidth,
          circularTrackPadding: EdgeInsets.zero,
          // ignore: deprecated_member_use
          year2023: true,
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
