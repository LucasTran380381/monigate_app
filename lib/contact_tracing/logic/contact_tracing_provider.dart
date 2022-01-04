import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/contact_tracing/services/bluetooth_scanner_service.dart';

final contactTracingProvider = FutureProvider.autoDispose((ref) async {
  print('get scanned device');
  return ref.watch(bluetoothScannerServiceProvider).getScannedDevice();
});
