import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/service/checkin_service.dart';
import 'package:monigate_app/disease_report/services/disease_report_service.dart';

final diseaseReportMessageProvider = FutureProvider.autoDispose<String?>((ref) async {
  final report = await ref.read(diseaseReportServiceProvider).getDiseaseReportToday();
  final checkin = await ref.read(checkinServiceProvider).getMyCheckin();

  if (checkin == null) {
    return null;
  }

  if(checkin.temperature > 37.5 && report == null) {
    return 'Hệ thống ghi nhận checkin với nhiệt độ cao và bạn chưa báo cáo bệnh. Vui lòng báo cáo bệnh';
  }
});
