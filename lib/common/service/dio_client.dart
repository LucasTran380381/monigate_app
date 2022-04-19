import 'package:dio/dio.dart';
import 'package:monigate_app/common/interceptors/logging_interceptor.dart';
import 'package:monigate_app/common/interceptors/token_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  // 'https://monigate-capstone-ubuntu.azurewebsites.net/api'
  // https://swp-monigate-ubuntu.azurewebsites.net/api

  static Dio? _cachedInstance;

  static Dio get instance {
    _cachedInstance ??= Dio(BaseOptions(baseUrl: 'https://swp-monigate-ubuntu.azurewebsites.net/api'))
        ..interceptors.addAll([TokenInterceptor(), Logging()]);

    return _cachedInstance!;
  }
}
