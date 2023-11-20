import 'package:anitection/models/base.dart';
import 'package:anitection/models/institution/institution.dart';
import 'package:anitection/models/media/media.dart';
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
    required this.realIcon,
    required this.institution,
  });

  final String? name;
  final int? age;
  final String? gender;
  final String? personality;
  final String? interest;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final SingleData<Model<InstitutionAttributes>>? institution;

  final ArrayData<Model<MediaAttributes>>? images;

  @JsonKey(name: 'real_icon') final SingleData<Model<MediaAttributes>>? realIcon;

  factory AnimalAttributes.fromJson(Map<String, dynamic> json) {
    return _$AnimalAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AnimalAttributesToJson(this);
  }

}