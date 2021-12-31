import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:monigate_app/home/logic/checkin_provider.dart';
import 'package:monigate_app/common/themes/color.dart';

part 'masks_status_temperature_card.g.dart';

class MasksStatusAndTemperatureCard extends ConsumerWidget {
  const MasksStatusAndTemperatureCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkinProvider);
    return state.maybeWhen(hasCheckin: (checkin) {
      return Row(
        children: [
          // temperature builder
          Expanded(
            flex: 1,
            child: checkin.temperature <= 37.5
                ? StatusCard(
                    icon: const Icon(
                      Icons.thermostat_outlined,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    title: '${checkin.temperature} '
                        '˚C',
                    bgColor: AppColor.successColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  )
                : StatusCard(
                    icon: const Icon(
                      Icons.thermostat_outlined,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    title: '${checkin.temperature} '
                        '˚C',
                    bgColor: AppColor.errorColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  ),
          ),
          const VerticalDivider(
            color: Colors.white,
            width: 2,
          ),
          // face masks status builder
          Expanded(
            flex: 2,
            child: Builder(
              builder: (BuildContext context) {
                late final Color color;
                late final Color bgColor;
                late final String title;

                switch (checkin.faceMaskStatus) {
                  case 200:
                    title = 'Khẩu trang hợp lệ';
                    color = Colors.white;
                    bgColor = AppColor.successColor;
                    break;
                  case 100:
                    title = 'Không đeo khẩu trang';
                    color = Colors.white;
                    bgColor = AppColor.errorColor;
                    break;
                  default:
                    title = 'Khẩu trang sai';
                    color = Colors.black;
                    bgColor = AppColor.warningColor;
                    break;
                }

                return StatusCard(
                  icon: Icon(
                    Icons.masks,
                    color: color,
                  ),
                  title: title,
                  color: color,
                  bgColor: bgColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                );
              },
            ),
          )
        ],
      );
    }, orElse: () {
      return Container();
    });
  }
}

@swidget
Widget statusCard({required Icon icon, required String title, required Color color, required Color bgColor, required BorderRadius borderRadius}) {
  return Container(
    height: 60,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: borderRadius,
      color: bgColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        icon,
        Text(
          title,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
