// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedigree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PedigreeAttributes _$PedigreeAttributesFromJson(Map<String, dynamic> json) =>
    PedigreeAttributes(
      name: json['name'] as String,
      image: json['image'] == null
          ? null
          : SingleData<Model<MediaAttributes>>.fromJson(
              json['image'] as Map<String, dynamic>,
              (value) => Model<MediaAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) =>
                      MediaAttributes.fromJson(value as Map<String, dynamic>))),
      animalKind: json['animal_kind'] == null
          ? null
          : SingleData<Model<AnimalKind>?>.fromJson(
              json['animal_kind'] as Map<String, dynamic>,
              (value) => value == null
                  ? null
                  : Model<AnimalKind>.fromJson(
                      value as Map<String, dynamic>,
                      (value) =>
                          AnimalKind.fromJson(value as Map<String, dynamic>))),
    );

Map<String, dynamic> _$PedigreeAttributesToJson(PedigreeAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
      'animal_kind': instance.animalKind?.toJson(
        (value) => value?.toJson(
          (value) => value,
        ),
      ),
    };
