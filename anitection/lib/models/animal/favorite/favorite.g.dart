// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteAttributes _$FavoriteAttributesFromJson(Map<String, dynamic> json) =>
    FavoriteAttributes(
      animal: SingleData<Model<AnimalAttributes>?>.fromJson(
          json['animal'] as Map<String, dynamic>,
          (value) => value == null
              ? null
              : Model<AnimalAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) => AnimalAttributes.fromJson(
                      value as Map<String, dynamic>))),
    );

Map<String, dynamic> _$FavoriteAttributesToJson(FavoriteAttributes instance) =>
    <String, dynamic>{
      'animal': instance.animal.toJson(
        (value) => value?.toJson(
          (value) => value,
        ),
      ),
    };
