
import 'package:json_annotation/json_annotation.dart';

part 'institution.g.dart';

@JsonSerializable()
class InstitutionAttributes {

  InstitutionAttributes({
    this.name,
    this.address,
    this.phone,
    this.websiteUrl,
    this.description,
    this.needsUrl,
    this.createdAt,
    this.updatedAt,
  });

  final String? name;
  final String? address;
  final String? phone;
  @JsonKey(name: 'website_url') final String? websiteUrl;
  final String? description;
  @JsonKey(name: 'needs_url') final String? needsUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory InstitutionAttributes.fromJson(Map<String, dynamic> json) {
    return _$InstitutionAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InstitutionAttributesToJson(this);
  }
}