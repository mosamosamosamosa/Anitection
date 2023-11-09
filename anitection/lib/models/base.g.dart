// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model<T> _$ModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Model<T>(
      id: json['id'] as int,
      attributes: fromJsonT(json['attributes']),
    );

Map<String, dynamic> _$ModelToJson<T>(
  Model<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': toJsonT(instance.attributes),
    };

SingleData<T> _$SingleDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    SingleData<T>(
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$SingleDataToJson<T>(
  SingleData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
    };

ArrayData<T> _$ArrayDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ArrayData<T>(
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ArrayDataToJson<T>(
  ArrayData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
    };
