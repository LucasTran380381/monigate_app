import 'package:dio/dio.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final shouldShowLogging = options.headers.containsKey('showLog');
    if (shouldShowLogging) {}
    super.onRequest(options, handler);
  }
}
