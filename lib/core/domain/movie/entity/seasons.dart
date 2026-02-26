import 'package:flutter/foundation.dart';

@immutable
enum Seasons {
  first(path: 'season1'),
  second(path: 'season2'),
  third(path: 'season3');

  const Seasons({required this.path});
  final String path;
}
