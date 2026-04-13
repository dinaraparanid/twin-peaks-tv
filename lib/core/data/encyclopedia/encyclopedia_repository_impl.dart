import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:twin_peaks_tv/core/data/encyclopedia/entity/entity.dart';
import 'package:twin_peaks_tv/core/data/encyclopedia/mapper/mapper.dart';
import 'package:twin_peaks_tv/core/dio/dio.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';
import 'package:twin_peaks_tv/core/log/app_logger.dart';

@Singleton(as: EncyclopediaRepository)
final class EncyclopediaRepositoryImpl extends EncyclopediaRepository {
  EncyclopediaRepositoryImpl({required this.dio});

  static const _keyRecentCharacters = 'recent_characters';

  final AppDio dio;

  final _prefs = RxSharedPreferences(
    SharedPreferences.getInstance(),
    kReleaseMode ? null : const RxSharedPreferencesDefaultLogger(),
  );

  @override
  Future<Either<Exception, List<Character>>> browseCharacters({
    String? query,
  }) async {
    try {
      final response = await dio.value.get<List>(
        '/encyclopedia/characters',
        queryParameters: {'query': query},
      );

      final data = response.data!
          .map((dto) {
            return CharacterMapper.fromResponse(
              CharacterResponse.fromJson(dto),
            );
          })
          .toList(growable: false);

      return right(data);
    } on Exception catch (e) {
      AppLogger.instance.e(e);
      return left(e);
    }
  }

  @override
  Future<List<Character>> get recentCharacters async {
    final jsons = await _prefs.getStringList(_keyRecentCharacters);
    return CharacterMapper.fromJsonList(jsons ?? []);
  }

  @override
  Stream<List<Character>> get recentCharactersChanges => _prefs
      .getStringListStream(_keyRecentCharacters)
      .map((jsons) => jsons ?? [])
      .map(CharacterMapper.fromJsonList);

  @override
  Future<void> markCharacterAsRecent(Character character) async {
    final characters = [character, ...await recentCharacters].take(5).toList();
    final jsons = CharacterMapper.toJsonList(characters);
    await _prefs.setStringList(_keyRecentCharacters, jsons);
  }

  @override
  Future<void> clearRecentCharacters() async {
    await _prefs.remove(_keyRecentCharacters);
  }
}
