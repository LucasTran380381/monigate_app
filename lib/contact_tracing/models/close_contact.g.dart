// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloseContact _$CloseContactFromJson(Map<String, dynamic> json) => CloseContact(
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as String,
      contactWithUserId: json['userId'] as String,
      isSynced: json['isSynced'] as bool,
    );

Map<String, dynamic> _$CloseContactToJson(CloseContact instance) => <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'id': instance.id,
      'isSynced': instance.isSynced,
      'userId': instance.contactWithUserId,
    };

CloseContactForManipulation _$CloseContactForManipulationFromJson(Map<String, dynamic> json) => CloseContactForManipulation(
      DateTime.parse(json['contactDate'] as String),
      (json['contactedWithUserId'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CloseContactForManipulationToJson(CloseContactForManipulation instance) => <String, dynamic>{
      'contactDate': instance.contactDate.toIso8601String(),
      'contactedWithUserId': instance.contactedWithUserId,
    };
