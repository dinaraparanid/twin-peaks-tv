import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/movie/cast.dart';
import 'package:twin_peaks_tv/feature/season/widget/material_season_wallpaper.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_description.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_properties.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_title.dart';

final class SeasonScreenContent extends StatefulWidget {
  const SeasonScreenContent({super.key, required this.season});

  final Season season;

  @override
  State<StatefulWidget> createState() => SeasonScreenContentState();
}

final class SeasonScreenContentState extends State<SeasonScreenContent> {
  late final FocusNode descriptionNode = FocusNode();
  late final FocusScopeNode castScopeNode = FocusScopeNode();

  @override
  void dispose() {
    descriptionNode.dispose();
    castScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.topRight,
          child: MaterialSeasonWallpaper(
            thumbnailUrl:
                'https://platform.eater.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/8537465/twin_peaks_abc_archives.jpg?quality=90&strip=all&crop=0%2C16.722222222222%2C100%2C66.555555555556&w=2400',
          ),
        ),

        CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
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
                            focusNode: descriptionNode,
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
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            SliverToBoxAdapter(
              child: Cast(
                actors: widget.season.actors,
                focusScopeNode: castScopeNode,
                onUp: (_, _, _) {
                  descriptionNode.requestFocus();
                  return KeyEventResult.handled;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
