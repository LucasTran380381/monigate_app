import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationIndexProvider = StateNotifierProvider.autoDispose<BottomIndexNotifier, int>((ref) {
  return BottomIndexNotifier();
});

class BottomIndexNotifier extends StateNotifier<int> {
  BottomIndexNotifier() : super(0);

  selectIndex(int index) {
    state = index;
  }
}
