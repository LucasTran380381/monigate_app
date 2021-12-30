import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:monigate_app/controllers/tracking_detail_controller.dart';

import '../util.dart';

class TrackingDetailPage extends StatelessWidget {
  const TrackingDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TrackingDetailController());

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        )),
        centerTitle: false,
        title: const Text(
          'Chi tiết điểm danh',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CircleContactsNum(),
              const SizedBox(
                height: 20,
              ),
              Text(
                'contacts',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('16/10/2021'),
              const SizedBox(
                height: 20,
              ),
              const ContactsListView()
            ],
          ),
        ),
      ),
    );
  }
}

class CircleContactsNum extends StatelessWidget {
  const CircleContactsNum({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.lime),
      margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Center(
        child: Text(
          '3',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}

class ContactsListView extends StatelessWidget {
  const ContactsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(40, 0, 20, 0),
          width: double.infinity,
          child: Text(
            'Contacts user',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline6!.merge(TextStyle(color: Util.primaryColor.withOpacity(0.7))),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          elevation: 5,
          shadowColor: Util.primaryColor,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(Icons.account_circle_rounded),
                title: Text('John Example $index'),
              );
            },
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
          ),
        )
      ],
    );
  }
}
