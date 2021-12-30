import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = FutureProvider<User?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final userString = prefs.getString('user');

  if (userString == null) {
    return null;
  }

  return User.fromJson(jsonDecode(userString));
});
