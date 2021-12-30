import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monigate_app/common/service/checkin_service.dart';
import 'package:monigate_app/models/checkin.dart';
import 'package:monigate_app/models/user.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  late final User currentUser;
  final currentDate = DateTime.now().obs;
  final dataDate = DateTime.now().obs;
  final isCheckingSuccessful = false.obs;
  final checkinService = CheckinService();
  final checkin = Rxn<Checkin>();

  @override
  Future<void> onInit() async {
    currentUser = User.fromJson(box.read('currentUser'));
    dataDate.value = DateTime.now();
    await getMyCheckin();
    super.onInit();
  }

  getCurrentDate() async {
    currentDate.value = DateTime.now();
  }

  void changeStatus() {
    isCheckingSuccessful(!isCheckingSuccessful.value);
  }

  Future<void> getMyCheckin() async {
    try {
      checkin.value = await checkinService.getMyCheckin();
    } on DioError catch (e) {
      e.toString();
    }
  }
}
