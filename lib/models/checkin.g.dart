// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Checkin _$CheckinFromJson(Map<String, dynamic> json) => Checkin(
      id: json['id'] as String,
      checkinTime: DateTime.parse(json['checkinTime'] as String),
      temperature: (json['temperature'] as num).toDouble(),
      faceMaskImageUrl: json['faceMaskImageUrl'] as String?,
      faceMaskStatus: json['faceMaskStatus'] as int,
      status: json['status'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    )..checkoutTime = json['checkoutTime'] == null
        ? null
        : DateTime.parse(json['checkoutTime'] as String);

Map<String, dynamic> _$CheckinToJson(Checkin instance) => <String, dynamic>{
      'id': instance.id,
      'checkinTime': instance.checkinTime.toIso8601String(),
      'checkoutTime': instance.checkoutTime?.toIso8601String(),
      'temperature': instance.temperature,
      'faceMaskImageUrl': instance.faceMaskImageUrl,
      'faceMaskStatus': instance.faceMaskStatus,
      'status': instance.status,
      'user': instance.user,
    };
