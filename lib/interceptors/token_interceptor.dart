import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = GetStorage().read('token');
    if (token != null) {
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {}
    super.onError(err, handler);
  }
}
