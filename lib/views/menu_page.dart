import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monigate_app/controllers/menu_controller.dart';
import 'package:monigate_app/util.dart';

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
            Obx(() {
              final user = controller.user.value;
              return Text(
                '${user.lastName} ${user.firstName}',
                style: Theme.of(context).textTheme.headline4!.merge(const TextStyle(color: Colors.black)),
              );
            }),
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
      shadowColor: Util.primaryColor,
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
              title: Text('menu_notification'.tr),
              leading: const Icon(Icons.notifications_rounded),
            ),
            const Divider(
              height: 1,
              indent: 24 + 20 + 20,
            ),
            ListTile(
              title: Text('menu_edit_user_info'.tr),
              leading: const Icon(Icons.edit),
            ),
            const Divider(
              height: 1,
              indent: 24 + 20 + 20,
            ),
            // ListTile(
            //   title: Text('menu_tracking_contact'.tr),
            //   leading: const Icon(Icons.bluetooth),
            // ),
            const Divider(
              height: 1,
              indent: 24 + 20 + 20,
            ),
            Obx(
              () => SwitchListTile.adaptive(
                secondary: const Icon(Icons.language),
                title: Text('menu_vietnamese'.tr),
                value: controller.isUseVietnamese.value,
                onChanged: (bool value) {
                  controller.changeLanguage(value);
                },
              ),
            ),
            const Divider(
              height: 1,
              indent: 24 + 20 + 20,
            ),
            ListTile(
              title: const Text('Đăng xuất'),
              leading: const Icon(Icons.logout_outlined),
              onTap: controller.logout,
            ),
          ],
        ),
      ),
    );
  }
}
