import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:monigate_app/common/service/checkin_service.dart';

import '../models/checkin_item.dart';

class CheckinLogic extends GetxController {
  final checkins = RxList<CheckinItem>();
  final checkinService = CheckinService();
  final isLoading = true.obs;

  @override
  void onInit() {
    fetchCheckins();
    super.onInit();
  }

  Future<void> fetchCheckins() async {
    try {
      final currentDate = DateTime.now();
      final firstDateOfMonth = DateTime(currentDate.year, currentDate.month);
      final lastDateOfMonth = DateTime(currentDate.year, currentDate.month, 0);
      checkins.value = await checkinService.getCheckins(dateFrom: firstDateOfMonth, dateTo: lastDateOfMonth);
    } on DioError catch (e) {
      e.toString();
    }
  }
}
