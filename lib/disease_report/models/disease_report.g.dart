// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiseaseReport _$DiseaseReportFromJson(Map<String, dynamic> json) =>
    DiseaseReport(
      id: json['id'] as String,
      reportedUserId: json['reportedUserId'] as String,
      reportDate: DateTime.parse(json['reportDate'] as String),
      note: json['note'] as String,
      diseaseCode: json['diseaseCode'] as String,
      status: json['status'] as int,
      reportImageUrls: (json['reportImageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      reportedUser:
          ReportedUser.fromJson(json['reportedUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiseaseReportToJson(DiseaseReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reportedUserId': instance.reportedUserId,
      'reportDate': instance.reportDate.toIso8601String(),
      'note': instance.note,
      'diseaseCode': instance.diseaseCode,
      'status': instance.status,
      'reportImageUrls': instance.reportImageUrls,
      'reportedUser': instance.reportedUser,
    };

ReportedUser _$ReportedUserFromJson(Map<String, dynamic> json) => ReportedUser(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$ReportedUserToJson(ReportedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
