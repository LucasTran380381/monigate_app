import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/themes/color.dart';
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
          data: (notifications) => RefreshIndicator(
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
              ),
          loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
          error: (error, st) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Đã có lỗi xảy ra, vui lòng thử lại ${error}'),
                  TextButton(
                    onPressed: () {
                      ref.refresh(notificationProvider);
                    },
                    child: Text('Thử lại'),
                  )
                ],
              )),
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
          child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(notification.message),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}