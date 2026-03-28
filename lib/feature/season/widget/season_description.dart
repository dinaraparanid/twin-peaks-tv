import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/functions/functions.dart';
import 'package:twin_peaks_tv/core/utils/platform.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';

const _expandDuration = Duration(milliseconds: 300);

final class SeasonDescription extends StatefulWidget {
  const SeasonDescription({super.key, required this.description});

  final String description;

  @override
  State<StatefulWidget> createState() => _SeasonDescriptionState();
}

final class _SeasonDescriptionState extends State<SeasonDescription> {
  late final _focusNode = context.seasonBloc.descriptionNode;

  @override
  void initState() {
    _focusNode.addListener(_focusListener);

    super.initState();
  }

  void _focusListener() {
    if (!_focusNode.hasFocus) {
      context.seasonBloc.add(const CollapseDescription());
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedFocusSelectionBorders(
      focusNode: _focusNode,
      duration: _expandDuration,
      autoscroll: true,
      paddingBuilder: (context, animationValue) {
        return EdgeInsets.all(lerpDouble(0, 8.s, animationValue)!);
      },
      onDown: (_, _) {
        context.seasonBloc.add(const RequestFocusOnCast());
        return KeyEventResult.handled;
      },
      onLeft: (_, _) {
        if (AppPlatform.isWebOS) {
          context.seasonBloc.add(const RequestFocusOnCarousel());
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      onRight: (_, _) {
        if (!AppPlatform.isWebOS) {
          context.seasonBloc.add(const RequestFocusOnCarousel());
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      onSelect: (node, _) {
        context.seasonBloc.add(const SwitchDescriptionExpanded());
        return KeyEventResult.handled;
      },
      builder: (context, node, _) => BlocBuilder<SeasonBloc, SeasonState>(
        buildWhen: distinctState((s) => s.isDescriptionExpanded),
        builder: (context, state) => _DescriptionContent(
          node: node,
          isDescriptionExpanded: state.isDescriptionExpanded,
          description: widget.description,
        ),
      ),
    );
  }
}

final class _DescriptionContent extends StatelessWidget {
  const _DescriptionContent({
    required this.node,
    required this.isDescriptionExpanded,
    required this.description,
  });

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

    return AnimatedCrossFade(
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
        final align = AppPlatform.isWebOS ? TextAlign.end : TextAlign.start;

        final painter = TextPainter(
          text: span,
          maxLines: 2,
          textDirection: TextDirection.ltr,
          textAlign: align,
        );

        painter.layout(maxWidth: constraints.maxWidth);

        final position = painter.getPositionForOffset(
          Offset(constraints.maxWidth, painter.height),
        );

        return RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: align,
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
    final align = AppPlatform.isWebOS ? TextAlign.end : TextAlign.start;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          textAlign: align,
          text: TextSpan(text: description, style: descriptionStyle),
        ),
        RichText(
          textAlign: align,
          text: TextSpan(text: context.ln.general_less, style: moreLessStyle),
        ),
      ],
    );
  }
}
