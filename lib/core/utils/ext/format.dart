import 'package:duration/duration.dart';
import 'package:twin_peaks_tv/core/domain/movie/entity/minutes.dart';

extension DurationFormatMinutes on Minutes {
  String toDurationFormat() => Duration(minutes: value).toDurationFormat();
}

extension DurationFormat on Duration {
  static const secondsInHour = 3600;
  static const secondsInMinute = 60;

  String toDurationFormat() => pretty(
    abbreviated: true,
    delimiter: ' ',
    upperTersity: DurationTersity.hour,
    tersity: DurationTersity.minute,
  );

  String toTimestampFormat() {
    var s = inSeconds;

    final h = s ~/ secondsInHour;
    s -= h * secondsInHour;

    final m = s ~/ secondsInMinute;
    s -= m * secondsInMinute;

    final sFormat = s.toString().padLeft(2, '0');
    final mFormat = m.toString().padLeft(2, '0');
    final hFormat = h > 0 ? h.toString().padLeft(2, '0') : '';
    return [hFormat, mFormat, sFormat].where((e) => e.isNotEmpty).join(':');
  }
}
