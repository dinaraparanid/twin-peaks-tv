import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/feature/home/bloc/home_bloc.dart';

@singleton
final class HomeBlocFactory {
  const HomeBlocFactory();

  HomeBloc call() => HomeBloc();
}
