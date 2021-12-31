import 'package:flutter/material.dart';
import 'package:monigate_app/checkin_history/models/checkin_item.dart';
import 'package:monigate_app/checkin_history/models/face_mask_status.dart';
import 'package:monigate_app/checkin_history/models/temperature_status.dart';
import 'package:monigate_app/common/util/datetime_extension.dart';

import '../../../common/themes/color.dart';

class ItemTitle extends StatelessWidget {
  final CheckinItem checkin;

  const ItemTitle({Key? key, required this.checkin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final faceMaskStatus = _getFaceMaskStatus(checkin.faceMaskStatusCode);
    final temperatureStatus = _getTemperatureStatus(checkin.temperatureStatusCode);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          checkin.checkinDate.shortFormat,
          style: Theme.of(context).textTheme.headline6,
        ),
        Row(
          children: [
            const Text(
              'trạng thái khẩu trang: ',
            ),
            Tooltip(
              message: faceMaskStatus.title,
              child: Icon(
                Icons.masks_outlined,
                color: faceMaskStatus.color,
              ),
            )
          ],
        ),
        Row(
          children: [
            const Text(
              'trạng thái nhiệt độ: ',
            ),
            Tooltip(
              message: temperatureStatus.title,
              child: Icon(
                Icons.thermostat_outlined,
                color: temperatureStatus.color,
              ),
            )
          ],
        ),
      ],
    );
  }

  FaceMaskStatus _getFaceMaskStatus(int status) {
    switch (status) {
      case 100:
        return FaceMaskStatus(status: 100, title: 'Không đeo khẩu trang', color: AppColor.errorColor);
      case 200:
        return FaceMaskStatus(status: 200, title: 'Khẩu trang hợp lệ', color: AppColor.successColor);
      case 210:
        return FaceMaskStatus(status: 210, title: 'Không đeo khẩu trang', color: AppColor.warningColor);
      default:
        return FaceMaskStatus(status: 000, title: 'Chưa có thông tin', color: AppColor.warningColor);
    }
  }

  TemperatureStatus _getTemperatureStatus(int status) {
    switch (status) {
      case 100:
        return TemperatureStatus(status: 100, title: 'Nhiệt độ bình thường', color: AppColor.successColor);
      case 200:
        return TemperatureStatus(status: 200, title: 'Nhiệt độ cao', color: AppColor.errorColor);
      default:
        return TemperatureStatus(status: 0, title: 'unknow', color: AppColor.errorColor);
    }
  }
}
