import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monigate_app/views/root_page.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final errorText = RxnString(null);
  String? username;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onLogin() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      if (username == 'trannhan380381@gmail.com') {
        errorText.value = 'Not have username';
      } else {
        Get.off(const RootPage());
      }
    }
  }
}
