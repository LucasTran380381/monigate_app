import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/themes/color.dart';
import 'package:monigate_app/common/util/datetime_extension.dart';
import 'package:monigate_app/notification/models/notification.dart' as model;
import 'package:monigate_app/notification/providers/notificaion_provider.dart';
import 'package:monigate_app/notification/view/notification_detail_page.dart';

class NotificationListPage extends ConsumerWidget {
  const NotificationListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        centerTitle: false,
      ),
      body: state.when(
          data: (notifications) {
            notifications.sort((noti1, noti2) => noti2.dateReceived.timestamp - noti1.dateReceived.timestamp);
            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(notificationProvider);
              },
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final notification = notifications[index];
                  return NotificationCard(
                    notification: notification,
                  );
                },
                itemCount: notifications.length,
              ),
            );
          },
          loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
          error: (error, st) => const Center(child: Text('Chưa có thông tin checkin'))),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final model.Notification notification;

  const NotificationCard({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        return NotificationDetailPage(notification);
      })),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'Chú ý tiếp xúc',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const WidgetSpan(
                    child: Icon(
                      Icons.report_problem,
                      color: AppColor.warningColor,
                    ),
                  )
                ])),
                const SizedBox(
                  height: 10,
                ),
                Text(notification.dateReceived.shortFormatDate),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(notification.message),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
