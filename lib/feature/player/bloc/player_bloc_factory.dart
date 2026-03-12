import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_bloc.dart';
import 'package:twin_peaks_tv/feature/player/bloc/player_entry.dart';

@singleton
final class PlayerBlocFactory {
  const PlayerBlocFactory();

  PlayerBloc call({required PlayerEntry entry}) => PlayerBloc(entry: entry);
}
