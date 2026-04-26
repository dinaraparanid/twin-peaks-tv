import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/use_case/use_case.dart';
import 'package:twin_peaks_tv/core/domain/settings/use_case/use_case.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/bloc/encyclopedia_bloc.dart';

@singleton
final class EncyclopediaBlocFactory {
  const EncyclopediaBlocFactory(
    this._browseCharactersUseCase,
    this._clearRecentCharactersUseCase,
    this._recentCharactersUseCase,
    this._fetchAppLangUseCase,
  );

  final BrowseCharactersUseCase _browseCharactersUseCase;
  final ClearRecentCharactersUseCase _clearRecentCharactersUseCase;
  final RecentCharactersUseCase _recentCharactersUseCase;
  final FetchAppLangUseCase _fetchAppLangUseCase;

  EncyclopediaBloc call() => EncyclopediaBloc(
    browseCharactersUseCase: _browseCharactersUseCase,
    clearRecentCharactersUseCase: _clearRecentCharactersUseCase,
    recentCharactersUseCase: _recentCharactersUseCase,
    fetchAppLangUseCase: _fetchAppLangUseCase,
  );
}
