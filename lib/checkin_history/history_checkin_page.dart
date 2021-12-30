import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monigate_app/checkin_history/widgets/checkin_list_view.dart';
import 'package:monigate_app/util.dart';

import 'checkin_logic.dart';

class CheckinPage extends StatelessWidget {
  const CheckinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckinLogic());
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Báo cáo điểm danh',
        ),
      ),
      backgroundColor: Util.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () => controller.fetchCheckins(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HistoryCheckinPage(
                    checkins: controller.checkins.value,
                  ),
                ),
              );
            }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
