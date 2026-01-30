import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/constants/constants.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/feature/home/home_screen.dart';
import 'package:twin_peaks_tv/feature/season/bloc/bloc.dart';

final class SeasonScreen extends StatefulWidget {
  const SeasonScreen({super.key, required this.season});
  final Seasons season;

  @override
  State<StatefulWidget> createState() => _SeasonScreenState();
}

final class _SeasonScreenState extends State<SeasonScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(FocusConstants.navigatorDelay, () {
        if (mounted) {
          context
              .findAncestorStateOfType<HomeScreenState>()
              ?.tabFocusScopeNode
              .requestFocus();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<SeasonBlocFactory>()(season: widget.season),
      child: BlocBuilder<SeasonBloc, SeasonState>(
        builder: (context, state) {
          return Stack(
            children: [
              Align(
                child: DpadFocus(
                  autofocus: true,
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
                      child: Text('TODO ${widget.season.path}'),
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
