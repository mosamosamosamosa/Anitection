
import 'package:anitection/models/base.dart';
import 'package:anitection/models/institution/institution.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class MessageAttributes {
  final String content;
  final SingleData<Model<InstitutionAttributes>>? institution;

  MessageAttributes({
    required this.content,
    required this.institution,
  });

  factory MessageAttributes.fromJson(Map<String, dynamic> json) {
    return _$MessageAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MessageAttributesToJson(this);
  }
}