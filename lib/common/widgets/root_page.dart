import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:monigate_app/checkin_history/view/history_checkin_page.dart';
import 'package:monigate_app/common/providers/bottom_navigation_index_provider.dart';
import 'package:monigate_app/common/service/notification_service.dart';
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
    FirebaseMessaging.onMessage.listen((message) {
      final String? checkinStatus = message.data['checkinStatusCode'];
      if (checkinStatus != null) {
        ref.read(notificationServiceProvider).showNotification('Checkin', 'Đã cập nhật checkin', 'payload');
        ref.read(checkinProvider.notifier).fetchCheckin();
      }
    });
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    super.initState();
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

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    ref.read(notificationServiceProvider).showNotification('Checkin', 'Cập nhật checkin', 'payload');
  }
}
