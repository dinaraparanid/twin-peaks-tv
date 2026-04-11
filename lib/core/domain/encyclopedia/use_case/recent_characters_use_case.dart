import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';

@singleton
final class RecentCharactersUseCase {
  const RecentCharactersUseCase(this._encyclopediaRepository);

  final EncyclopediaRepository _encyclopediaRepository;

  Stream<List<Character>> get changes {
    return _encyclopediaRepository.recentCharactersChanges;
  }

  Future<void> markAsRecent(Character character) async {
    await _encyclopediaRepository.markCharacterAsRecent(character);
  }
}
