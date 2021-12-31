import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/checkin_history/models/checkin_item.dart';
import 'package:monigate_app/common/service/checkin_service.dart';

final historyCheckinsProvider = FutureProvider<List<CheckinItem>>((ref) async {
  final currentDate = DateTime.now();
  final firstDateOfMonth = DateTime(currentDate.year, currentDate.month);
  final lastDateOfMonth = DateTime(currentDate.year, currentDate.month, 0);
  return ref.read(checkinServiceProvider).getCheckins(dateFrom: firstDateOfMonth, dateTo: lastDateOfMonth);
});
