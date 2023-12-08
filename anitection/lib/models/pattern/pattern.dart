
import 'package:anitection/models/base.dart';
import 'package:anitection/models/media/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pattern.g.dart';

@JsonSerializable()
class PatternAttributes {
  PatternAttributes({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PatternAttributes.fromJson(Map<String, dynamic> json) =>
      _$PatternAttributesFromJson(json);

  final int id;
  final String name;
  final String description;
  final SingleData<Model<MediaAttributes>> image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => _$PatternAttributesToJson(this);
}