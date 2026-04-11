import 'package:fpdart/fpdart.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';

abstract base class EncyclopediaRepository {
  const EncyclopediaRepository();

  Future<Either<Exception, List<Character>>> browseCharacters({String? query});
}
