import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monigate_app/controllers/root_controller.dart';
import 'package:monigate_app/views/tracking_page.dart';

import 'home_page.dart';
import 'menu_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RootController());
    final screens = [const HomePage(), const TrackingPage(), const MenuPage()];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.selectTab,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'bottom_navigation_home'.tr),
            BottomNavigationBarItem(
                icon: const Icon(Icons.admin_panel_settings),
                label: 'bottom_navigation_attendance'.tr),
            const BottomNavigationBarItem(
                icon: Icon(Icons.menu), label: 'Menu'),
          ],
        ),
      ),
      body: Obx(
        () => PageTransitionSwitcher(
          transitionBuilder: (Widget child, Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: screens[controller.currentIndex.value],
        ),
      ),
    );
  }
}
