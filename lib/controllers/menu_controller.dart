import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenuController extends GetxController {
  final box = GetStorage();
  final isUseVietnamese = true.obs;

  @override
  void onInit() {
    final String language = box.read('language');
    isUseVietnamese(language == 'vn');
    super.onInit();
  }

  void changeLanguage(bool useVietnamese) {
    final locale =
        useVietnamese ? const Locale('vn', 'VN') : const Locale('en', 'US');
    isUseVietnamese(useVietnamese);
    Get.updateLocale(locale);
    box.write('language', useVietnamese ? 'vn' : 'en');
  }
}
