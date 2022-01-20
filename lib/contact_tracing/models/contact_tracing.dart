import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monigate_app/contact_tracing/models/contact.dart';

part 'contact_tracing.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactTracing {
  DateTime date;
  List<Contact> contacts;

  ContactTracing(this.date, this.contacts);

  factory ContactTracing.fromJson(Map<String, dynamic> json) => _$ContactTracingFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$ContactTracingToJson(this);
}
