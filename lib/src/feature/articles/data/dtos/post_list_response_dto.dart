import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/post_response_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_list_response_dto.freezed.dart';
part 'post_list_response_dto.g.dart';

/// 게시글 목록 응답 DTO입니다.
@freezed
sealed class PostListResponseDto with _$PostListResponseDto {
  /// 게시글 목록 응답 DTO를 생성합니다.
  const factory PostListResponseDto({
    @Default(<PostResponseDto>[]) List<PostResponseDto> items,
    @Default(0) int page,
    @Default(0) int size,
    @Default(0) int totalElements,
    @Default(0) int totalPages,
  }) = _PostListResponseDto;

  /// JSON으로부터 DTO를 생성합니다.
  factory PostListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PostListResponseDtoFromJson(json);
}
