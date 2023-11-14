// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaAttributes _$MediaAttributesFromJson(Map<String, dynamic> json) =>
    MediaAttributes(
      name: json['name'] as String?,
      alternativeText: json['alternativeText'] as String?,
      caption: json['caption'] as String?,
      width: json['width'] as int,
      height: json['height'] as int,
      hash: json['hash'] as String?,
      ext: json['ext'] as String?,
      mime: json['mime'] as String?,
      url: json['url'] as String?,
      previewUrl: json['previewUrl'] as String?,
      provider: json['provider'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MediaAttributesToJson(MediaAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'alternativeText': instance.alternativeText,
      'caption': instance.caption,
      'width': instance.width,
      'height': instance.height,
      'hash': instance.hash,
      'ext': instance.ext,
      'mime': instance.mime,
      'url': instance.url,
      'previewUrl': instance.previewUrl,
      'provider': instance.provider,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
