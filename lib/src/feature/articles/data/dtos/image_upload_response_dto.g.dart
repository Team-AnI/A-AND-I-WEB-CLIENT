// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_upload_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageUploadResponseDto _$ImageUploadResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _ImageUploadResponseDto(
      url: json['url'] as String,
      key: json['key'] as String,
      contentType: json['contentType'] as String,
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$ImageUploadResponseDtoToJson(
        _ImageUploadResponseDto instance) =>
    <String, dynamic>{
      'url': instance.url,
      'key': instance.key,
      'contentType': instance.contentType,
      'size': instance.size,
    };
