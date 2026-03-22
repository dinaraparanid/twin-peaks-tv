import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

double get _thumbnailWidth => 226.0.s;
double get _thumbnailHeight => 164.0.s;
double get _thumbnailFocusedWidth => _thumbnailWidth * 1.2;
double get _thumbnailFocusedHeight => _thumbnailHeight * 1.2;
double get _thumbnailBorderRadius => 16.0.r;
const _durationThumbnailScale = Duration(milliseconds: 300);

final class EpisodeItem extends StatefulWidget {
  const EpisodeItem({
    super.key,
    this.focusNode,
    required this.episode,
    required this.onSelect,
  });

  final FocusNode? focusNode;
  final Episode episode;
  final VoidCallback onSelect;

  @override
  State<StatefulWidget> createState() => _EpisodeItemState();
}

final class _EpisodeItemState extends State<EpisodeItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _thumbnailScale;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _durationThumbnailScale,
    );

    _thumbnailScale = Tween<double>(begin: 1, end: 1.2).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: _thumbnailFocusedWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.s,
        children: [
          Container(
            width: _thumbnailFocusedWidth,
            height: _thumbnailFocusedHeight,
            alignment: Alignment.center,
            child: AnimatedFocusSelectionBorders(
              focusNode: widget.focusNode,
              autoScroll: true,
              onSelect: (_, _) {
                widget.onSelect();
                return KeyEventResult.handled;
              },
              onFocusChanged: (_, hasFocus) {
                if (hasFocus) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
              builder: (context, node) => ClipRRect(
                borderRadius: BorderRadius.circular(_thumbnailBorderRadius),
                child: _Thumbnail(
                  thumbnailUrl: widget.episode.thumbnailUrl,
                  thumbnailScale: _thumbnailScale,
                ),
              ),
            ),
          ),

          Text(
            widget.episode.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.appTheme.typography.player.episode.copyWith(
              color: context.appTheme.colors.text.primary,
            ),
          ),
        ],
      ),
    );
  }
}

final class _Thumbnail extends AnimatedWidget {
  const _Thumbnail({
    required this.thumbnailUrl,
    required Animation<double> thumbnailScale,
  }) : super(listenable: thumbnailScale);

  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final thumbnailScale = listenable as Animation<double>;

    return AppNetworkImage(
      imageUrl: thumbnailUrl,
      width: _thumbnailWidth * thumbnailScale.value,
      height: _thumbnailHeight * thumbnailScale.value,
    );
  }
}
