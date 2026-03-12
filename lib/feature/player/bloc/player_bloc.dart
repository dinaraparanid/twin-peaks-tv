import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_entry.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_event.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_state.dart';
import 'package:video_player/video_player.dart';

final class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({required PlayerEntry entry}) : super(PlayerState(entry: entry)) {
    controller = VideoPlayerController.networkUrl(Uri.parse(entry.videoUrl))
      ..addListener(_controllerListener);

    controller.initialize().then((_) => controller.play());
  }

  late final VideoPlayerController controller;

  void _controllerListener() {}

  @override
  Future<void> close() {
    controller.removeListener(_controllerListener);
    controller.dispose();
    return super.close();
  }
}

extension PlayerBlocProvider on BuildContext {
  PlayerBloc get playerBloc => BlocProvider.of<PlayerBloc>(this);
}
