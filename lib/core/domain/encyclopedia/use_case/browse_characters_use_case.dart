import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';

const _browseDebounceDuration = Duration(seconds: 2);

@singleton
final class BrowseCharactersUseCase {
  BrowseCharactersUseCase(this._encyclopediaRepository);
  final EncyclopediaRepository _encyclopediaRepository;

  late final _queryCollector = StreamController<String?>.broadcast();

  Stream<Either<Exception, List<Character>>> get changes => _queryCollector
      .stream
      .debounceTime(_browseDebounceDuration)
      .asyncMap((query) {
        return _encyclopediaRepository.browseCharacters(query: query);
      });

  void submitQuery(String? query) => _queryCollector.add(query);
}
