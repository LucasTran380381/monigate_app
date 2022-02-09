import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/disease_report/services/disease_report_service.dart';

final diseaseReportHistoryProvider = FutureProvider((ref) async {
  return ref.read(diseaseReportServiceProvider).getDiseaseReportHistory();
});
