import 'package:flutter/material.dart';

import 'package:monigate_app/checkin_history/models/checkin_item.dart';
import 'package:monigate_app/util.dart';

import 'item_title.dart';

class CheckinItemView extends StatelessWidget {
  final CheckinItem item;

  const CheckinItemView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            _getIconStatus(item.checkinStatusCode),
            const SizedBox(
              width: 20,
            ),
            ItemTitle(
              checkin: item,
            )
          ],
        ),
      ),
    );
  }

  Icon _getIconStatus(int checkinStatus) {
    switch (checkinStatus) {
      case 100:
        return const Icon(
          Icons.check_circle_outlined,
          color: Util.successColor,
        );
      case 200:
        return const Icon(
          Icons.report_problem_outlined,
          color: Util.warningColor,
        );
      default:
        return const Icon(
          Icons.error_outline_outlined,
          color: Util.errorColor,
        );
    }
  }
}
