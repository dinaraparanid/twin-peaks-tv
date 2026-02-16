import 'package:auto_route/auto_route.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/ui_state.dart';
import 'package:twin_peaks_tv/core/utils/functions/functions.dart';
import 'package:twin_peaks_tv/feature/home/bloc/bloc.dart' as home;
import 'package:twin_peaks_tv/feature/movie/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/movie/widget/movie_screen_content.dart';

@RoutePage()
final class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<MovieBlocFactory>()(),
      child: BlocPresentationListener<MovieBloc, MovieEffect>(
        listener: (context, effect) => switch (effect) {
          UpdateTabBarOpacity() => context.homeBloc.add(
            home.UpdateTabBarOpacity(opacity: effect.opacity),
          ),
        },
        child: BlocBuilder<MovieBloc, MovieState>(
          buildWhen: distinctState((x) => x.movieState),
          builder: (context, state) {
            return switch (state.movieState) {
              Data<Movie>(value: final movie) ||
              Refreshing<Movie>(
                value: Data<Movie>(value: final movie),
              ) => MovieScreenContent(movie: movie),

              Initial<Movie>() ||
              Loading<Movie>() ||
              Refreshing<Movie>() => const Text('TODO: progress indicator'),

              Success<Movie>() || Error<Movie>() => const Text('TODO: error'),
            };
          },
        ),
      ),
    );
  }
}
