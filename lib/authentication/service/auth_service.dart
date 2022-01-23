import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monigate_app/authentication/models/token.dart';
import 'package:monigate_app/authentication/view/login_page.dart';
import 'package:monigate_app/common/providers/user_provider.dart';
import 'package:monigate_app/common/service/dio_client.dart';
import 'package:monigate_app/contact_tracing/logic/tracing_provider.dart';
import 'package:monigate_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authServiceProvider = Provider((ref) {
  final service = AuthService();
  service.ref = ref;
  return service;
});

class AuthService {
  final apiUrl = dotenv.env['apiUrl'];
  final dio = Dio();
  final box = GetStorage();

  late final Ref ref;

  Future<User> login(String username, String password) async {
    final firebaseToken = await FirebaseMessaging.instance.getToken();
    print('firebase token: $firebaseToken');
    final body = jsonEncode({'username': username, 'password': password, 'fireBaseToken': firebaseToken});

    final resp = await dio.post('$apiUrl/Account/login', data: body);
    final pref = await SharedPreferences.getInstance();
    final map = resp.data as Map<String, dynamic>;
    final user = User.fromJson(map['user']);
    final token = Token.fromJson(map['accessToken']);
    final refreshToken = Token.fromJson(map['refreshToken']);
    pref.setString('token', token.token);
    pref.setString('userId', user.id);
    pref.setString('refreshToken', refreshToken.token);
    await pref.setString('user', jsonEncode(user.toJson()));
    ref.read(userProvider.notifier).getUser();
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
    ref.read(tracingProvider.notifier).stopService();
    Get.off(() => const LoginPage());
  }

  Future<User> getCurrentUser() async {
    final pref = await SharedPreferences.getInstance();
    final json = pref.getString('user')!;
    return User.fromJson(jsonDecode(json));
  }

  refreshToken() async {
    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('token');
    final refreshToken = pref.getString('accessToken');
    final body = jsonEncode({
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    });

    final resp = await DioClient.instance.post(
      '/Account/refresh',
      data: body,
    );
    print('refresh token $resp');
  }
}
