import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
final class AppDio {
  AppDio();

  // Localhost for android emulator is 10.0.2.2
  late final value = Dio(
    BaseOptions(
      baseUrl: 'https://t9sk0mds-8080.euw.devtunnels.ms',
      connectTimeout: const Duration(seconds: 7),
      receiveTimeout: const Duration(seconds: 7),
      sendTimeout: const Duration(seconds: 7),
      followRedirects: true,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36',
      },
    ),
  )..interceptors.add(PrettyDioLogger());
}
