// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalAttributes _$AnimalAttributesFromJson(Map<String, dynamic> json) =>
    AnimalAttributes(
      name: json['name'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      personality: json['personality'] as String?,
      interest: json['interest'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      images: json['images'] == null
          ? null
          : ArrayData<Model<MediaAttributes>>.fromJson(
              json['images'] as Map<String, dynamic>,
              (value) => Model<MediaAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) =>
                      MediaAttributes.fromJson(value as Map<String, dynamic>))),
      realIcon: json['real_icon'] == null
          ? null
          : SingleData<Model<MediaAttributes>>.fromJson(
              json['real_icon'] as Map<String, dynamic>,
              (value) => Model<MediaAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) =>
                      MediaAttributes.fromJson(value as Map<String, dynamic>))),
      institution: json['institution'] == null
          ? null
          : SingleData<Model<InstitutionAttributes>>.fromJson(
              json['institution'] as Map<String, dynamic>,
              (value) => Model<InstitutionAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) => InstitutionAttributes.fromJson(
                      value as Map<String, dynamic>))),
    );

Map<String, dynamic> _$AnimalAttributesToJson(AnimalAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'personality': instance.personality,
      'interest': instance.interest,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'institution': instance.institution?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
      'images': instance.images?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
      'real_icon': instance.realIcon?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
    };
