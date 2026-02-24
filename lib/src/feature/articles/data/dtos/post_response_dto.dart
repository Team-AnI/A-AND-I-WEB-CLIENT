import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_response_dto.freezed.dart';
part 'post_response_dto.g.dart';

/// 게시글 단건 응답 DTO입니다.
@freezed
sealed class PostResponseDto with _$PostResponseDto {
  /// 게시글 단건 응답 DTO를 생성합니다.
  const factory PostResponseDto({
    required String id,
    required String title,
    required String contentMarkdown,
    required String authorId,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PostResponseDto;

  /// JSON으로부터 DTO를 생성합니다.
  factory PostResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PostResponseDtoFromJson(json);
}
