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
  final Meta meta;

  ArrayData({required this.data, required this.meta});

  factory ArrayData.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT) {
    return _$ArrayDataFromJson(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return _$ArrayDataToJson(this, toJsonT);
  }
}

@JsonSerializable()
class Pagination {
  final int total;
  final int limit;
  final int offset;

  Pagination({required this.total, required this.limit, required this.offset});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return _$PaginationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaginationToJson(this);
  }
}

@JsonSerializable()
class Meta {
  final Pagination pagination;
  Meta({required this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return _$MetaFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetaToJson(this);
  }
}