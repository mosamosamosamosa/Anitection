// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineAttributes _$TimelineAttributesFromJson(Map<String, dynamic> json) =>
    TimelineAttributes(
      content: json['content'] as String,
      images: json['images'] == null
          ? null
          : ArrayData<Model<MediaAttributes>>.fromJson(
              json['images'] as Map<String, dynamic>,
              (value) => Model<MediaAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) =>
                      MediaAttributes.fromJson(value as Map<String, dynamic>))),
      footprints: json['footprints'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      institution: json['institution'] == null
          ? null
          : SingleData<Model<InstitutionAttributes>>.fromJson(
              json['institution'] as Map<String, dynamic>,
              (value) => Model<InstitutionAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) => InstitutionAttributes.fromJson(
                      value as Map<String, dynamic>))),
    );

Map<String, dynamic> _$TimelineAttributesToJson(TimelineAttributes instance) =>
    <String, dynamic>{
      'content': instance.content,
      'images': instance.images?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
      'footprints': instance.footprints,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'institution': instance.institution?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
    };
