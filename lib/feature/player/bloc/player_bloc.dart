import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';
import 'package:twin_peaks_tv/core/utils/ext/focus_node_ext.dart';
import 'package:twin_peaks_tv/feature/player/bloc/controls_visibility.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_entry.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_event.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_state.dart';
import 'package:video_player/video_player.dart';

final class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({required PlayerEntry entry}) : super(PlayerState(entry: entry)) {
    controller = VideoPlayerController.networkUrl(Uri.parse(entry.videoUrl))
      ..addListener(_playerListener);

    positionNode.addListener(_positionFocusListener);
    volumeNode.addListener(_volumeFocusListener);
    speedNode.addListener(_speedFocusListener);

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
          controlsScopeNode.requestFocusOnChild(child: controlsMenuNode);
        case ControlsVisibility.episodes:
          episodesScopeNode.requestFocusOnChild();
      }
    });

    on<SeekPositionsEvent>((event, emit) {
      if (!state.position.isDragging) {
        emit(
          state.copyWith(
            position: state.position.copyWith(value: event.position),
            duration: event.duration,
          ),
        );
      }
    });

    on<UpdatePositionEvent>((event, emit) {
      emit(
        state.copyWith(
          position: state.position.copyWith(value: event.position),
        ),
      );
    });

    on<StartPositionDragEvent>((event, emit) {
      emit(state.copyWith(position: state.position.copyWith(isDragging: true)));
    });

    on<SetPositionEvent>((event, emit) async {
      try {
        await controller.seekTo(event.position);
      } catch (e) {
        AppLogger.instance.e(e);
      }

      emit(
        state.copyWith(position: state.position.copyWith(isDragging: false)),
      );
    });

    on<UpdatePositionFocusEvent>((event, emit) {
      emit(
        state.copyWith(
          position: state.position.copyWith(isFocused: event.isFocused),
        ),
      );
    });

    on<SeekVolumeEvent>((event, emit) {
      if (!state.volume.isDragging) {
        emit(
          state.copyWith(volume: state.volume.copyWith(value: event.volume)),
        );
      }
    });

    on<UpdateVolumeEvent>((event, emit) {
      emit(state.copyWith(volume: state.volume.copyWith(value: event.volume)));
    });

    on<StartVolumeDragEvent>((event, emit) {
      emit(state.copyWith(volume: state.volume.copyWith(isDragging: true)));
    });

    on<SetVolumeEvent>((event, emit) async {
      await controller.setVolume(event.volume);
    });

    on<UpdateVolumeFocusEvent>((event, emit) {
      emit(
        state.copyWith(
          volume: state.volume.copyWith(isFocused: event.isFocused),
        ),
      );
    });

    on<SeekSpeedEvent>((event, emit) {
      if (!state.speed.isDragging) {
        emit(state.copyWith(speed: state.speed.copyWith(value: event.speed)));
      }
    });

    on<UpdateSpeedEvent>((event, emit) {
      emit(state.copyWith(speed: state.speed.copyWith(value: event.speed)));
    });

    on<StartSpeedDragEvent>((event, emit) {
      emit(state.copyWith(speed: state.speed.copyWith(isDragging: true)));
    });

    on<SetSpeedEvent>((event, emit) async {
      await controller.setPlaybackSpeed(event.speed);
    });

    on<UpdateSpeedFocusEvent>((event, emit) {
      emit(
        state.copyWith(speed: state.speed.copyWith(isFocused: event.isFocused)),
      );
    });

    on<RequestFocusOnControlsMenuEvent>((event, emit) {
      controlsMenuNode.requestFocus();
    });

    on<RequestFocusOnVolumeEvent>((event, emit) {
      volumeNode.requestFocus();
    });

    on<RequestFocusOnSpeedEvent>((event, emit) {
      speedNode.requestFocus();
    });

    on<RequestFocusOnPositionEvent>((event, emit) {
      positionNode.requestFocus();
    });
  }

  late final VideoPlayerController controller;

  late final focusScopeNode = FocusScopeNode();
  late final playerNode = FocusNode();
  late final controlsScopeNode = FocusScopeNode();
  late final controlsMenuNode = FocusNode();
  late final volumeNode = FocusNode();
  late final speedNode = FocusNode();
  late final positionNode = FocusNode();
  late final episodesScopeNode = FocusScopeNode();

  void _playerListener() {
    final position = controller.value.position;
    final duration = controller.value.duration;
    add(SeekPositionsEvent(position: position, duration: duration));
    add(SeekVolumeEvent(volume: controller.value.volume));
    add(SeekSpeedEvent(speed: controller.value.playbackSpeed));
  }

  void _positionFocusListener() {
    final hasFocus = positionNode.hasFocus;

    add(UpdatePositionFocusEvent(isFocused: hasFocus));

    if (hasFocus) {
      add(const StartPositionDragEvent());
    }
  }

  void _volumeFocusListener() {
    final hasFocus = volumeNode.hasFocus;

    add(UpdateVolumeFocusEvent(isFocused: hasFocus));

    if (hasFocus) {
      add(const StartVolumeDragEvent());
    }
  }

  void _speedFocusListener() {
    final hasFocus = speedNode.hasFocus;

    add(UpdateSpeedFocusEvent(isFocused: hasFocus));

    if (hasFocus) {
      add(const StartSpeedDragEvent());
    }
  }

  @override
  Future<void> close() {
    controller.removeListener(_playerListener);
    positionNode.removeListener(_positionFocusListener);
    volumeNode.removeListener(_volumeFocusListener);
    speedNode.removeListener(_speedFocusListener);

    controller.dispose();
    playerNode.dispose();
    controlsScopeNode.dispose();
    controlsMenuNode.dispose();
    volumeNode.dispose();
    speedNode.dispose();
    positionNode.dispose();
    episodesScopeNode.dispose();
    focusScopeNode.dispose();
    return super.close();
  }
}

extension PlayerBlocProvider on BuildContext {
  PlayerBloc get playerBloc => BlocProvider.of<PlayerBloc>(this);
}
