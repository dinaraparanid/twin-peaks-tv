import 'package:logger/logger.dart';

final class AppLogger {
  const AppLogger._();

  static final instance = Logger(printer: PrettyPrinter());
}
