import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twin_peaks_tv/feature/home/bloc/home_event.dart';
import 'package:twin_peaks_tv/feature/home/bloc/home_state.dart';

final class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<UpdateTabBarOpacity>((event, emit) {
      emit(state.copyWith(tabBarOpacity: event.opacity));
    });
  }
}

extension HomeBlocProvider on BuildContext {
  HomeBloc get homeBloc => BlocProvider.of(this);
}
