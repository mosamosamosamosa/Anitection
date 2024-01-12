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
      animalKind: json['animal_kind'] == null
          ? null
          : SingleData<Model<AnimalKind>>.fromJson(
              json['animal_kind'] as Map<String, dynamic>,
              (value) => Model<AnimalKind>.fromJson(
                  value as Map<String, dynamic>,
                  (value) =>
                      AnimalKind.fromJson(value as Map<String, dynamic>))),
      hairLength: json['hair_length'] as String?,
      size: json['size'] as String?,
      avatarIcon: json['avatar_icon'] == null
          ? null
          : SingleData<Model<MediaAttributes>>.fromJson(
              json['avatar_icon'] as Map<String, dynamic>,
              (value) => Model<MediaAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) =>
                      MediaAttributes.fromJson(value as Map<String, dynamic>))),
      avatarBody: json['avatar_body'] == null
          ? null
          : SingleData<Model<MediaAttributes>>.fromJson(
              json['avatar_body'] as Map<String, dynamic>,
              (value) => Model<MediaAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) =>
                      MediaAttributes.fromJson(value as Map<String, dynamic>))),
      avatarHead: json['avatar_head'] == null
          ? null
          : SingleData<Model<MediaAttributes>>.fromJson(
              json['avatar_head'] as Map<String, dynamic>,
              (value) => Model<MediaAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) =>
                      MediaAttributes.fromJson(value as Map<String, dynamic>))),
      avatarTail: json['avatar_tail'] == null
          ? null
          : SingleData<Model<MediaAttributes>>.fromJson(
              json['avatar_tail'] as Map<String, dynamic>,
              (value) => Model<MediaAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) =>
                      MediaAttributes.fromJson(value as Map<String, dynamic>))),
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
      'animal_kind': instance.animalKind?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
      'avatar_icon': instance.avatarIcon?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
      'hair_length': instance.hairLength,
      'size': instance.size,
      'avatar_head': instance.avatarHead?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
      'avatar_body': instance.avatarBody?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
      'avatar_tail': instance.avatarTail?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
    };
