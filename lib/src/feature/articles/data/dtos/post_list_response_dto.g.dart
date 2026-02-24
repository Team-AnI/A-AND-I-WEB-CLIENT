// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostListResponseDto _$PostListResponseDtoFromJson(Map<String, dynamic> json) =>
    _PostListResponseDto(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => PostResponseDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PostResponseDto>[],
      page: (json['page'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PostListResponseDtoToJson(
        _PostListResponseDto instance) =>
    <String, dynamic>{
      'items': instance.items,
      'page': instance.page,
      'size': instance.size,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };
