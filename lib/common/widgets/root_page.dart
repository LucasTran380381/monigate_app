import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'package:monigate_app/checkin_history/view/history_checkin_page.dart';
import 'package:monigate_app/common/providers/bottom_navigation_index_provider.dart';
import 'package:monigate_app/common/service/notification_service.dart';
import 'package:monigate_app/contact_tracing/services/tracing_service.dart';

import '../../home/view/home_page.dart';
import '../../menu_profile/menu_page.dart';

part 'root_page.g.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {
  @override
  initState() {
    _initFCM();

    initPlatformState();
    super.initState();
  }

  _initFCM() async {
    await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessage.listen((message) {
      print('notification');
      ProviderContainer().read(notificationServiceProvider).handleNotification(message);
    });
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    int status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.NONE), (String taskId) async {
      // <-- Event handler
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      ProviderContainer().read(tracingServiceProvider).syncData();
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      // <-- Task timeout handler.
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      ProviderContainer().read(tracingServiceProvider).syncData();
      BackgroundFetch.finish(taskId);
    });
    print('[BackgroundFetch] configure success: $status');
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: AppNavigationBar(),
      body: BodyBuilder(),
    );
  }
}

@cwidget
Widget bodyBuilder(WidgetRef ref) {
  final state = ref.watch(bottomNavigationIndexProvider);
  switch (state) {
    case 0:
      return const HomePage();
    case 1:
      return const CheckinPage();
    case 2:
      return const MenuPage();
    default:
      return const SizedBox();
  }
}

@cwidget
Widget appNavigationBar(WidgetRef ref) {
  final index = ref.watch(bottomNavigationIndexProvider);
  return BottomNavigationBar(
    currentIndex: index,
    onTap: ref.read(bottomNavigationIndexProvider.notifier).selectIndex,
    items: [
      BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'bottom_navigation_home'.tr),
      BottomNavigationBarItem(icon: const Icon(Icons.admin_panel_settings), label: 'bottom_navigation_attendance'.tr),
      const BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
    ],
  );
}
