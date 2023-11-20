// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstitutionAttributes _$InstitutionAttributesFromJson(
        Map<String, dynamic> json) =>
    InstitutionAttributes(
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      websiteUrl: json['website_url'] as String?,
      description: json['description'] as String?,
      needsUrl: json['needs_url'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$InstitutionAttributesToJson(
        InstitutionAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'website_url': instance.websiteUrl,
      'description': instance.description,
      'needs_url': instance.needsUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
