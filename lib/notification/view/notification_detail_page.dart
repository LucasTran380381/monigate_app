import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/themes/color.dart';
import 'package:monigate_app/common/util/datetime_extension.dart';
import 'package:monigate_app/notification/models/notification.dart' as model;
import 'package:monigate_app/notification/providers/close_contact_date_provider.dart';

class NotificationDetailPage extends ConsumerWidget {
  final model.Notification notification;

  const NotificationDetailPage(
    this.notification, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(closeContactDateProvider(notification));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết thông báo'),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
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
                  height: 20,
                ),
                Text(
                  'Chú ý tiếp xúc trong các ngày:',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 20,
                ),
                state.when(
                  loading: () {
                    return const CircularProgressIndicator.adaptive();
                  },
                  error: (Object error, StackTrace? stackTrace) {
                    return Text(error.toString());
                  },
                  data: (List<DateTime>? data) {
                    print('data: $data');
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          final date = data?[index];
                          return Text(
                            'Ngày: ${date?.shortFormatDate}',
                            style: Theme.of(context).textTheme.headline6,
                          );
                        },
                        itemCount: data?.length ?? 0,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
