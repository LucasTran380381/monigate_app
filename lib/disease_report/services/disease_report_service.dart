import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/service/dio_client.dart';

final diseaseReportServiceProvider = Provider((ref) {
  return DiseaseReportService();
});

class DiseaseReportService {
  Future<bool> sendReport(String diseaseCode, String note, List<File> files) async {
    try {
      await DioClient.instance.post('/DiseaseReport', data: _convertToFromData(diseaseCode, note, files));
      return true;
    } on DioError catch (e) {
      print(e.message);
      return false;
    }
  }

  _convertToFromData(String diseaseCode, String note, List<File> files) {
    final images = files.map((file) => MultipartFile.fromFileSync(file.path, filename: _generateFileName(file))).toList();
    final formData = FormData.fromMap({
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
}
