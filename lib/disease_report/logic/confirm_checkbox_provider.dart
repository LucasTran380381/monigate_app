import 'package:flutter_riverpod/flutter_riverpod.dart';

final confirmCheckboxProvider = StateNotifierProvider.autoDispose<ConfirmCheckboxNotifier, bool>((ref) {
  return ConfirmCheckboxNotifier();
});

class ConfirmCheckboxNotifier extends StateNotifier<bool> {
  ConfirmCheckboxNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}
