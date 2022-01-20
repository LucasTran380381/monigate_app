// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      json['userId'] as String,
      json['isSynced'] as bool,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'userId': instance.userId,
      'isSynced': instance.isSynced,
    };
