import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.g.dart';

@JsonSerializable(explicitToJson: true)
class Contact {
  String userId;
  bool isSynced;

  Contact(this.userId, this.isSynced);

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
