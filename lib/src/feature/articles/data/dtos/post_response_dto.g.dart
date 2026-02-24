// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostResponseDto _$PostResponseDtoFromJson(Map<String, dynamic> json) =>
    _PostResponseDto(
      id: json['id'] as String,
      title: json['title'] as String,
      contentMarkdown: json['contentMarkdown'] as String,
      authorId: json['authorId'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PostResponseDtoToJson(_PostResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contentMarkdown': instance.contentMarkdown,
      'authorId': instance.authorId,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
