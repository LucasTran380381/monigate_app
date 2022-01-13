import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:monigate_app/contact_tracing/logic/contact_tracing_provider.dart';
import 'package:monigate_app/contact_tracing/logic/scan_service_state_provider.dart';

part 'background_fect_page.g.dart';

@cwidget
Widget backgroundFetchPage(WidgetRef ref) {
  final state = ref.watch(contactTracingStateProvider);
  return Scaffold(
    floatingActionButton: const BackgroundTaskButtonBuilder(),
    body: state.when(
        data: (tracing) => SafeArea(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      ref.read(contactTracingStateProvider.notifier).clearHistory();
                    },
                    child: const Text('clear history'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        final element = tracing[index];
                        return ListTile(
                          title: Text('address: ${element.macAddress}, rssi: ${element.rssi}'),
                        );
                      },
                      itemCount: tracing.length,
                    ),
                  ),
                ],
              ),
            ),
        initial: () {
          return SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No start service scan'),
                  TextButton(
                    onPressed: () {
                      ref.read(scanServiceStateProvider.notifier).startService();
                    },
                    child: const Text('Start service'),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(contactTracingStateProvider.notifier).getContactTracing();
                    },
                    child: const Text('Get contact tracing'),
                  )
                ],
              ),
            ),
          );
        },
        empty: () {
          return Column(
            children: [
              const Text('No scanned device'),
              TextButton(
                onPressed: () {
                  ref.read(contactTracingStateProvider.notifier).getContactTracing();
                },
                child: const Text('Retry data'),
              ),
            ],
          );
        }),
  );
}

@cwidget
Widget backgroundTaskButtonBuilder(WidgetRef ref) {
  final state = ref.watch(scanServiceStateProvider);
  return state.when(stopped: () {
    return FloatingActionButton(
      child: const Icon(Icons.search_outlined),
      onPressed: () {
        ref.read(scanServiceStateProvider.notifier).startService();
      },
    );
  }, running: () {
    return FloatingActionButton(
      child: const Icon(
        Icons.done_outlined,
      ),
      onPressed: () {
        ref.read(scanServiceStateProvider.notifier).stopService();
      },
    );
  }, loading: () {
    return FloatingActionButton(
      child: const CircularProgressIndicator.adaptive(),
      onPressed: () {
        ref.read(scanServiceStateProvider.notifier).startService();
      },
    );
  });
}
