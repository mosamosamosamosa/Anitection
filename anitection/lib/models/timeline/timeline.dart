
import 'package:anitection/models/base.dart';
import 'package:anitection/models/institution/institution.dart';
import 'package:anitection/models/media/media.dart';
import 'package:json_annotation/json_annotation.dart';
part 'timeline.g.dart';

@JsonSerializable()
class TimelineAttributes {
  final String content;
  final ArrayData<Model<MediaAttributes>>? images;
  final int footprints;
  // final SingleData<Model<User>?>? user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SingleData<Model<InstitutionAttributes>>? institution;

  TimelineAttributes({
    required this.content,
    required this.images,
    required this.footprints,
    // required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.institution,
  });

  factory TimelineAttributes.fromJson(Map<String, dynamic> json) =>
      _$TimelineAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$TimelineAttributesToJson(this);

}