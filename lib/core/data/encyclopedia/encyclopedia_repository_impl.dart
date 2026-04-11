import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:twin_peaks_tv/core/data/encyclopedia/entity/entity.dart';
import 'package:twin_peaks_tv/core/data/encyclopedia/mapper/mapper.dart';
import 'package:twin_peaks_tv/core/dio/dio.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/encyclopedia.dart';

@Singleton(as: EncyclopediaRepository)
final class EncyclopediaRepositoryImpl extends EncyclopediaRepository {
  const EncyclopediaRepositoryImpl({required this.dio});

  final AppDio dio;

  @override
  Future<Either<Exception, List<Character>>> browseCharacters({
    String? query,
  }) async {
    try {
      final response = await dio.value.get<List<Map<String, dynamic>>>(
        '/encyclopedia/characters',
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
      return left(e);
    }
  }
}
