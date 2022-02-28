import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/service/dio_client.dart';
import 'package:monigate_app/models/user.dart';

final profileProvider = FutureProvider.autoDispose<User>((ref) async {
  final resp = await DioClient.instance.get('/User/me');
  print(resp.data);
  final user = User.fromJson(resp.data);
  return user;
});
