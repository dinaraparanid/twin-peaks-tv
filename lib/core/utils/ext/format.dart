import 'package:duration/duration.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/minutes.dart';

extension DurationFormat on Minutes {
  String toDurationFormat() => Duration(minutes: value).pretty(
    abbreviated: true,
    delimiter: ' ',
    upperTersity: DurationTersity.hour,
    tersity: DurationTersity.minute,
  );
}
