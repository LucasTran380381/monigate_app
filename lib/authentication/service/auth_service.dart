import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monigate_app/authentication/view/login_page.dart';
import 'package:monigate_app/models/user.dart';

class AuthService {
  final apiUrl = dotenv.env['apiUrl'];
  final dio = Dio();
  final box = GetStorage();

  Future<User> login(String username, String password) async {
    final fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    final body = jsonEncode({
      'username': username,
      'password': password,
      'fireBaseToken': fcmToken,
    });

    final resp = await dio.post('$apiUrl/Account/login', data: body);
    final map = resp.data as Map<String, dynamic>;
    final user = User.fromJson(map['user']);
    await box.write('currentUser', map['user']);
    await box.write('token', map['token']);
    return user;
  }

  void logout() {
    box.remove('currentUser');
    box.remove('token');
    Get.off(() => const LoginPage());
  }

  User getCurrentUser() {
    return User.fromJson(box.read('currentUser'));
  }
}
