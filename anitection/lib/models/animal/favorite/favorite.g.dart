// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteAttributes _$FavoriteAttributesFromJson(Map<String, dynamic> json) =>
    FavoriteAttributes(
      animals: ArrayData<Model<AnimalAttributes>>.fromJson(
          json['animals'] as Map<String, dynamic>,
          (value) => Model<AnimalAttributes>.fromJson(
              value as Map<String, dynamic>,
              (value) =>
                  AnimalAttributes.fromJson(value as Map<String, dynamic>))),
    );

Map<String, dynamic> _$FavoriteAttributesToJson(FavoriteAttributes instance) =>
    <String, dynamic>{
      'animals': instance.animals.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
    };
