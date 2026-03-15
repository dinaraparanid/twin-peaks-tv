import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/utils/functions/functions.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/player/widget/playback_menu.dart';
import 'package:twin_peaks_tv/feature/player/widget/player.dart';

@RoutePage()
final class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key, required this.entry});

  final PlayerEntry entry;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<PlayerBlocFactory>()(entry: entry),
      child: BlocBuilder<PlayerBloc, PlayerState>(
        buildWhen: ignoreState(),
        builder: (context, state) => DpadFocusScope(
          focusScopeNode: context.playerBloc.focusScopeNode,
          builder: (context, _) =>
              const Stack(children: [Player(), PositionedPlaybackMenu()]),
        ),
      ),
    );
  }
}
