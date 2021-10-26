import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:monigate_app/controllers/splash_controller.dart';
import 'package:monigate_app/views/root_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: GestureDetector(
            child: Center(
                child: Text(
              'MoniGate',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .merge(const TextStyle(color: Colors.white)),
            )),
            onTap: () => Get.off(() => const RootPage())),
      ),
    );
  }
}
