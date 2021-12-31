import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/home/logic/checkin_provider.dart';
import 'package:monigate_app/models/checkin.dart';

import '../../../common/themes/color.dart';

class CheckinStatusCard extends ConsumerWidget {
  const CheckinStatusCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkinProvider);
    return state.when(
        noCheckin: () {
          return const ContentCard(
            icon: Icon(Icons.help_outline_outlined),
            title: 'Chưa có thông tin check-in',
            color: Colors.black,
          );
        },
        loading: () => const CircularProgressIndicator.adaptive(),
        error: (String error) => Text(
              error,
              style: Theme.of(context).textTheme.headline6?.copyWith(color: AppColor.errorColor),
            ),
        hasCheckin: (Checkin checkin) {
          switch (checkin.status) {
            case 100:
              return const ContentCard(
                  icon: Icon(
                    Icons.check_circle,
                    color: AppColor.successColor,
                  ),
                  title: 'Check-in thành công',
                  color: AppColor.successColor);
            case 200:
              return const ContentCard(
                icon: Icon(
                  Icons.warning_outlined,
                  color: AppColor.warningColor,
                ),
                title: 'Được phép cho vào',
                color: AppColor.warningColor,
              );
            default:
              return const ContentCard(
                icon: Icon(
                  Icons.error_outlined,
                  color: AppColor.errorColor,
                ),
                title: 'Check-in thất bại',
                color: AppColor.errorColor,
              );
          }
        });
  }
}

class ContentCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final Color color;

  const ContentCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColor.primaryColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
