import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
final class AppDio {
  AppDio();

  // Localhost for android emulator is 10.0.2.2
  late final value = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8080'))
    ..interceptors.add(PrettyDioLogger());
}
