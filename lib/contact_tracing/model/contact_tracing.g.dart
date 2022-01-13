// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_tracing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactTracing _$ContactTracingFromJson(Map<String, dynamic> json) =>
    ContactTracing(
      macAddress: json['macAddress'] as String,
      isSynced: json['isSynced'] as bool,
      time: DateTime.parse(json['time'] as String),
      rssi: json['rssi'] as int,
    );

Map<String, dynamic> _$ContactTracingToJson(ContactTracing instance) =>
    <String, dynamic>{
      'macAddress': instance.macAddress,
      'isSynced': instance.isSynced,
      'time': instance.time.toIso8601String(),
      'rssi': instance.rssi,
    };
