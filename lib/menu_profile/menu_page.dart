import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:monigate_app/authentication/service/auth_service.dart';
import 'package:monigate_app/change_password/change_password_page.dart';
import 'package:monigate_app/common/providers/user_provider.dart';
import 'package:monigate_app/common/themes/color.dart';
import 'package:monigate_app/contact_tracing/logic/tracing_provider.dart';
import 'package:monigate_app/contact_tracing/services/tracing_service.dart';
import 'package:monigate_app/controllers/menu_controller.dart';
import 'package:monigate_app/edit_profile/edit_profile_page.dart';
import 'package:permission_handler/permission_handler.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MenuController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Menu',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: const BoxDecoration(color: Colors.amberAccent, shape: BoxShape.circle),
              child: const Center(
                child: FlutterLogo(
                  size: 100,
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(userProvider);
                final value = state.maybeWhen(
                    data: (user) => '${user.fullName}',
                    orElse: () {
                      return '...';
                    });
                return Text(
                  value,
                  style: Theme.of(context).textTheme.headline4!.merge(const TextStyle(color: Colors.black)),
                );
              },
            ),
            // Obx(() {
            //   final user = controller.user.value;
            //   return Text(
            //     '${user.lastName} ${user.firstName}',
            //     style: Theme.of(context).textTheme.headline4!.merge(const TextStyle(color: Colors.black)),
            //   );
            // }),
            const MenuListView()
          ],
        ),
      ),
    );
  }
}

class MenuListView extends StatelessWidget {
  const MenuListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuController controller = Get.find();
    return Card(
      elevation: 5,
      shadowColor: AppColor.primaryColor,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SingleChildScrollView(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text('menu_setting'.tr),
              leading: const Icon(Icons.settings),
            ),
            const Divider(
              height: 1,
              indent: 24 + 20 + 20,
            ),
            ListTile(
              title: const Text('Thay đổi mật khẩu'),
              leading: const Icon(Icons.password_outlined),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return const ChangePasswordPage();
                }));
              },
            ),
            const Divider(
              height: 1,
              indent: 24 + 20 + 20,
            ),
            ListTile(
              title: Text('menu_edit_user_info'.tr),
              leading: const Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return const EditProfilePage();
                }));
              },
            ),
            const Divider(
              height: 1,
              indent: 24 + 20 + 20,
            ),
            // ListTile(
            //   title: Text('menu_tracking_contact'.tr),
            //   leading: const Icon(Icons.bluetooth),
            // ),
            Consumer(
              builder: (context, ref, child) {
                return Row(
                  children: [
                    TextButton(
                      onPressed: () async {
                        ref.read(tracingServiceProvider).syncData();
                      },
                      child: const Text('sync now'),
                    ),
                    TextButton(
                      onPressed: () async {
                        ref.read(tracingServiceProvider).clearTracingData();
                      },
                      child: const Text('clear sync data'),
                    )
                  ],
                );
              },
            ),
            const Divider(
              height: 1,
              indent: 24 + 20 + 20,
            ),
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(tracingProvider);
                return SwitchListTile.adaptive(
                  title: const Text('tracing'),
                  value: state == TracingState.running,
                  onChanged: (bool value) async {
                    if (value == false) {
                      ref.read(tracingProvider.notifier).toggleService();
                      return;
                    }
                    final bluetoothStatuses = await [Permission.bluetoothScan, Permission.bluetoothAdvertise].request();

                    print('bluetooth status: $bluetoothStatuses');

                    //
                    // final locationStatuses = await [Permission.location, Permission.locationAlways].request();
                    final locationStatus = await Permission.locationWhenInUse.request();
                    final alwaysLocationStatus = await Permission.locationAlways.request();

                    print('locationStatus statuses: $locationStatus $alwaysLocationStatus');

                    if (bluetoothStatuses[Permission.bluetoothScan]!.isPermanentlyDenied ||
                        locationStatus.isPermanentlyDenied ||
                        alwaysLocationStatus.isDenied ||
                        alwaysLocationStatus.isPermanentlyDenied) {
                      openAppSettings();
                    }

                    if (bluetoothStatuses[Permission.bluetoothScan]!.isGranted &&
                        bluetoothStatuses[Permission.bluetoothAdvertise]!.isGranted &&
                        alwaysLocationStatus.isGranted) {
                      ref.read(tracingProvider.notifier).toggleService();
                    }
                  },
                );
              },
            ),
            // Obx(
            //   () => SwitchListTile.adaptive(
            //     secondary: const Icon(Icons.language),
            //     title: Text('menu_vietnamese'.tr),
            //     value: controller.isUseVietnamese.value,
            //     onChanged: (bool value) {
            //       controller.changeLanguage(value);
            //     },
            //   ),
            // ),
            const Divider(
              height: 1,
              indent: 24 + 20 + 20,
            ),
            Consumer(
              builder: (context, ref, child) {
                return ListTile(
                  title: const Text('Đăng xuất'),
                  leading: const Icon(Icons.logout_outlined),
                  onTap: ref.read(authServiceProvider).logout,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
