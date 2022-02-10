import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'disease_report.g.dart';

@JsonSerializable()
class DiseaseReport {
  DiseaseReport({
    required this.id,
    required this.reportedUserId,
    required this.reportDate,
    required this.note,
    required this.diseaseCode,
    required this.status,
    this.reportImageUrls,
    required this.reportedUser,
  });

  String id;
  String reportedUserId;
  DateTime reportDate;
  String note;
  String diseaseCode;
  int status;
  List<String>? reportImageUrls;
  ReportedUser reportedUser;

  factory DiseaseReport.fromJson(Map<String, dynamic> json) => _$DiseaseReportFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$DiseaseReportToJson(this);

  String get statusTitle {
    switch (status) {
      case 200:
        return 'Đã chấp nhận';
      case 300:
        return 'Đã thông báo';
      case 100:
        return 'Chưa được chấp nhận';
    }
    return 'status title';
  }

  Icon get statusIcon {
    var color = Colors.black;
    var icon = Icons.help_outline_outlined;
    switch (status) {
      case 200:
        color = Colors.green;
        icon = Icons.check_outlined;
        break;
      case 300:
        color = Colors.green;
        icon = Icons.notifications_outlined;
        break;
      case 100:
        color = Colors.red;
        icon = Icons.close_outlined;
    }
    return Icon(
      icon,
      color: color,
    );
  }
}

@JsonSerializable()
class ReportedUser {
  ReportedUser({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  String id;
  String firstName;
  String lastName;

  factory ReportedUser.fromJson(Map<String, dynamic> json) => _$ReportedUserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$ReportedUserToJson(this);
}
