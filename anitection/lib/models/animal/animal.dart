import 'package:anitection/models/animal/kind/animal_kind.dart';
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
    required this.animalKind,
    required this.hairLength,
    required this.size,
    required this.avatarIcon,
    required this.avatarBody,
    required this.avatarHead,
    required this.avatarTail,
  });

  final String? name;
  final int? age;
  final String? gender;
  final String? personality;
  final String? interest;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final SingleData<Model<InstitutionAttributes>?>? institution;

  final ArrayData<Model<MediaAttributes>>? images;

  @JsonKey(name: 'real_icon') final SingleData<Model<MediaAttributes>?>? realIcon;

  @JsonKey(name: 'animal_kind') final SingleData<Model<AnimalKind>>? animalKind;

  @JsonKey(name: 'avatar_icon') final SingleData<Model<MediaAttributes>?>? avatarIcon;

  @JsonKey(name: 'hair_length') final String? hairLength;

  @JsonKey(name: 'size') final String? size;

  @JsonKey(name: 'avatar_head') final SingleData<Model<MediaAttributes>?>? avatarHead;

  @JsonKey(name: 'avatar_body') final SingleData<Model<MediaAttributes>?>? avatarBody;

  @JsonKey(name: 'avatar_tail') final SingleData<Model<MediaAttributes>?>? avatarTail;


  factory AnimalAttributes.fromJson(Map<String, dynamic> json) {
    return _$AnimalAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AnimalAttributesToJson(this);
  }

}