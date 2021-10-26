import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:monigate_app/controllers/home_controller.dart';
import 'package:monigate_app/util.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    controller.getCurrentDate();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text('home_appbar_title'.trParams({'name': 'Nhan'}),
            style: Theme.of(context)
                .textTheme
                .headline4!
                .merge(const TextStyle(color: Colors.white))),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {})
        ],
      ),
      body: RefreshIndicator(
        color: Util.primaryColor,
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Util.primaryColor.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 30,
                  offset: const Offset(0, 10))
            ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                QrImage(
                  data: '1234567890',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Tran Nhan',
                  style: Theme.of(context).textTheme.headline5,
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
                Card(
                  margin: const EdgeInsets.all(20),
                  shadowColor: Util.primaryColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Util.primaryColor,
                        ),
                        GestureDetector(
                          child: Obx(
                            () => Text(
                              (controller.isCheckingSuccessful.value
                                      ? 'home_'
                                          'checking_status_false'
                                      : 'home_checking_status_true')
                                  .tr,
                              style: TextStyle(
                                  color: Util.primaryColor.withOpacity(0.7)),
                            ),
                          ),
                          onTap: controller.changeStatus,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            color: Colors.amberAccent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(Icons.favorite),
                              Text('38.5 ˚C')
                            ],
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 2,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Util.primaryColor.withOpacity(0.7),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.send, color: Colors.white),
                              Text(
                                'home_report_button_label'.tr,
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
