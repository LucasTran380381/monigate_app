import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monigate_app/authentication/models/token.dart';
import 'package:monigate_app/authentication/view/login_page.dart';
import 'package:monigate_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final apiUrl = dotenv.env['apiUrl'];
  final dio = Dio();
  final box = GetStorage();

  Future<User> login(String username, String password) async {
    final firebaseToken = await FirebaseMessaging.instance.getToken();
    final body = jsonEncode({'username': username, 'password': password, 'fireBaseToken': firebaseToken});

    final resp = await dio.post('$apiUrl/Account/login', data: body);
    final pref = await SharedPreferences.getInstance();
    final map = resp.data as Map<String, dynamic>;
    final user = User.fromJson(map['user']);
    final token = Token.fromJson(map['accessToken']);
    pref.setString('token', token.token);
    await box.write('currentUser', map['user']);
    // await box.write('token', map['token']);
    return user;
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    box.remove('currentUser');
    box.remove('token');
    pref.remove('user');
    pref.remove('token');
    Get.off(() => const LoginPage());
  }

  User getCurrentUser() {
    return User.fromJson(box.read('currentUser'));
  }
}
