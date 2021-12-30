import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/checkin_history/models/checkin_item.dart';
import 'package:monigate_app/common/util/datetime_extension.dart';
import 'package:monigate_app/models/checkin.dart';
import 'package:monigate_app/services/dio_client.dart';

final checkinServiceProvider = Provider<CheckinService>((ref) {
  return CheckinService();
});

class CheckinService {
  Future<Checkin?> getMyCheckin() async {
    final dio = DioClient.instance;
    final resp = await dio.get('/Checkin/me');
    if (resp.statusCode == 200) {
      final checkin = Checkin.fromJson(resp.data);
      return checkin;
    }
  }

  Future<List<CheckinItem>?> getCheckins({required DateTime dateFrom, required DateTime dateTo}) async {
    final dio = DioClient.instance;
    final resp = await dio.get('/Checkin/employee-report', queryParameters: {
      "timeMin": dateFrom.timestamp,
      // "timeMax": dateTo.timestamp,
    });
    final rawList = resp.data['reportList'] as List;
    return rawList.map((checkin) => CheckinItem.fromJson(checkin)).toList();
  }
}
