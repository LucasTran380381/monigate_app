import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:monigate_app/services/auth_service.dart';
import 'package:monigate_app/views/root_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final loginService = Get.put(AuthService());
  final formKey = GlobalKey<FormState>();
  final errorText = RxnString(null);
  String? username;
  String? password;

  login() async {
    errorText.value = null;
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      if (username != null && password != null) {
        try {
          final user = await loginService.login(username!, password!);
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('user', jsonEncode(user.toJson()));
          Get.off(() => const RootPage());
        } on DioError catch (e) {
          if (e.response?.statusCode == 404) {
            errorText.value = 'Sai tên đăng nhập hoặc mật khẩu';
          } else {
            errorText.value = e.toString();
          }
        }
      }
    }
  }
}
