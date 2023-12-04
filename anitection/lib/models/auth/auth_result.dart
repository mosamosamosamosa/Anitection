
import 'package:anitection/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_result.g.dart';

@JsonSerializable()
class AuthResult {
  final String jwt;
  final User user;
  AuthResult({required this.jwt, required this.user});

  factory AuthResult.fromJson(Map<String, dynamic> json) {
    return _$AuthResultFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthResultToJson(this);
  }
}