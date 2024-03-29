import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:monigate_app/authentication/service/auth_service.dart';
import 'package:monigate_app/common/service/dio_client.dart';
import 'package:monigate_app/common/widgets/root_page.dart';
import 'package:monigate_app/home/logic/checkin_provider.dart';

class LoginController extends GetxController {
  final authService = Get.put(AuthService());
  final formKey = GlobalKey<FormState>();
  final errorText = RxnString(null);
  String? username;
  String? password;

  login(WidgetRef ref) async {
    print(DioClient.instance.options.baseUrl);
    errorText.value = null;
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      if (username != null && password != null) {
        try {
          await ref.read(authServiceProvider).login(username ?? '', password ?? '');
          ref.read(checkinProvider.notifier).fetchCheckin();
          // authService.login(username ?? '', password ?? '');
          // ProviderContainer().refresh(userProvider);
          Get.off(() => const RootPage());
        } on DioError catch (e) {
          print(e);
          if (e.response?.statusCode == 404) {
            errorText.value = 'Sai tên đăng nhập hoặc mật khẩu';
          } else {
            errorText.value = 'Đã có lỗi xảy ra';
          }
        }
      }
    }
  }
}
