import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monigate_app/authentication/view/login_page.dart';
import 'package:monigate_app/common/widgets/root_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () async {
      final pref = await SharedPreferences.getInstance();
      final isLoggedIn = pref.getString('user') != null;
      if (!isLoggedIn) {
        Get.off(() => const LoginPage());
      } else {
        Get.off(() => const RootPage());
      }
    });
  }
}
