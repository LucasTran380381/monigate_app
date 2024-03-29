import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/contact_tracing/services/tracing_service.dart';

enum TracingState {
  running,
  stopped,
}

final tracingProvider = StateNotifierProvider<TracingNotifier, TracingState>((ref) {
  return TracingNotifier(ref);
});

class TracingNotifier extends StateNotifier<TracingState> {
  TracingNotifier(this._ref) : super(TracingState.stopped) {
    _getTracingStatus();
  }

  final Ref _ref;

  _getTracingStatus() async {
    final result = await const MethodChannel('dev.lucas.tracing').invokeMethod('getTracingServiceStatus');
    print('tracing result: $result');
    state = result == 'On' ? TracingState.running : TracingState.stopped;
  }

  _startService() {
    _ref.read(tracingServiceProvider).startBle();
    state = TracingState.running;
  }

  stopService() {
    _ref.read(tracingServiceProvider).stopBle();
    state = TracingState.stopped;
  }

  Future<void> toggleService() async {
    if (state == TracingState.running) {
      await BackgroundFetch.stop();
      stopService();
      return;
    }

    final result = await BackgroundFetch.start();
    print('background : $result');
    _startService();
  }
}
