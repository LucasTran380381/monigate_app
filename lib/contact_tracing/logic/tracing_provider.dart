import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/contact_tracing/services/ble_service.dart';

enum TracingState {
  running,
  stopped,
}

final tracingProvider = StateNotifierProvider<TracingNotifier, TracingState>((ref) {
  return TracingNotifier(ref);
});

class TracingNotifier extends StateNotifier<TracingState> {
  TracingNotifier(this._ref) : super(TracingState.stopped);

  final Ref _ref;

  _startService() {
    _ref.read(bleServiceProvider).startBle();
    state = TracingState.running;
  }

  _stopService() {
    _ref.read(bleServiceProvider).stopBle();
    state = TracingState.stopped;
  }

  void toggleService() {
    if (state == TracingState.running) {
      _stopService();
      return;
    }

    _startService();
  }
}
