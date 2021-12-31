import 'package:flutter/material.dart';
import 'package:monigate_app/models/ui/face_mask_section_model.dart';

import '../themes/color.dart';

class TemperatureAndMarkStatus extends StatelessWidget {
  final double temperature;
  final int faceMaskStatus;

  const TemperatureAndMarkStatus({Key? key, required this.temperature, required this.faceMaskStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TemperatureSection(
            temperature: temperature,
          ),
        ),
        const VerticalDivider(
          color: Colors.white,
          width: 2,
        ),
        Expanded(
          flex: 2,
          child: FaceMaskSection(
            faceMaskStatus: faceMaskStatus,
          ),
        )
      ],
    );
  }
}

class TemperatureSection extends StatelessWidget {
  final double temperature;

  const TemperatureSection({Key? key, required this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        color: getTemperatureColor(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.thermostat_outlined,
            color: Colors.white,
          ),
          Text(
            '$temperature ˚C',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Color getTemperatureColor() {
    if (temperature < 37.5) {
      return AppColor.successColor;
    } else {
      return AppColor.errorColor;
    }
  }
}

class FaceMaskSection extends StatelessWidget {
  final int faceMaskStatus;

  const FaceMaskSection({Key? key, required this.faceMaskStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final faceMaskInfo = getFaceMaskInfo();
    return Container(
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: faceMaskInfo.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.masks,
            color: faceMaskInfo.color,
          ),
          Text(
            faceMaskInfo.title,
            style: TextStyle(color: faceMaskInfo.color, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  FaceMaskInfo getFaceMaskInfo() {
    var title = 'Chưa có thông tin';
    var color = AppColor.successColor;
    var backgroundColor = AppColor.backgroundColor;
    switch (faceMaskStatus) {
      case 200:
        title = 'Khẩu trang hợp lệ';
        color = Colors.white;
        backgroundColor = AppColor.successColor;
        break;
      case 100:
        title = 'Không đeo khẩu trang';
        color = Colors.white;
        backgroundColor = AppColor.errorColor;
        break;
      case 210:
        title = 'Khẩu trang sai';
        color = Colors.black;
        backgroundColor = AppColor.warningColor;
        break;
    }
    return FaceMaskInfo(
      title: title,
      color: color,
      backgroundColor: backgroundColor,
    );
  }
}
