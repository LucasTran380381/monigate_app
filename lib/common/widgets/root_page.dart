import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:monigate_app/checkin_history/view/history_checkin_page.dart';
import 'package:monigate_app/common/providers/bottom_navigation_index_provider.dart';
import 'package:monigate_app/common/service/notification_service.dart';
import 'package:monigate_app/contact_tracing/services/bluetooth_scanner_service.dart';
import 'package:monigate_app/home/logic/checkin_provider.dart';

import '../../home/view/home_page.dart';
import '../../menu_profile/menu_page.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {
  @override
  void initState() {
    initPlatformState();
    FirebaseMessaging.onMessage.listen((message) {
      final String? checkinStatus = message.data['checkinStatusCode'];
      if (checkinStatus != null) {
        ref.read(notificationServiceProvider).showNotification('Checkin', 'Đã cập nhật checkin', 'payload');
        ref.read(checkinProvider.notifier).fetchCheckin();
      }
    });
    super.initState();
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    int status = await BackgroundFetch.configure(BackgroundFetchConfig(minimumFetchInterval: 15), (String taskId) async {
      // <-- Event handler
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      ref.read(bluetoothScannerServiceProvider).scanDevice();
      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      // BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      // <-- Task timeout handler.
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      print('time: ${DateTime.now()}');
      BackgroundFetch.finish(taskId);
    });
    print('[BackgroundFetch] configure success: $status');
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  @override
  Widget build(BuildContext context) {
    final screens = [const HomePage(), const CheckinPage(), const MenuPage()];
    return Scaffold(bottomNavigationBar: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final state = ref.watch(bottomNavigationIndexProvider);
        return BottomNavigationBar(
          currentIndex: state,
          onTap: ref.read(bottomNavigationIndexProvider.notifier).selectIndex,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'bottom_navigation_home'.tr),
            BottomNavigationBarItem(icon: const Icon(Icons.admin_panel_settings), label: 'bottom_navigation_attendance'.tr),
            const BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          ],
        );
      },
    ), body: Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(bottomNavigationIndexProvider);
        return screens[state];
      },
    ));
  }
}
