import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bleServiceProvider = Provider((ref) {
  return BleService();
});

class BleService {
  startBle() async {
    final result = await const MethodChannel('dev.lucas.tracing').invokeMethod('startTracingService');
  }

  stopBle() async {
    final result = await const MethodChannel('dev.lucas.tracing').invokeMethod('stopTracingService');
  }
}
