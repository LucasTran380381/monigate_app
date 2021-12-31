import 'package:flutter/material.dart';
import 'package:monigate_app/checkin_history/models/checkin_item.dart';

import 'checkin_item_view.dart';

class HistoryCheckinPage extends StatelessWidget {
  final List<CheckinItem> checkins;

  const HistoryCheckinPage({Key? key, required this.checkins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return CheckinItemView(
          item: checkins[index],
        );
      },
      itemCount: checkins.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 5,
        );
      },
    );
    // return Column(
    //   children: [
    //     Container(
    //       margin: const EdgeInsets.fromLTRB(40, 0, 20, 10),
    //       width: double.infinity,
    //       child: Text(
    //         title,
    //         style: Theme.of(context).textTheme.headline6!.merge(const TextStyle(color: Util.primaryColor)),
    //         textAlign: TextAlign.left,
    //       ),
    //     ),
    //     Card(
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    //       margin: const EdgeInsets.only(
    //         right: 20,
    //         left: 20,
    //       ),
    //       child: ListView.builder(
    //         padding: const EdgeInsets.only(
    //           left: 10,
    //           right: 10,
    //         ),
    //         shrinkWrap: true,
    //         itemCount: 7,
    //         itemBuilder: (BuildContext context, int index) {
    //           return ListTile(
    //             title: const Text('21/10/2021'),
    //             subtitle: Text(
    //               'tracking_contact'.trPluralParams(
    //                 'tracking_contacts',
    //                 index + 1,
    //                 {'numOfContact': (index + 1).toString()},
    //               ),
    //             ),
    //             trailing: const Icon(Icons.arrow_forward_ios_rounded),
    //             onTap: () => Get.to(
    //               () => const TrackingDetailPage(),
    //               arguments: 1,
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
