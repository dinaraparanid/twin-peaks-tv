import 'package:twin_peaks_tv/core/data/movie/entity/entity.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/entity.dart';

final class ActorMapper {
  const ActorMapper._();

  static Actor fromResponse(ActorResponse response) => Actor(
    name: response.name,
    character: response.character,
    thumbnailUrl: response.thumbnailUrl,
  );
}
