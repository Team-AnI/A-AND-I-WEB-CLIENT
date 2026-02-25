// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePostRequestDto _$CreatePostRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _CreatePostRequestDto(
      title: json['title'] as String,
      contentMarkdown: json['contentMarkdown'] as String,
      authorId: json['authorId'] as String,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CreatePostRequestDtoToJson(
        _CreatePostRequestDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'contentMarkdown': instance.contentMarkdown,
      'authorId': instance.authorId,
      'status': instance.status,
    };
