
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class FavoriteAttributes {
  FavoriteAttributes({
    required this.animal,
  });
  final SingleData<Model<AnimalAttributes>?> animal;


  factory FavoriteAttributes.fromJson(Map<String, dynamic> json) {
    return _$FavoriteAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FavoriteAttributesToJson(this);
  }
}