import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monigate_app/controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Center(
            child: Text(
          'MoniGate',
          style: Theme.of(context).textTheme.headline4!.merge(const TextStyle(color: Colors.white)),
        )),
      ),
    );
  }
}
