import 'package:async/async.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/utils/ext/focus_node_ext.dart';
import 'package:twin_peaks_tv/core/utils/utils.dart';
import 'package:twin_peaks_tv/feature/player/bloc/controls_visibility.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_entry.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_event.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_state.dart';
import 'package:video_player/video_player.dart';

final class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({required PlayerEntry entry}) : super(PlayerState(entry: entry)) {
    on<UpdatePlayerStateEvent>(_onUpdatePlayerState);
    on<PlayPauseEvent>(_onPlayPause, transformer: sequential());
    on<ChangeControlsVisibilityEvent>(_onChangeControlsVisibility);
    on<SelectEpisodeEvent>(_onSelectEpisode);

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

    _episodesNodes = switch (entry) {
      PlayerEntrySeason(episodes: final episodes) =>
        episodes.map((_) => FocusNode()).toList(growable: false),

      PlayerEntryMovie() => [],
    };

    _initVideoController(url: entry.videoUrl);
    positionNode.addListener(_positionFocusListener);
    volumeNode.addListener(_volumeFocusListener);
    speedNode.addListener(_speedFocusListener);
  }

  static const _seekSliderDelay = Duration(milliseconds: 500);

  late VideoPlayerController _controller;
  VideoPlayerController get controller => _controller;

  List<FocusNode> _episodesNodes = [];
  List<FocusNode> get episodesNodes => _episodesNodes;

  CancelableOperation<PlayerEvent>? _positionTask;
  CancelableOperation<PlayerEvent>? _volumeTask;
  CancelableOperation<PlayerEvent>? _speedTask;

  final focusScopeNode = FocusScopeNode();
  final playerNode = FocusNode();
  final controlsScopeNode = FocusScopeNode();
  final controlsMenuNode = FocusNode();
  final volumeNode = FocusNode();
  final speedNode = FocusNode();
  final positionNode = FocusNode();
  final episodesScopeNode = FocusScopeNode();

  Future<void> _initVideoController({required String url}) async {
    add(const UpdatePlayerStateEvent(state: UiState.loading()));

    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..addListener(_playerListener);

    try {
      await controller.initialize();

      add(const PlayPauseEvent());
      add(const UpdatePlayerStateEvent(state: UiState.success()));
    } catch (e) {
      AppLogger.instance.e(e);
      add(const UpdatePlayerStateEvent(state: UiState.error()));
    }
  }

  void _onUpdatePlayerState(
    UpdatePlayerStateEvent event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(playerState: event.state));
  }

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

    switch ((event.visibility, state.entry)) {
      case (ControlsVisibility.hidden, _):
        playerNode.requestFocus();
      case (ControlsVisibility.controls, _):
        controlsScopeNode.requestFocusOnChild(child: controlsMenuNode);
      case (
        ControlsVisibility.episodes,
        PlayerEntrySeason(episodeIndex: final index),
      ):
        episodesNodes[index].requestFocus();
      case _:
        doNothing;
    }
  }

  Future<void> _onSelectEpisode(
    SelectEpisodeEvent event,
    Emitter<PlayerState> emit,
  ) async {
    add(const UpdatePlayerStateEvent(state: UiState.loading()));

    final currentEntry = state.entry as PlayerEntrySeason;
    final nextEntry = currentEntry.copyWith(episodeIndex: event.index);
    emit(state.copyWith(entry: nextEntry));

    try {
      _controller.removeListener(_playerListener);
      await _controller.dispose();

      _controller = VideoPlayerController.networkUrl(
        Uri.parse(nextEntry.videoUrl),
      )..addListener(_playerListener);

      await _controller.initialize();
      await _controller.play();

      emit(state.copyWith(isPlaying: true));
      add(const UpdatePlayerStateEvent(state: UiState.success()));
    } catch (e) {
      AppLogger.instance.e(e);
      add(const UpdatePlayerStateEvent(state: UiState.error()));
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
    add(UpdatePositionFocusEvent(isFocused: positionNode.hasFocus));
  }

  void _volumeFocusListener() {
    add(UpdateVolumeFocusEvent(isFocused: volumeNode.hasFocus));
  }

  void _speedFocusListener() {
    add(UpdateSpeedFocusEvent(isFocused: speedNode.hasFocus));
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
