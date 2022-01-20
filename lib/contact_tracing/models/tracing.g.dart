// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracing _$TracingFromJson(Map<String, dynamic> json) => Tracing(
      userId: json['userId'] as String,
      time: DateTime.parse(json['time'] as String),
      isSynced: json['isSynced'] as bool,
    );

Map<String, dynamic> _$TracingToJson(Tracing instance) => <String, dynamic>{
      'userId': instance.userId,
      'time': instance.time.toIso8601String(),
      'isSynced': instance.isSynced,
    };
