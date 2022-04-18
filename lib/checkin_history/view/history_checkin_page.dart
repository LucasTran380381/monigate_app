
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:monigate_app/checkin_history/logic/disease_report_message_provider.dart';
import 'package:monigate_app/checkin_history/view/widgets/checkin_list_view.dart';
import 'package:monigate_app/common/themes/color.dart';
import 'package:monigate_app/notification/services/notification_service.dart';
import 'checkin_logic.dart';

class CheckinPage extends ConsumerWidget {
  const CheckinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = Get.put(CheckinLogic());
    ref.listen<AsyncValue<String?>>(diseaseReportMessageProvider, (previous, next) {
        if (next.value != null) {
          ref.read(notificationServiceProvider).showNotification('Báo cáo bệnh', next.value, '');
        }
      },onError: (error, stackTrace) {
      print('error $error');
      },);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Báo cáo điểm danh',
        ),
      ),
      backgroundColor: AppColor.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () {
          return controller.fetchCheckins();
        },
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return controller.checkins.isNotEmpty
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: HistoryCheckinPage(
                          checkins: controller.checkins.value,
                        ),
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: Text('Chưa có danh sách điểm danh'),
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
