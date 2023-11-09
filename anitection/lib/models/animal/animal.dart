import 'package:anitection/models/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'animal.g.dart';

@JsonSerializable()
class AnimalAttributes {
  AnimalAttributes({
    required this.name,
    required this.age,
    required this.gender,
    required this.personality,
    required this.interest,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  final String? name;
  final int? age;
  final String? gender;
  final String? personality;
  final String? interest;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final ArrayData<dynamic>? images;

  factory AnimalAttributes.fromJson(Map<String, dynamic> json) {
    return _$AnimalAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AnimalAttributesToJson(this);
  }

}