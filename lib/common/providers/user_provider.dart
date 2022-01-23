import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/authentication/service/auth_service.dart';
import 'package:monigate_app/models/user.dart';

final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<User>>((ref) {
  return UserNotifier(ref);
});

class UserNotifier extends StateNotifier<AsyncValue<User>> {
  UserNotifier(this._ref) : super(const AsyncValue.loading()) {
    getUser();
  }

  final Ref _ref;

  getUser() async {
    state = const AsyncValue.loading();
    try {
      final user = await _ref.read(authServiceProvider).getCurrentUser();
      state = AsyncValue.data(user);
    } on DioError catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
