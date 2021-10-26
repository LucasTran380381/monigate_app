import 'dart:async';

import 'package:get/get.dart';
import 'package:monigate_app/views/login_page.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const LoginPage());
    });
  }
}
