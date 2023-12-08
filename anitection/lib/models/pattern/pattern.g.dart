// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatternAttributes _$PatternAttributesFromJson(Map<String, dynamic> json) =>
    PatternAttributes(
      name: json['name'] as String,
      image: SingleData<Model<MediaAttributes>>.fromJson(
          json['image'] as Map<String, dynamic>,
          (value) => Model<MediaAttributes>.fromJson(
              value as Map<String, dynamic>,
              (value) =>
                  MediaAttributes.fromJson(value as Map<String, dynamic>))),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PatternAttributesToJson(PatternAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
