import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';

@singleton
final class ClearRecentCharactersUseCase {
  const ClearRecentCharactersUseCase(this._encyclopediaRepository);
  final EncyclopediaRepository _encyclopediaRepository;

  Future<void> call() async {
    await _encyclopediaRepository.clearRecentCharacters();
  }
}
