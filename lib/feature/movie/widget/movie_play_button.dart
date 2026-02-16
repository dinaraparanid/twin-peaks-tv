import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/ext/color_ext.dart';
import 'package:twin_peaks_tv/feature/movie/bloc/bloc.dart';

const _durationTransition = Duration(milliseconds: 300);

final class MoviePlayButton extends StatefulWidget {
  const MoviePlayButton({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  State<StatefulWidget> createState() => _MoviePlayButtonState();
}

final class _MoviePlayButtonState extends State<MoviePlayButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _focusTransition;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _durationTransition,
    );

    _focusTransition = Tween<double>(begin: 0, end: 1).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollGroupDpadFocus(
      focusNode: context.movieBloc.playButtonNode,
      onUp: (_, _) {
        context.movieBloc.add(const RequestFocusOnDescription());
        return KeyEventResult.handled;
      },
      onDown: (_, _) {
        context.movieBloc.add(const RequestFocusOnCast());
        return KeyEventResult.handled;
      },
      onSelect: (_, _) {
        // TODO(paranid5): плеер widget.videoUrl
        return KeyEventResult.handled;
      },
      onFocusChanged: (_, hasFocus) {
        if (hasFocus) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      builder: (context, node) =>
          _PlayButtonAnimation(focusTransition: _focusTransition),
    );
  }
}

final class _PlayButtonAnimation extends AnimatedWidget {
  const _PlayButtonAnimation({required Animation<double> focusTransition})
    : super(listenable: focusTransition);

  @override
  Widget build(BuildContext context) {
    final focusTransition = listenable as Animation<double>;
    final movieTypography = context.appTheme.typography.movieInfo;
    final buttonColors = context.appTheme.colors.button.filled;

    final containerColor = Color.lerp(
      buttonColors.container,
      buttonColors.focusedContainer,
      focusTransition.value,
    );

    final contentColor = Color.lerp(
      buttonColors.content,
      buttonColors.focusedContent,
      focusTransition.value,
    );

    final contentStyle = movieTypography.playButton.copyWith(
      color: contentColor,
    );

    final radius = BorderRadius.all(
      Radius.circular(switch ((Platform.isAndroid, Platform.isIOS)) {
        (true, _) => 24,
        (false, true) => 8,
        (false, false) => 16,
      }),
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(borderRadius: radius, color: containerColor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Assets.icons.play.svg(
            width: 12,
            height: 12,
            colorFilter: contentColor!.toColorFilter(),
          ),

          Text(context.ln.movie_watch, style: contentStyle),
        ],
      ),
    );
  }
}
