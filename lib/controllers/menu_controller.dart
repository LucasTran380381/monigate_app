import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monigate_app/authentication/service/auth_service.dart';
import 'package:monigate_app/models/user.dart';

class MenuController extends GetxController {
  final box = GetStorage();
  final isUseVietnamese = true.obs;
  final authService = AuthService();
  late final Rx<User> user;

  @override
  void onInit() {
    // user = authService.getCurrentUser().obs;
    final String language = box.read('language');
    isUseVietnamese(language == 'vn');
    super.onInit();
  }

  void changeLanguage(bool useVietnamese) {
    final locale = useVietnamese ? const Locale('vn', 'VN') : const Locale('en', 'US');
    isUseVietnamese(useVietnamese);
    Get.updateLocale(locale);
    box.write('language', useVietnamese ? 'vn' : 'en');
  }

  void logout() {
    authService.logout();
  }
}
