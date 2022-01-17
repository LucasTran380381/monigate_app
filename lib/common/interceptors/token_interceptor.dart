import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final String? token = GetStorage().read('token');
    final shouldIncludeToken = !options.uri.toString().contains('login');
    SharedPreferences.getInstance().then((pref) {
      final token = pref.getString('token');
      if (token != null && shouldIncludeToken) {
        options.headers.addAll({'Authorization': 'Bearer $token'});
      }
    });

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {}
    super.onError(err, handler);
  }
}
