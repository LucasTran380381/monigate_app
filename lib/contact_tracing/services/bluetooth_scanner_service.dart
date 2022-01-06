import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final bluetoothScannerServiceProvider = Provider((ref) {
  return BluetoothScannerService();
});

class BluetoothScannerService {
  BluetoothScannerService();

  scanDevice() async {
    var tracing = [];
    print('scan bluetooth');
    final bluetooth = FlutterScanBluetooth();
    bluetooth.scanStopped.listen((state) {
      print('stopped: $state');
    });
    bluetooth.startScan(pairedDevices: false);
    bluetooth.devices.listen((device) {
      print('name: ${device.name}, mac: ${device.address}');
    });

    // await FlutterBluetoothSerial.instance.cancelDiscovery();
    // final isDiscovering = await FlutterBluetoothSerial.instance.isDiscovering;
    // if (isDiscovering ?? false) return;
    // FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
    //   final content = 'device name: ${result.device.name}, address: ${result.device.address}, time: ${DateTime.now()}';
    //   tracing = [content, ...tracing];
    // }, onDone: () => _saveToLocal(tracing));
  }

  Future<void> _saveToLocal(results) async {
    final pref = await SharedPreferences.getInstance();
    final tracing = pref.getStringList('tracing') ?? [];
    pref.setStringList('tracing', [...tracing, ...results]);
  }

  Future<List<String>> getScannedDevice() async {
    final pref = await SharedPreferences.getInstance();
    print(pref.getStringList('tracing').toString());
    return pref.getStringList('tracing') ?? [];
  }

  clearHistory() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('tracing');
  }
}
