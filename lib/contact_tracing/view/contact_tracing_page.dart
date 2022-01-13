import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:monigate_app/contact_tracing/logic/bluetooth_state_provider.dart';

part 'contact_tracing_page.g.dart';

@cwidget
Widget contactTracingPage(WidgetRef ref) {
  final state = ref.watch(bluetoothStateProvider);
  return Scaffold(
      floatingActionButton: const ScanningButtonBuilder(),
      body: state.when(
          error: (String error) => Center(child: Text(error)),
          initial: () => const Center(child: Text('Please press scan button')),
          data: (List<BluetoothDevice> devices, bool isScanning) => ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('address: ${devices[index].address}, name: ${devices[index].name}, time: ${DateTime.now()}'),
                  );
                },
                itemCount: devices.length,
              ),
          empty: () {
            return const Center(
              child: Text('Not scanned device'),
            );
          }));
}

@cwidget
Widget scanningButtonBuilder(WidgetRef ref) {
  final state = ref.watch(bluetoothStateProvider);

  final isScanning = state.maybeWhen(data: (devices, isScanning) => isScanning, orElse: () => false);

  return FloatingActionButton(
    heroTag: 'scan_btn',
    onPressed: () {
      print('scan button');
      isScanning ? ref.read(bluetoothStateProvider.notifier).stopScan() : ref.read(bluetoothStateProvider.notifier).scanDevice();
    },
    child: isScanning ? const CircularProgressIndicator.adaptive() : const Icon(Icons.search),
  );
}
