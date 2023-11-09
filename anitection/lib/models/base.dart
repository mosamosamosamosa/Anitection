import 'package:json_annotation/json_annotation.dart';

part 'base.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Model<T> {
  final int id;
  final T attributes;

  Model({required this.id, required this.attributes});

  factory Model.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT) {
    return _$ModelFromJson(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return _$ModelToJson(this, toJsonT);
  }
}