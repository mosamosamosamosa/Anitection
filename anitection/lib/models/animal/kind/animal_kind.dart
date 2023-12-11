
import 'package:json_annotation/json_annotation.dart';

part 'animal_kind.g.dart';

@JsonSerializable()
class AnimalKind {
  String name;
  AnimalKind({required this.name});

  factory AnimalKind.fromJson(Map<String, dynamic> json) => _$AnimalKindFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalKindToJson(this);
}
