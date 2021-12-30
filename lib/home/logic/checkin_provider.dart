import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/service/checkin_service.dart';
import 'package:monigate_app/home/states/checkin_state.dart';

final checkinProvider = StateNotifierProvider<CheckinNotifier, CheckinState>((ref) {
  return CheckinNotifier(ref.read(checkinServiceProvider));
});

class CheckinNotifier extends StateNotifier<CheckinState> {
  CheckinNotifier(this._checkinService) : super(const CheckinState.loading());
  final CheckinService _checkinService;

  fetchCheckin() async {
    state = const CheckinState.loading();
    try {
      final result = await _checkinService.getMyCheckin();
      state = result != null ? CheckinState.hasCheckin(result) : const CheckinState.noCheckin();
    } catch (e) {
      state = CheckinState.error(e.toString());
    }
  }
}
