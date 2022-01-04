import 'dart:ui';

import 'package:device_display_brightness/device_display_brightness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/providers/user_provider.dart';
import 'package:monigate_app/common/themes/color.dart';
import 'package:monigate_app/common/util/datetime_extension.dart';
import 'package:monigate_app/contact_tracing/view/background_fect_page.dart';
import 'package:monigate_app/contact_tracing/view/contact_tracing_page.dart';
import 'package:monigate_app/home/logic/checkin_provider.dart';
import 'package:monigate_app/home/view/widgets/checkin_status_card.dart';
import 'package:monigate_app/home/view/widgets/masks_status_temperature_card.dart';
import 'package:monigate_app/home/view/widgets/qr_code.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(userProvider);
            final firstname = state.maybeWhen(data: (value) => value?.firstName ?? '...', orElse: () => '...');

            return Text('Chào, $firstname', style: Theme.of(context).textTheme.headline5!.merge(const TextStyle(color: Colors.white)));
          },
        ),
        actions: [IconButton(icon: const Icon(Icons.notifications), onPressed: () {})],
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return RefreshIndicator(
            onRefresh: () => ref.read(checkinProvider.notifier).fetchCheckin(),
            child: child!,
          );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: AppColor.primaryColor.withOpacity(0.3), spreadRadius: 2, blurRadius: 30, offset: const Offset(0, 10))],
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return const ContactTracingPage();
                    }));
                  },
                  child: const Text('test bluetooth'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return const BackgroundFetchPage();
                    }));
                  },
                  child: const Text('test background'),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    final brightness = await DeviceDisplayBrightness.getBrightness();
                    if (brightness != 1) {
                      DeviceDisplayBrightness.setBrightness(1);
                    } else {
                      DeviceDisplayBrightness.resetBrightness();
                    }
                  },
                  child: const QrCode(),
                ),
                const Text(
                  'nhấn vào qr để tăng sáng màn hình',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(userProvider);
                    return state.maybeWhen(
                        data: (user) {
                          final firstName = user!.firstName;
                          final lastName = user.lastName;
                          return Text(
                            '$lastName $firstName',
                            style: Theme.of(context).textTheme.headline5,
                          );
                        },
                        orElse: () => const Text('... lấy dữ liệu người dùng'));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  currentDate.shortFormatDate,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CheckinStatusCard(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: MasksStatusAndTemperatureCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
