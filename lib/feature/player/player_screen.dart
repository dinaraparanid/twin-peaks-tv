import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_plus/tv_plus.dart';
import 'package:twin_peaks_tv/core/di/app_module.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/player/bloc/bloc.dart';
import 'package:twin_peaks_tv/feature/player/widget/playback_menu.dart';
import 'package:twin_peaks_tv/feature/player/widget/player.dart';
import 'package:twin_peaks_tv/feature/player/widget/top_bar.dart';

@RoutePage()
final class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key, required this.entry});
  final PlayerEntry entry;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<PlayerBlocFactory>()(entry: entry),
      child: BlocBuilder<PlayerBloc, PlayerState>(
        buildWhen: distinctState((s) => s.playerState),
        builder: (context, state) => DpadFocusScope(
          focusScopeNode: context.playerBloc.focusScopeNode,
          builder: (context, _) {
            final child = switch (state.playerState) {
              Success() => const Stack(
                children: [
                  Player(),
                  PositionedTopBar(),
                  PositionedPlaybackMenu(),
                ],
              ),

              _ => const SizedBox(),
            };

            return switch (AppPlatform.targetPlatform) {
              AppPlatforms.android => _MaterialUi(child: child),
              AppPlatforms.tizen => _MaterialUi(child: child),
              AppPlatforms.tvos => _CupertinoUi(child: child),
              AppPlatforms.webos => _MaterialUi(child: child),
            };
          },
        ),
      ),
    );
  }
}

final class _MaterialUi extends StatelessWidget {
  const _MaterialUi({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appTheme.colors.background.primary,
      resizeToAvoidBottomInset: false,
      body: child,
    );
  }
}

final class _CupertinoUi extends StatelessWidget {
  const _CupertinoUi({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: context.appTheme.colors.background.primary,
      resizeToAvoidBottomInset: false,
      child: child,
    );
  }
}
