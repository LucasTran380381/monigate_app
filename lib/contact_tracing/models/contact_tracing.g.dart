// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_tracing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactTracing _$ContactTracingFromJson(Map<String, dynamic> json) =>
    ContactTracing(
      DateTime.parse(json['date'] as String),
      (json['contacts'] as List<dynamic>)
          .map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactTracingToJson(ContactTracing instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'contacts': instance.contacts.map((e) => e.toJson()).toList(),
    };
