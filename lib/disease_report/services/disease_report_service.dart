import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/service/dio_client.dart';
import 'package:monigate_app/common/util/datetime_extension.dart';
import 'package:monigate_app/disease_report/models/disease_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

final diseaseReportServiceProvider = Provider((ref) {
  return DiseaseReportService();
});

class DiseaseReportService {
  Future<bool> sendReport(String diseaseCode, String note, List<File> files) async {
    try {
      await DioClient.instance.post('/DiseaseReport', data: _convertToFormData(diseaseCode, note, files));
      return true;
    } on DioError catch (e) {
      print(e.message);
      return false;
    }
  }

  _convertToFormData(String diseaseCode, String note, List<File> files, [String? id]) {
    final images = files.map((file) => MultipartFile.fromFileSync(file.path, filename: _generateFileName(file))).toList();
    final formData = id == null
        ? FormData.fromMap({
            'DiseaseCode': diseaseCode,
            'Note': note,
            'ReportImage': [],
          })
        : FormData.fromMap({
            'Id': id,
            'DiseaseCode': diseaseCode,
            'Note': note,
            'ReportImage': [],
          });

    for (var image in images) {
      formData.files.add(MapEntry('ReportImage', image));
    }

    print(formData.fields);
    return formData;
  }

  _generateFileName(File file) {
    return file.path.split('/').last;
  }

  Future<List<DiseaseReport>> getDiseaseReportHistory() async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('userId');
    final resp = await DioClient.instance.get('/DiseaseReport/user/$userId');
    final rawData = resp.data as List;
    print(rawData);
    return rawData.map((e) => DiseaseReport.fromJson(e)).toList();
  }

  Future<DiseaseReport?> getDiseaseReportToday() async {
    final resp = await DioClient.instance.get('/DiseaseReport/latest-reports/me');

    if (resp.statusCode == 404) {
      return null;
    }

    final report = DiseaseReport.fromJson(resp.data);

    if (!report.reportDate.isSameDay(DateTime.now())) {
      return null;
    }

    return report;
  }

  updateReport(DiseaseReport report, files) async {
    try {
      await DioClient.instance.put('/DiseaseReport', data: _convertToFormData(report.diseaseCode, report.note, files, report.id));
      return true;
    } on DioError catch (e) {
      print(e.message);
      return false;
    }
  }
}
