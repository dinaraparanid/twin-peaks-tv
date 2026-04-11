import 'package:twin_peaks_tv/core/data/encyclopedia/entity/entity.dart';
import 'package:twin_peaks_tv/core/domain/encyclopedia/entity/entity.dart';

final class CharacterMapper {
  const CharacterMapper._();

  static Character fromResponse(CharacterResponse response) => Character(
    name: response.name,
    info: response.info,
    thumbnailUrl: response.thumbnailUrl,
  );
}
