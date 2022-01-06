import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'package:monigate_app/checkin_history/view/history_checkin_page.dart';
import 'package:monigate_app/common/providers/bottom_navigation_index_provider.dart';
import 'package:monigate_app/common/service/notification_service.dart';
import 'package:monigate_app/home/logic/checkin_provider.dart';

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
  void initState() {
    FirebaseMessaging.onMessage.listen((message) {
      final String? checkinStatus = message.data['checkinStatusCode'];
      if (checkinStatus != null) {
        ref.read(notificationServiceProvider).showNotification('Checkin', 'Đã cập nhật checkin', 'payload');
        ref.read(checkinProvider.notifier).fetchCheckin();
      }
    });
    super.initState();
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
