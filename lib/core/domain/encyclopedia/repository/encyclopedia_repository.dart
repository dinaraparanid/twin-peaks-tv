import 'package:fpdart/fpdart.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';

abstract base class EncyclopediaRepository {
  const EncyclopediaRepository();

  Future<Either<Exception, List<Character>>> browseCharacters({String? query});

  Future<List<Character>> get recentCharacters;
  Stream<List<Character>> get recentCharactersChanges;

  Future<void> markCharacterAsRecent(Character character);
}
