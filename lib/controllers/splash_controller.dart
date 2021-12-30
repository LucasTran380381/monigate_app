import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monigate_app/views/login_page.dart';
import 'package:monigate_app/views/root_page.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      final isLoggedIn = box.read('token') != null;
      if (!isLoggedIn) {
        Get.off(() => const LoginPage());
      } else {
        Get.off(() => const RootPage());
      }
    });
  }
}
