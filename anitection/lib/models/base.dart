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

@JsonSerializable(genericArgumentFactories: true)
class SingleData<T> {
  final T data;

  SingleData({required this.data});

  factory SingleData.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT) {
    return _$SingleDataFromJson(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return _$SingleDataToJson(this, toJsonT);
  }
}

@JsonSerializable(genericArgumentFactories: true)
class ArrayData<T> {
  final List<T> data;

  ArrayData({required this.data});

  factory ArrayData.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT) {
    return _$ArrayDataFromJson(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return _$ArrayDataToJson(this, toJsonT);
  }
}