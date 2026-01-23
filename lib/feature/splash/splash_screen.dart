import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:twin_peaks_tv/core/presentation/theme/app_theme_provider.dart';
import 'package:twin_peaks_tv/core/presentation/theme/strings.dart';
import 'package:twin_peaks_tv/gen/assets.gen.dart';

const _durationTextAppear = Duration(milliseconds: 1500);
const _durationEndSplash = Duration(milliseconds: 1000);

@RoutePage()
final class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

final class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _textOpacity;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _durationTextAppear,
    )..addStatusListener(_animationListener);

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    super.initState();
  }

  void _animationListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Future.delayed(_durationEndSplash, () {
        // TODO(paranid5): navigate to home screen
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Assets.images.bgSplashScreen.path, fit: BoxFit.cover),

        Align(child: _SplashScreenText(textOpacity: _textOpacity)),
      ],
    );
  }
}

final class _SplashScreenText extends AnimatedWidget {
  const _SplashScreenText({required Animation<double> textOpacity})
    : super(listenable: textOpacity);

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final textOpacity = listenable as Animation<double>;

    return Opacity(
      opacity: textOpacity.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StrokeText(
            text: context.ln.splash_header,
            strokeColor: theme.colors.primary,
            strokeWidth: 3,
            textAlign: TextAlign.center,
            textStyle: theme.typography.splash.splashHeader.copyWith(
              color: theme.colors.splash.text,
            ),
          ),

          StrokeText(
            text: context.ln.splash_subtext,
            strokeColor: theme.colors.primary,
            strokeWidth: 2,
            textAlign: TextAlign.center,
            textStyle: theme.typography.splash.splashSubText.copyWith(
              color: theme.colors.splash.text,
            ),
          ),
        ],
      ),
    );
  }
}
