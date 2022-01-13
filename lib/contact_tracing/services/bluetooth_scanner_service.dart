import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/contact_tracing/model/contact_tracing.dart';
import 'package:shared_preferences/shared_preferences.dart';

final bluetoothScannerServiceProvider = Provider((ref) {
  final service = BluetoothScannerService(ref);
  ref.onDispose(() {
    print('dispose bluetooth scan service');
    service.stopService();
  });
  return service;
});

class BluetoothScannerService {
  BluetoothScannerService(this._ref);

  late Timer _timer;
  final Ref _ref;

  static _isolateEntry(dynamic d) async {
    final ReceivePort receivePort = ReceivePort();
  }

  scanDevice() async {
    var tracing = [];
    // final ReceivePort receivePort = ReceivePort();
    // await Isolate.spawn(_isolateEntry, receivePort.sendPort);

    // receivePort.listen((dynamic data) {
    //   print('data: $data');
    // });
    // print('scan bluetooth');
    // final bluetooth = FlutterScanBluetooth();
    // bluetooth.scanStopped.listen((state) {
    //   print('stopped: $state');
    // });
    // bluetooth.startScan(pairedDevices: false);
    // bluetooth.devices.listen((device) {
    //   print('name: ${device.name}, mac: ${device.address}');
    // });
    _timer = Timer.periodic(const Duration(minutes: 2), (timer) async {
      List<ContactTracing> tracing = [];
      final isDiscovering = await FlutterBluetoothSerial.instance.isDiscovering ?? false;
      if (!isDiscovering) {
        FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
          final mac = result.device.address;
          final isDuplicate = tracing.firstWhereOrNull((element) => element.macAddress == mac) != null;
          if (!isDuplicate) {
            tracing.add(ContactTracing(macAddress: result.device.address, isSynced: false, time: DateTime.now(), rssi: result.rssi));
          }
        }, onDone: () {
          if (tracing.isNotEmpty) {
            _saveToLocal(tracing);
            // _ref.read(contactTracingStateProvider.notifier).getContactTracing();
          }
        });
      }
    });

    // final isDiscovering = await FlutterBluetoothSerial.instance.isDiscovering;
    // if (isDiscovering ?? false) return;
    // FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
    //   final content = 'device name: ${result.device.name}, address: ${result.device.address}, time: ${DateTime.now()}';
    //   tracing = [content, ...tracing];
    // }, onDone: () => _saveToLocal(tracing));
  }

  Future<void> _saveToLocal(List<ContactTracing> results) async {
    final pref = await SharedPreferences.getInstance();
    final tracingJson = pref.getString('tracing');

    if (tracingJson != null) {
      final List<dynamic> list = jsonDecode(tracingJson);
      final history = list.map((element) => ContactTracing.fromJson(element)).toList();
      results = [...history, ...results];
    }

    pref.setString('tracing', jsonEncode(results));
  }

  Future<List<String>> getScannedDevice() async {
    final pref = await SharedPreferences.getInstance();
    final tracingJson = pref.getString('tracing');

    return [];
    // return pref.getStringList('tracing') ?? [];
  }

  clearHistory() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('tracing');
  }

  void stopService() {
    FlutterBluetoothSerial.instance.cancelDiscovery();
    _timer.cancel();
  }
}
