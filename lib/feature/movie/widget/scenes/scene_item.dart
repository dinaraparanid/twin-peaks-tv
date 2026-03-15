import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';

const _durationThumbnailScale = Duration(milliseconds: 300);

final class SceneItem extends StatefulWidget {
  const SceneItem({super.key, this.focusNode, required this.thumbnailUrl});

  static double get thumbnailWidth => 226.0.s;
  static double get thumbnailHeight => 164.0.s;
  static double get thumbnailFocusedWidth => thumbnailWidth * 1.2;
  static double get thumbnailFocusedHeight => thumbnailHeight * 1.2;

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
    return Container(
      width: SceneItem.thumbnailFocusedWidth,
      height: SceneItem.thumbnailFocusedHeight,
      alignment: Alignment.center,
      child: AnimatedFocusSelectionBorders(
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
          borderRadius: BorderRadius.circular(16.0.r),
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

    return AppNetworkImage(
      imageUrl: thumbnailUrl,
      width: SceneItem.thumbnailWidth * thumbnailScale.value,
      height: SceneItem.thumbnailHeight * thumbnailScale.value,
    );
  }
}
