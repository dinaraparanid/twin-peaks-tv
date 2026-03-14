import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';
import 'package:twin_peaks_tv/feature/player/bloc/controls_visibility.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_entry.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_event.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_state.dart';
import 'package:video_player/video_player.dart';

final class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({required PlayerEntry entry}) : super(PlayerState(entry: entry)) {
    controller = VideoPlayerController.networkUrl(Uri.parse(entry.videoUrl))
      ..addListener(_playerListener);

    controller.initialize().then((_) {
      if (!isClosed) add(const PlayPauseEvent());
    });

    on<PlayPauseEvent>((event, emit) async {
      try {
        await (state.isPlaying ? controller.pause() : controller.play());
        emit(state.copyWith(isPlaying: !state.isPlaying));
      } catch (e) {
        AppLogger.instance.e(e);
      }
    });

    on<ChangeControlsVisibilityEvent>((event, emit) {
      emit(state.copyWith(controlsVisibility: event.visibility));

      switch (event.visibility) {
        case ControlsVisibility.hidden:
          playerNode.requestFocus();
        case ControlsVisibility.controls:
          controlsScopeNode.requestFocus();
        case ControlsVisibility.episodes:
          episodesScopeNode.requestFocus();
      }
    });

    on<UpdatePositionsEvent>((event, emit) {
      emit(state.copyWith(position: event.position, duration: event.duration));
    });
  }

  late final VideoPlayerController controller;

  late final focusScopeNode = FocusScopeNode();
  late final playerNode = FocusNode();
  late final controlsScopeNode = FocusScopeNode();
  late final episodesScopeNode = FocusScopeNode();

  void _playerListener() {
    final position = controller.value.position;
    final duration = controller.value.duration;
    add(UpdatePositionsEvent(position: position, duration: duration));
  }

  @override
  Future<void> close() {
    controller.removeListener(_playerListener);
    controller.dispose();
    focusScopeNode.dispose();
    playerNode.dispose();
    controlsScopeNode.dispose();
    episodesScopeNode.dispose();
    return super.close();
  }
}

extension PlayerBlocProvider on BuildContext {
  PlayerBloc get playerBloc => BlocProvider.of<PlayerBloc>(this);
}
