import 'package:get/get.dart';

class RootController extends GetxController {
  var currentIndex = 0.obs;

  void selectTab(int index) {
    currentIndex.value = index;
  }
}
