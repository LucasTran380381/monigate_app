import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tracingServiceProvider = Provider((ref) {
  return TracingService();
});

class TracingService {
  startBle() async {
    final result = await const MethodChannel('dev.lucas.tracing').invokeMethod('startTracingService');
  }

  stopBle() async {
    final result = await const MethodChannel('dev.lucas.tracing').invokeMethod('stopTracingService');
  }

  Future<String?> getHistory() async {
    final pref = await SharedPreferences.getInstance();
    // await pref.reload();
    return pref.getString('scan');
  }
}
