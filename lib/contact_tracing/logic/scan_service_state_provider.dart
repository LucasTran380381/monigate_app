import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/contact_tracing/services/bluetooth_scanner_service.dart';
import 'package:monigate_app/contact_tracing/states/scan_service_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final scanServiceStateProvider = StateNotifierProvider<ServiceStateNotifier, ScanServiceState>((ref) {
  return ServiceStateNotifier(ref);
});

class ServiceStateNotifier extends StateNotifier<ScanServiceState> {
  ServiceStateNotifier(this._ref) : super(const ScanServiceState.loading()) {
    _initService();
  }

  final Ref _ref;

  startService() {
    print('start service');
    state = const ScanServiceState.running();
    _saveSetting(true);
    _ref.read(bluetoothScannerServiceProvider).scanDevice();
  }

  stopService() {
    print('stop service');
    state = const ScanServiceState.stopped();
    _saveSetting(false);
    _ref.read(bluetoothScannerServiceProvider).stopService();
  }

  _initService() async {
    final pref = await SharedPreferences.getInstance();
    final isOnContactTracing = pref.getBool('isOnContactTracing') ?? false;
    if (isOnContactTracing) {
      startService();
    } else {
      state = const ScanServiceState.stopped();
    }
  }

  _saveSetting(bool isOnService) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isOnContactTracing', isOnService);
  }
}
