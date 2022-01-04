import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/contact_tracing/states/bluetooth_state.dart' as my_state;

final bluetoothStateProvider = StateNotifierProvider<BluetoothStateNotifier, my_state.BluetoothState>((ref) {
  FlutterBluetoothSerial.instance.isDiscoverable.then((value) => print('is Discover $value}'));
  FlutterBluetoothSerial.instance.state.then((result) => print('state: ${result.toString()}'));
  return BluetoothStateNotifier();
});

class BluetoothStateNotifier extends StateNotifier<my_state.BluetoothState> {
  BluetoothStateNotifier() : super(const my_state.BluetoothState.initial());

  scanDevice() {
    var devices = <BluetoothDevice>[];
    FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
      devices = [result.device, ...devices];
      state = my_state.BluetoothState.data(devices, true);
    },
        onDone: () => state = my_state.BluetoothState.data(devices, false),
        onError: (error) => state = my_state.BluetoothState.error(error.toString()));
  }

  stopScan() async {
    await FlutterBluetoothSerial.instance.cancelDiscovery();
  }
}
