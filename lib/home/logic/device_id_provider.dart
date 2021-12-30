import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceIdProvider = FutureProvider<String>((ref) async {
  final token = await FirebaseMessaging.instance.getToken();
  return token ?? '';
});
