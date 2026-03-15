import 'package:async/async.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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

    on<PlayPauseEvent>(_onPlayPause, transformer: sequential());
    on<ChangeControlsVisibilityEvent>(_onChangeControlsVisibility);

    on<SeekPositionsEvent>(_onSeekPositions);
    on<UpdatePositionEvent>(_onUpdatePosition, transformer: restartable());
    on<StartPositionDragEvent>(_onStartPositionDrag, transformer: droppable());
    on<SetPositionEvent>(_onSetPosition, transformer: droppable());
    on<UpdatePositionFocusEvent>(_onUpdatePositionFocus);

    on<SeekVolumeEvent>(_onSeekVolume);
    on<UpdateVolumeEvent>(_onUpdateVolume, transformer: restartable());
    on<StartVolumeDragEvent>(_onStartVolumeDrag, transformer: droppable());
    on<SetVolumeEvent>(_onSetVolume, transformer: droppable());
    on<UpdateVolumeFocusEvent>(_onUpdateVolumeFocus);

    on<SeekSpeedEvent>(_onSeekSpeed, transformer: restartable());
    on<UpdateSpeedEvent>(_onUpdateSpeed, transformer: restartable());
    on<StartSpeedDragEvent>(_onStartSpeedDrag, transformer: droppable());
    on<SetSpeedEvent>(_onSetSpeed, transformer: droppable());
    on<UpdateSpeedFocusEvent>(_onUpdateSpeedFocus);

    on<RequestFocusOnControlsMenuEvent>(_onRequestFocusOnControlsMenu);
    on<RequestFocusOnVolumeEvent>(_onRequestFocusOnVolume);
    on<RequestFocusOnSpeedEvent>(_onRequestFocusOnSpeed);
    on<RequestFocusOnPositionEvent>(_onRequestFocusOnPosition);
  }

  static const _seekSliderDelay = Duration(milliseconds: 500);

  late final VideoPlayerController controller;
  CancelableOperation<PlayerEvent>? _positionTask;
  CancelableOperation<PlayerEvent>? _volumeTask;
  CancelableOperation<PlayerEvent>? _speedTask;

  late final focusScopeNode = FocusScopeNode();
  late final playerNode = FocusNode();
  late final controlsScopeNode = FocusScopeNode();
  late final controlsMenuNode = FocusNode();
  late final volumeNode = FocusNode();
  late final speedNode = FocusNode();
  late final positionNode = FocusNode();
  late final episodesScopeNode = FocusScopeNode();

  Future<void> _onPlayPause(
    PlayPauseEvent event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      await (state.isPlaying ? controller.pause() : controller.play());
      emit(state.copyWith(isPlaying: !state.isPlaying));
    } catch (e) {
      AppLogger.instance.e(e);
    }
  }

  void _onChangeControlsVisibility(
    ChangeControlsVisibilityEvent event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(controlsVisibility: event.visibility));

    switch (event.visibility) {
      case ControlsVisibility.hidden:
        playerNode.requestFocus();
      case ControlsVisibility.controls:
        controlsScopeNode.requestFocusOnChild(child: controlsMenuNode);
      case ControlsVisibility.episodes:
        episodesScopeNode.requestFocusOnChild();
    }
  }

  void _onSeekPositions(SeekPositionsEvent event, Emitter<PlayerState> emit) {
    if (!state.position.isDragging) {
      emit(
        state.copyWith(
          position: state.position.copyWith(value: event.position),
          duration: event.duration,
        ),
      );
    }
  }

  Future<void> _onUpdatePosition(
    UpdatePositionEvent event,
    Emitter<PlayerState> emit,
  ) async {
    emit(
      state.copyWith(position: state.position.copyWith(value: event.position)),
    );

    await _positionTask?.cancel();

    _positionTask = CancelableOperation.fromFuture(
      Future.delayed(
        _seekSliderDelay,
        () => SetPositionEvent(position: event.position),
      ),
    );

    final positionEvent = await _positionTask?.value;

    if (!isClosed && positionEvent != null) {
      add(positionEvent);
    }
  }

  void _onStartPositionDrag(
    StartPositionDragEvent event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(position: state.position.copyWith(isDragging: true)));
  }

  Future<void> _onSetPosition(
    SetPositionEvent event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      await controller.seekTo(event.position);
    } catch (e) {
      AppLogger.instance.e(e);
    }

    emit(state.copyWith(position: state.position.copyWith(isDragging: false)));
  }

  void _onUpdatePositionFocus(
    UpdatePositionFocusEvent event,
    Emitter<PlayerState> emit,
  ) {
    emit(
      state.copyWith(
        position: state.position.copyWith(isFocused: event.isFocused),
      ),
    );
  }

  void _onSeekVolume(SeekVolumeEvent event, Emitter<PlayerState> emit) {
    if (!state.volume.isDragging) {
      emit(state.copyWith(volume: state.volume.copyWith(value: event.volume)));
    }
  }

  Future<void> _onUpdateVolume(
    UpdateVolumeEvent event,
    Emitter<PlayerState> emit,
  ) async {
    emit(state.copyWith(volume: state.volume.copyWith(value: event.volume)));

    await _volumeTask?.cancel();

    _volumeTask = CancelableOperation.fromFuture(
      Future.delayed(
        _seekSliderDelay,
        () => SetVolumeEvent(volume: event.volume),
      ),
    );

    final volumeEvent = await _volumeTask?.value;

    if (!isClosed && volumeEvent != null) {
      add(volumeEvent);
    }
  }

  void _onStartVolumeDrag(
    StartVolumeDragEvent event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(volume: state.volume.copyWith(isDragging: true)));
  }

  Future<void> _onSetVolume(
    SetVolumeEvent event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      await controller.setVolume(event.volume);
    } catch (e) {
      AppLogger.instance.e(e);
    }
  }

  void _onUpdateVolumeFocus(
    UpdateVolumeFocusEvent event,
    Emitter<PlayerState> emit,
  ) {
    emit(
      state.copyWith(volume: state.volume.copyWith(isFocused: event.isFocused)),
    );
  }

  void _onSeekSpeed(SeekSpeedEvent event, Emitter<PlayerState> emit) {
    if (!state.speed.isDragging) {
      emit(state.copyWith(speed: state.speed.copyWith(value: event.speed)));
    }
  }

  Future<void> _onUpdateSpeed(
    UpdateSpeedEvent event,
    Emitter<PlayerState> emit,
  ) async {
    emit(state.copyWith(speed: state.speed.copyWith(value: event.speed)));

    await _speedTask?.cancel();

    _speedTask = CancelableOperation.fromFuture(
      Future.delayed(_seekSliderDelay, () => SetSpeedEvent(speed: event.speed)),
    );

    final speedEvent = await _speedTask?.value;

    if (!isClosed && speedEvent != null) {
      add(speedEvent);
    }
  }

  void _onStartSpeedDrag(StartSpeedDragEvent event, Emitter<PlayerState> emit) {
    emit(state.copyWith(speed: state.speed.copyWith(isDragging: true)));
  }

  Future<void> _onSetSpeed(
    SetSpeedEvent event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      await controller.setPlaybackSpeed(event.speed);
    } catch (e) {
      AppLogger.instance.e(e);
    }
  }

  void _onUpdateSpeedFocus(
    UpdateSpeedFocusEvent event,
    Emitter<PlayerState> emit,
  ) {
    emit(
      state.copyWith(speed: state.speed.copyWith(isFocused: event.isFocused)),
    );
  }

  void _onRequestFocusOnControlsMenu(
    RequestFocusOnControlsMenuEvent event,
    Emitter<PlayerState> emit,
  ) {
    controlsMenuNode.requestFocus();
  }

  void _onRequestFocusOnVolume(
    RequestFocusOnVolumeEvent event,
    Emitter<PlayerState> emit,
  ) {
    volumeNode.requestFocus();
  }

  void _onRequestFocusOnSpeed(
    RequestFocusOnSpeedEvent event,
    Emitter<PlayerState> emit,
  ) {
    speedNode.requestFocus();
  }

  void _onRequestFocusOnPosition(
    RequestFocusOnPositionEvent event,
    Emitter<PlayerState> emit,
  ) {
    positionNode.requestFocus();
  }

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
    _positionTask?.cancel();
    _positionTask = null;

    _volumeTask?.cancel();
    _volumeTask = null;

    _speedTask?.cancel();
    _speedTask = null;

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
