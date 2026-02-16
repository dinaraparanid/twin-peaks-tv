import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';

const _thumbnailWidth = 176.0;
const _thumbnailHeight = 128.0;
const _thumbnailFocusedWidth = _thumbnailWidth * 1.2;
const _thumbnailFocusedHeight = _thumbnailHeight * 1.2;
const _thumbnailBorderRadius = 16.0;
const _durationThumbnailScale = Duration(milliseconds: 300);
const _starSize = 12.0;

final class EpisodeItem extends StatefulWidget {
  const EpisodeItem({super.key, this.focusNode, required this.episode});

  final FocusNode? focusNode;
  final Episode episode;

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

    _thumbnailScale = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Container(
          width: _thumbnailFocusedWidth,
          height: _thumbnailFocusedHeight,
          alignment: Alignment.center,
          child: AnimatedSelectionBorders(
            focusNode: widget.focusNode,
            autoScroll: true,
            onSelect: (_, _) {
              // TODO(paranid5): экран с плеером
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

        Expanded(child: _Content(episode: widget.episode)),
      ],
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

    return CachedNetworkImage(
      imageUrl: thumbnailUrl,
      fit: BoxFit.cover,
      width: _thumbnailWidth * thumbnailScale.value,
      height: _thumbnailHeight * thumbnailScale.value,
    );
  }
}

final class _Content extends StatelessWidget {
  const _Content({required this.episode});
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          episode.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.appTheme.typography.episode.title.copyWith(
            color: context.appTheme.colors.text.primary,
          ),
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Assets.icons.star.full.svg(width: _starSize, height: _starSize),

            Text(
              episode.rating.toStringAsFixed(1),
              style: context.appTheme.typography.episode.rating.copyWith(
                color: context.appTheme.colors.text.secondary,
              ),
            ),
          ],
        ),

        Text(
          episode.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: context.appTheme.typography.episode.description.copyWith(
            color: context.appTheme.colors.text.secondary,
          ),
        ),
      ],
    );
  }
}
