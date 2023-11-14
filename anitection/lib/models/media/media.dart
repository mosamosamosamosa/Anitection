
import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class MediaAttributes {
  final String? name;
  final String? alternativeText;
  final String? caption;
  final int width;
  final int height;
  final String? hash;
  final String? ext;
  final String? mime;
  final String? url;
  final String? previewUrl;
  final String? provider;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MediaAttributes({
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MediaAttributes.fromJson(Map<String, dynamic> json) {
    return _$MediaAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MediaAttributesToJson(this);
  }

}