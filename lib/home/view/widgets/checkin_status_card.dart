import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/home/logic/checkin_provider.dart';
import 'package:monigate_app/models/checkin.dart';

import '../../../util.dart';

class CheckinStatusCard extends ConsumerWidget {
  const CheckinStatusCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkinProvider);
    return state.when(
        noCheckin: () {
          return Text('hello');
        },
        loading: () => const CircularProgressIndicator.adaptive(),
        error: (String error) => const Text('Đã có lỗi xảy ra vui '
            'lòng thử lại'),
        hasCheckin: (Checkin checkin) {
          return Text('hello');
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
      shadowColor: Util.primaryColor,
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
