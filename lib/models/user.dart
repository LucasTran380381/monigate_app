import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id, firstName, lastName, phone, email;
  String? avatarUrl;
  int status;

  User(this.id, this.firstName, this.lastName, this.avatarUrl, this.phone, this.email, this.status);

  String get fullName => '$lastName $firstName';

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EventToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
