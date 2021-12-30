import 'dart:ui';

import 'package:device_display_brightness/device_display_brightness.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:monigate_app/common/providers/user_provider.dart';
import 'package:monigate_app/controllers/home_controller.dart';
import 'package:monigate_app/home/view/widgets/qr_code.dart';
import 'package:monigate_app/util.dart';
import 'package:monigate_app/widgets/checkin_status_card.dart';
import 'package:monigate_app/widgets/not_have_checkin_card.dart';
import 'package:monigate_app/widgets/tempature_mask_status_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message.data.toString()),
      ));
      final HomeController controller = Get.find();
      controller.getMyCheckin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    controller.getCurrentDate();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(userProvider);
            final firstname = state.maybeWhen(data: (value) => value?.firstName ?? '...', orElse: () => '...');

            return Text('Chào, $firstname', style: Theme.of(context).textTheme.headline5!.merge(const TextStyle(color: Colors.white)));
          },
        ),
        actions: [IconButton(icon: const Icon(Icons.notifications), onPressed: () {})],
      ),
      body: RefreshIndicator(
        color: Util.primaryColor,
        onRefresh: () => controller.getMyCheckin(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Util.primaryColor.withOpacity(0.3), spreadRadius: 2, blurRadius: 30, offset: const Offset(0, 10))],
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    final brightness = await DeviceDisplayBrightness.getBrightness();
                    if (brightness != 1) {
                      DeviceDisplayBrightness.setBrightness(1);
                    } else {
                      DeviceDisplayBrightness.resetBrightness();
                    }
                  },
                  // child: QrImage(
                  //   data:
                  //       '${controller.currentUser.id}, ${TiengViet.parse(controller.currentUser.firstName)}, ${TiengViet.parse(controller.currentUser.lastName)}',
                  //   version: QrVersions.auto,
                  //   size: 200,
                  // ),
                  child: const QrCode(),
                ),
                const Text(
                  'nhấn vào qr để tăng sáng màn hình',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(userProvider);
                    return state.maybeWhen(
                        data: (user) {
                          final firstName = user!.firstName;
                          final lastName = user.lastName;
                          return Text(
                            '$lastName $firstName',
                            style: Theme.of(context).textTheme.headline5,
                          );
                        },
                        orElse: () => const Text('... lấy dữ liệu người dùng'));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  final date = controller.currentDate.value;
                  return Text(
                    '${date.day}/${date.month}/${date.year}',
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() {
                    final checkin = controller.checkin.value;
                    if (checkin != null) {
                      return Column(
                        children: [
                          CheckinStatusCard(
                            status: checkin.status,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TemperatureAndMarkStatus(
                            temperature: checkin.temperature,
                            faceMaskStatus: checkin.faceMaskStatus,
                          ),
                        ],
                      );
                    }
                    return const NotHaveCheckinCard();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
