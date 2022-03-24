import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monigate_app/authentication/view/login_page.dart';
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
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    if (statusCode == 401) {
      final pref = await SharedPreferences.getInstance();
      final box = GetStorage();
      box.remove('currentUser');
      box.remove('token');
      pref.remove('user');
      pref.remove('token');
      // ref.read(tracingProvider.notifier).stopService();
      Get.off(() => const LoginPage());
    }
    super.onError(err, handler);
  }
}
