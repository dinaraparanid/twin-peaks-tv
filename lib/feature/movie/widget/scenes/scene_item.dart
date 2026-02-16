import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';

const _thumbnailBorderRadius = 16.0;
const _durationThumbnailScale = Duration(milliseconds: 300);

final class SceneItem extends StatefulWidget {
  const SceneItem({super.key, this.focusNode, required this.thumbnailUrl});

  static const thumbnailWidth = 176.0;
  static const thumbnailHeight = 128.0;
  static const thumbnailFocusedWidth = thumbnailWidth * 1.2;
  static const thumbnailFocusedHeight = thumbnailHeight * 1.2;

  final FocusNode? focusNode;
  final String thumbnailUrl;

  @override
  State<StatefulWidget> createState() => _SceneItemState();
}

final class _SceneItemState extends State<SceneItem>
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
    return Container(
      width: SceneItem.thumbnailFocusedWidth,
      height: SceneItem.thumbnailFocusedHeight,
      alignment: Alignment.center,
      child: AnimatedSelectionBorders(
        focusNode: widget.focusNode,
        autoScroll: true,
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
            thumbnailUrl: widget.thumbnailUrl,
            thumbnailScale: _thumbnailScale,
          ),
        ),
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

    return CachedNetworkImage(
      imageUrl: thumbnailUrl,
      fit: BoxFit.cover,
      width: SceneItem.thumbnailWidth * thumbnailScale.value,
      height: SceneItem.thumbnailHeight * thumbnailScale.value,
    );
  }
}
