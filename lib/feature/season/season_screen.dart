import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/feature/home/home_screen.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';

final class SeasonScreen extends StatelessWidget {
  const SeasonScreen({super.key, required this.season});

  final Seasons season;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<SeasonBlocFactory>()(season: season),
      child: BlocBuilder<SeasonBloc, SeasonState>(
        builder: (context, state) {
          return Stack(
            children: [
              Align(
                child: DpadFocus(
                  onUp: (_, _) {
                    context
                        .findAncestorStateOfType<HomeScreenState>()
                        ?.tabFocusScopeNode
                        .requestFocus();

                    return KeyEventResult.handled;
                  },
                  onLeft: (_, _) {
                    context
                        .findAncestorStateOfType<TvNavigationDrawerState>()
                        ?.controller
                        .requestFocusOnMenu();

                    return KeyEventResult.handled;
                  },
                  builder: (node) {
                    return Container(
                      width: 500,
                      height: 500,
                      color: node.hasFocus ? Colors.green : Colors.indigo,
                      alignment: Alignment.center,
                      child: Text('TODO ${season.path}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
