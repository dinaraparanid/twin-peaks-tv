import 'package:flutter/widgets.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:twin_peaks_tv/assets/assets.gen.dart';

const _maxStars = 10;
double get _starSize => 18.0.iz;

final class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final halfStar = rating - fullStars > 0.25 ? 1 : 0;
    final emptyStars = _maxStars - fullStars - halfStar;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < fullStars; ++i)
          Assets.icons.star.full.svg(width: _starSize, height: _starSize),

        if (halfStar != 0)
          Assets.icons.star.half.svg(width: _starSize, height: _starSize),

        for (int i = 0; i < emptyStars; ++i)
          Assets.icons.star.empty.svg(width: _starSize, height: _starSize),
      ],
    );
  }
}
