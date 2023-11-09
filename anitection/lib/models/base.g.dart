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

PagingData<T> _$PagingDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PagingData<T>(
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PagingDataToJson<T>(
  PagingData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
      'meta': instance.meta,
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

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      pageCount: json['pageCount'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'pageCount': instance.pageCount,
      'total': instance.total,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'pagination': instance.pagination,
    };
