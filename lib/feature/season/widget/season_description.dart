import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/functions/functions.dart';
import 'package:twin_peaks_tv/feature/home/home_screen.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';

const _expandDuration = Duration(milliseconds: 300);

final class SeasonDescription extends StatefulWidget {
  const SeasonDescription({super.key, required this.description});
  final String description;

  @override
  State<StatefulWidget> createState() => _SeasonDescriptionState();
}

final class _SeasonDescriptionState extends State<SeasonDescription>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _borderAnimation;

  late final _focusNode = FocusNode();

  late final _focusScopeNode = context
      .findAncestorStateOfType<HomeScreenState>()!
      .contentFocusScopeNode;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _expandDuration);

    _borderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusScopeNode.addListener(_scopeListener);
    });

    super.initState();
  }

  void _scopeListener() {
    final child = _focusScopeNode.focusedChild;

    final noFocusedChild =
        child == null || child.toStringShort().contains('Navigator');

    if (_focusScopeNode.hasFocus && noFocusedChild) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _focusScopeNode.removeListener(_scopeListener);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DpadFocus(
      focusNode: _focusNode,
      onFocusChanged: (_, isFocused) {
        if (isFocused) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      onSelect: (node, _) {
        context.seasonBloc.add(const SwitchDescriptionExpanded());
        return KeyEventResult.handled;
      },
      builder: (node) => BlocBuilder<SeasonBloc, SeasonState>(
        buildWhen: distinctState((s) => s.isDescriptionExpanded),
        builder: (context, state) => _DescriptionContent(
          node: node,
          isDescriptionExpanded: state.isDescriptionExpanded,
          description: widget.description,
          borderAnimation: _borderAnimation,
        ),
      ),
    );
  }
}

final class _DescriptionContent extends AnimatedWidget {
  const _DescriptionContent({
    required this.node,
    required this.isDescriptionExpanded,
    required this.description,
    required Animation<double> borderAnimation,
  }) : super(listenable: borderAnimation);

  final FocusNode node;
  final bool isDescriptionExpanded;
  final String description;

  @override
  Widget build(BuildContext context) {
    final movieTypography = context.appTheme.typography.movieInfo;
    final textColors = context.appTheme.colors.text;

    final descriptionStyle = movieTypography.description.copyWith(
      color: textColors.tertiary,
    );

    final moreLessStyle = movieTypography.description.copyWith(
      color: textColors.primary,
    );

    final borderAnimation = listenable as Animation<double>;

    return Container(
      padding: EdgeInsets.all(lerpDouble(0, 8, borderAnimation.value)!),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: GradientBoxBorder(
          gradient: Gradient.lerp(
            context.appTheme.colors.gradients.transparent,
            context.appTheme.colors.gradients.selection,
            borderAnimation.value,
          )!,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          const SizedBox(width: double.infinity, height: 10),
          AnimatedCrossFade(
            duration: _expandDuration,
            alignment: Alignment.topLeft,
            crossFadeState: isDescriptionExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: _CollapsedDescription(
              description: description,
              descriptionStyle: descriptionStyle,
              moreLessStyle: moreLessStyle,
            ),
            secondChild: _ExpandedDescription(
              description: description,
              descriptionStyle: descriptionStyle,
              moreLessStyle: moreLessStyle,
            ),
          ),
        ],
      ),
    );
  }
}

final class _CollapsedDescription extends StatelessWidget {
  const _CollapsedDescription({
    required this.description,
    required this.descriptionStyle,
    required this.moreLessStyle,
  });

  final String description;
  final TextStyle descriptionStyle;
  final TextStyle moreLessStyle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: description, style: descriptionStyle);

        final painter = TextPainter(
          text: span,
          maxLines: 2,
          textDirection: TextDirection.ltr,
        );

        painter.layout(maxWidth: constraints.maxWidth);

        final position = painter.getPositionForOffset(
          Offset(constraints.maxWidth, painter.height),
        );

        return RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          text: TextSpan(
            text: '${description.substring(0, position.offset - 12)}... ',
            style: descriptionStyle,
            children: [
              TextSpan(text: context.ln.general_more, style: moreLessStyle),
            ],
          ),
        );
      },
    );
  }
}

final class _ExpandedDescription extends StatelessWidget {
  const _ExpandedDescription({
    required this.description,
    required this.descriptionStyle,
    required this.moreLessStyle,
  });

  final String description;
  final TextStyle descriptionStyle;
  final TextStyle moreLessStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(text: description, style: descriptionStyle),
        ),
        RichText(
          text: TextSpan(
            text: context.ln.general_less,
            style: descriptionStyle,
          ),
        ),
      ],
    );
  }
}
