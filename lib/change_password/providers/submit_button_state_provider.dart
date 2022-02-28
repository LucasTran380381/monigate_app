import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/authentication/service/auth_service.dart';

final changePasswordButtonProvider = StateNotifierProvider.autoDispose<SubmitButtonNotifier, bool>((ref) {
  return SubmitButtonNotifier(ref);
});

class SubmitButtonNotifier extends StateNotifier<bool> {
  final Ref _ref;

  SubmitButtonNotifier(this._ref) : super(true);

  Future<String?> submit(String oldPass, String newPass) async {
    state = false;
    final result = await _ref.read(authServiceProvider).changePassword(oldPass, newPass);
    state = true;
    return result;
  }
}
