import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_description.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_properties.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_title.dart';

final class SeasonScreenContent extends StatefulWidget {
  const SeasonScreenContent({super.key, required this.season});

  final Season season;

  @override
  State<StatefulWidget> createState() => _SeasonScreenContentState();
}

final class _SeasonScreenContentState extends State<SeasonScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TODO(paranid5): Image with carousel
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 120),
                          SeasonProperties(season: widget.season),
                          SeasonTitle(title: widget.season.title),
                          const SizedBox(height: 8),
                          SeasonDescription(
                            description: widget.season.description,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Flexible(
                flex: 1,
                child: SizedBox(), // TODO(paranid5): Carousel
              ),
            ],
          ),
        ),
      ],
    );
  }
}
