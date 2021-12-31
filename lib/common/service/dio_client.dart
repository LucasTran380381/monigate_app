import 'package:dio/dio.dart';
import 'package:monigate_app/common/interceptors/logging_interceptor.dart';
import 'package:monigate_app/common/interceptors/token_interceptor.dart';

class DioClient {
  static final instance = Dio(BaseOptions(baseUrl: 'https://monigate-capstone-ubuntu.azurewebsites.net/api'))
    ..interceptors.addAll([TokenInterceptor(), Logging()]);
}
