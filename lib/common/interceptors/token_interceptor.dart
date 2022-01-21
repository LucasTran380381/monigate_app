import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/authentication/service/auth_service.dart';
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
    if (err.response?.statusCode == 401) {
      final errorMessage = err.response?.data as String? ?? '';
      if (errorMessage.contains('Token')) {
        final authService = ProviderContainer().read(authServiceProvider);
        try {
          authService.refreshToken();
        } on DioError catch (e) {}
      }
    }
    super.onError(err, handler);
  }
}
