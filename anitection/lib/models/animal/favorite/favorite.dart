
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class FavoriteAttributes {
  FavoriteAttributes({
    required this.animals,
  });
  final ArrayData<Model<AnimalAttributes>> animals;


  factory FavoriteAttributes.fromJson(Map<String, dynamic> json) {
    return _$FavoriteAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FavoriteAttributesToJson(this);
  }
}