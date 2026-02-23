import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';
import 'package:twin_peaks_tv/core/utils/functions/functions.dart';
import 'package:twin_peaks_tv/feature/home/bloc/bloc.dart' as home;
import 'package:twin_peaks_tv/feature/home/home_screen.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/season/widget/season_screen_content.dart';

final class SeasonScreen extends StatelessWidget {
  const SeasonScreen({super.key, required this.season});
  final Seasons season;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<SeasonBlocFactory>()(
        season: season,
        homeScopeNode: context
            .findAncestorStateOfType<HomeScreenState>()!
            .contentFocusScopeNode,
        tabsScopeNode: context
            .findAncestorStateOfType<HomeScreenState>()!
            .tabFocusScopeNode,
      ),
      child: BlocPresentationListener<SeasonBloc, SeasonEffect>(
        listener: (context, effect) => switch (effect) {
          UpdateTabBarOpacity() => context.homeBloc.add(
            home.UpdateTabBarOpacity(opacity: effect.opacity),
          ),
        },
        child: BlocBuilder<SeasonBloc, SeasonState>(
          builder: (context, state) => DpadFocusScope(
            focusScopeNode: context.seasonBloc.screenScopeNode,
            builder: (_, _) => BlocBuilder<SeasonBloc, SeasonState>(
              buildWhen: distinctState((x) => x.seasonState),
              builder: (context, state) => switch (state.seasonState) {
                Data<Season>(value: final season) ||
                Refreshing<Season>(
                  value: Data<Season>(value: final season),
                ) => SeasonScreenContent(season: season),

                Initial<Season>() ||
                Loading<Season>() ||
                Refreshing<Season>() => const Text('TODO: progress indicator'),

                Success<Season>() ||
                Error<Season>() => const Text('TODO: error'),
              },
            ),
          ),
        ),
      ),
    );
  }
}
