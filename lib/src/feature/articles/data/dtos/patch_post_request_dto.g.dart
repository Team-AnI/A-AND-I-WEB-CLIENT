// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_post_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatchPostRequestDto _$PatchPostRequestDtoFromJson(Map<String, dynamic> json) =>
    _PatchPostRequestDto(
      title: json['title'] as String?,
      contentMarkdown: json['contentMarkdown'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PatchPostRequestDtoToJson(
        _PatchPostRequestDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'contentMarkdown': instance.contentMarkdown,
      'status': instance.status,
    };
