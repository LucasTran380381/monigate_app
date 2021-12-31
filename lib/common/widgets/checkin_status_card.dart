import 'dart:ui';

import 'package:flutter/material.dart';

import '../themes/color.dart';

class CheckinStatusCard extends StatelessWidget {
  final int status;

  const CheckinStatusCard({Key? key, required this.status}) : super(key: key);

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
            getStatusIcon(),
            Text(
              getStatusTitle(),
              style: TextStyle(color: getStatusColor(), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String getStatusTitle() {
    switch (status) {
      case 100:
        return 'Checkin thành công';
      case 200:
        return 'Lưu ý checkin';
      case 110:
        return 'Checkin thất bại';
    }
    return 'Chưa có thông tin';
  }

  Color getStatusColor() {
    var color = Colors.black;
    switch (status) {
      case 100:
        return AppColor.successColor;
      case 200:
        return AppColor.warningColor;
      case 210:
        return AppColor.errorColor;
    }
    return color;
  }

  Icon getStatusIcon() {
    IconData iconData;
    switch (status) {
      case 100:
        iconData = Icons.check_circle;
        break;
      case 200:
        iconData = Icons.warning_outlined;
        break;
      case 210:
        iconData = Icons.error_outlined;
        break;
      default:
        iconData = Icons.help_outline_outlined;
    }

    return Icon(
      iconData,
      color: getStatusColor(),
    );
  }
}
