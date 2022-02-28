import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/service/dio_client.dart';
import 'package:monigate_app/models/user.dart';

final updateProfileButtonProvider = StateNotifierProvider.autoDispose<SubmitButtonNotifier, bool>((ref) {
  return SubmitButtonNotifier();
});

class SubmitButtonNotifier extends StateNotifier<bool> {
  SubmitButtonNotifier() : super(true);

  updateProfile(User user) async {
    try {
      state = false;
      final resp = await DioClient.instance.put('/User/me', data: {
        'firstName': user.firstName,
        'lastName': user.lastName,
        'phone': user.phone,
        'email': user.email,
      });
      state = true;
      print(resp.data);
      return 'success';
    } on DioError catch (e) {
      state = true;
      return 'errror $e';
    }
  }
}
