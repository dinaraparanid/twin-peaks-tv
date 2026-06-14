import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scalify/flutter_scalify.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/widget/browse/browse_block.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/widget/recent/recent_block.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/widget/search_bar.dart';
import 'package:twin_peaks_tv/feature/main/main_screen.dart';

@RoutePage()
final class EncyclopediaScreen extends StatelessWidget {
  const EncyclopediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<EncyclopediaBlocFactory>()(),
      child: BlocBuilder<EncyclopediaBloc, EncyclopediaState>(
        buildWhen: distinctState((s) {
          return (s.recentCharacters, s.browseCharacters, s.language);
        }),
        builder: (context, state) => Padding(
          padding: EdgeInsets.only(
            left: switch (AppPlatform.isTizen) {
              true => MainScreen.oneUiMenuConstraints.minWidth,
              false => 0.s,
            },
          ),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(
                  top: switch (AppPlatform.isTvOS) {
                    true => 24.s + 48.s,
                    false => 24.s,
                  },
                  left: 24.s,
                  right: 24.s,
                ),
                sliver: SliverToBoxAdapter(
                  child: SearchBar(currentLocale: state.language?.toLocale()),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 32.s)),

              switch ((state.recentCharacters, state.browseCharacters)) {
                (Data(value: final recents), Data(value: final browse)) =>
                  MultiSliver(
                    children: [
                      if (recents.isNotEmpty) ...[
                        SliverToBoxAdapter(
                          child: RecentBlock(characters: recents),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 12.s)),
                      ],

                      SliverToBoxAdapter(child: SizedBox(height: 16.s)),
                      SliverBrowseBlock(characters: browse),
                    ],
                  ),

                (_, _) => SliverFillRemaining(
                  child: Stack(
                    children: [Align(child: AppLoader(radius: 20.s))],
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
