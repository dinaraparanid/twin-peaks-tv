import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
final class AppDio {
  AppDio();

  late final value = Dio(BaseOptions(baseUrl: 'http://0.0.0.0:8080'))
    ..interceptors.add(PrettyDioLogger());
}
