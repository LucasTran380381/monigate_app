import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monigate_app/util.dart';
import 'package:monigate_app/views/tracking_detail_page.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Util.backgroundColor,
      body: NestedScrollView(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              AttendanceListView(title: 'tracking_this_week'.tr),
              const SizedBox(
                height: 20,
              ),
              AttendanceListView(title: 'tracking_last_week'.tr),
            ],
          ),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              )),
              expandedHeight: 140,
              snap: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.fromLTRB(20, 0, 0, 50),
                title: Text(
                  'tracking_appbar_title'.tr,
                  style: Theme.of(context).textTheme.headline5!.merge(
                        const TextStyle(color: Colors.white),
                      ),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}

class AttendanceListView extends StatelessWidget {
  final String? title;

  const AttendanceListView({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(40, 0, 20, 10),
          width: double.infinity,
          child: Text(
            '$title'.tr,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .merge(const TextStyle(color: Util.primaryColor)),
            textAlign: TextAlign.left,
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          margin: const EdgeInsets.only(
            right: 20,
            left: 20,
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: const Text('21/10/2021'),
                subtitle: Text(
                  'tracking_contact'.trPluralParams(
                    'tracking_contacts',
                    index + 1,
                    {'numOfContact': (index + 1).toString()},
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () => Get.to(
                  () => const TrackingDetailPage(),
                  arguments: 1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
