import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:monigate_app/contact_tracing/logic/contact_tracing_provider.dart';
import 'package:monigate_app/contact_tracing/services/bluetooth_scanner_service.dart';

part 'background_fect_page.g.dart';

@cwidget
Widget backgroundFetchPage(WidgetRef ref) {
  final state = ref.watch(contactTracingProvider);
  return Scaffold(
    floatingActionButton: const BackgroundTaskButtonBuilder(),
    body: state.when(
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        error: (Object error, StackTrace? stackTrace) => Center(child: Text('error $error')),
        data: (List<String> data) => data.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Chua có thông tin tracing'),
                  TextButton(
                    onPressed: () async {
                      // await Future.delayed(const Duration(seconds: 10));
                      ref.read(bluetoothScannerServiceProvider).scanDevice();
                    },
                    child: const Text('Scan device'),
                  ),
                ],
              )
            : Column(
                children: [
                  TextButton(
                    onPressed: () {
                      ref.read(bluetoothScannerServiceProvider).clearHistory();
                    },
                    child: Text('clear history'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(data[index]),
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                ],
              )),
  );
}

@cwidget
Widget backgroundTaskButtonBuilder(WidgetRef ref) {
  return FloatingActionButton(
    onPressed: () async {
      final status = await BackgroundFetch.start();
      print('$status');
    },
    child: Text('test'),
  );
}
