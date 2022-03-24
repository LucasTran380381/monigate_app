import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/disease_report/services/disease_report_service.dart';
import 'package:monigate_app/disease_report/states/disease_report_state.dart';

final diseaseReportStateProvider = StateNotifierProvider.autoDispose<DiseaseReportNotifier, DiseaseReportState>((ref) {
  return DiseaseReportNotifier(ref);
});

class DiseaseReportNotifier extends StateNotifier<DiseaseReportState> {
  final Ref _ref;

  DiseaseReportNotifier(this._ref) : super(const DiseaseReportState.loading()) {
    getDiseaseReportToday();
  }

  Future<void> getDiseaseReportToday() async {
    state = const DiseaseReportState.loading();
    try {
      final report = await _ref.read(diseaseReportServiceProvider).getDiseaseReportToday();

      if (report == null) {
        state = const DiseaseReportState.empty();
        return;
      }

      if (report.status != 100) {
        state = const DiseaseReportState.approved();
        return;
      }

      state = DiseaseReportState.submitted(report);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        state = const DiseaseReportState.empty();
        return;
      }
      state = DiseaseReportState.error(e);
    }
  }
}
