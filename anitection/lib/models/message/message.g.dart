// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageAttributes _$MessageAttributesFromJson(Map<String, dynamic> json) =>
    MessageAttributes(
      content: json['content'] as String,
      institution: json['institution'] == null
          ? null
          : SingleData<Model<InstitutionAttributes>>.fromJson(
              json['institution'] as Map<String, dynamic>,
              (value) => Model<InstitutionAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) => InstitutionAttributes.fromJson(
                      value as Map<String, dynamic>))),
      user: json['user'] == null
          ? null
          : SingleData<Model<UserAttributes>>.fromJson(
              json['user'] as Map<String, dynamic>,
              (value) => Model<UserAttributes>.fromJson(
                  value as Map<String, dynamic>,
                  (value) =>
                      UserAttributes.fromJson(value as Map<String, dynamic>))),
    );

Map<String, dynamic> _$MessageAttributesToJson(MessageAttributes instance) =>
    <String, dynamic>{
      'content': instance.content,
      'institution': instance.institution?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
      'user': instance.user?.toJson(
        (value) => value.toJson(
          (value) => value,
        ),
      ),
    };
