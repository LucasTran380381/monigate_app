import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentDate = DateTime.now().obs;
  final dataDate = DateTime.now().obs;
  final isCheckingSuccessful = false.obs;

  @override
  void onInit() {
    dataDate.value = DateTime.now();
    super.onInit();
  }

  getCurrentDate() async {
    currentDate.value = DateTime.now();
  }

  void changeStatus() {
    isCheckingSuccessful(!isCheckingSuccessful.value);
  }
}
