import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monigate_app/disease_report/models/disease_report.dart';

part 'disease_report_state.freezed.dart';

@freezed
class DiseaseReportState with _$DiseaseReportState {
  const factory DiseaseReportState.loading() = Loading;

  const factory DiseaseReportState.submitted(DiseaseReport report) = Summited;

  const factory DiseaseReportState.approved() = Approved;

  const factory DiseaseReportState.empty() = Empty;

  const factory DiseaseReportState.error(dynamic err) = Error;
}
