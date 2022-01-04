import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluetooth_state.freezed.dart';

@freezed
class BluetoothState with _$BluetoothState {
  const factory BluetoothState.error(String error) = Error;
  const factory BluetoothState.data(List<BluetoothDevice> devices, bool isScanning) = Data;
  const factory BluetoothState.initial() = Initial;
}
