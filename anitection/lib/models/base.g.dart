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
