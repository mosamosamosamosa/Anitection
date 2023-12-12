
import 'package:anitection/models/animal/kind/animal_kind.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/models/media/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pedigree.g.dart';

@JsonSerializable()
class PedigreeAttributes {
  PedigreeAttributes({
    required this.name,
    required this.image,
    required this.animalKind,
  });
  final String name;
  final SingleData<Model<MediaAttributes>>? image;
  @JsonKey(name: 'animal_kind') final SingleData<Model<AnimalKind>>? animalKind;

  factory PedigreeAttributes.fromJson(Map<String, dynamic> json) {
    return _$PedigreeAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PedigreeAttributesToJson(this);
  }
}