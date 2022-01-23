import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final String? token = GetStorage().read('token');
    final uri = options.uri.toString();
    final shouldIncludeToken = !uri.contains('login') || !uri.contains('refresh');
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
    if (err.response?.statusCode == 401) {
      final errorMessage = err.response?.data as String? ?? '';
      print('errorMessage: $errorMessage');
      if (errorMessage.contains('Token')) {
        // final authService = ProviderContainer().read(authServiceProvider);
        // try {
        //   authService.refreshToken();
        // } on DioError catch (e) {
        //   print('token interceptor error: $e');
        // }
      }
    }
    super.onError(err, handler);
  }
}
