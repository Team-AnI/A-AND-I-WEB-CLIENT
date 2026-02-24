import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_request_dto.freezed.dart';
part 'create_post_request_dto.g.dart';

/// 게시글 생성 요청 DTO입니다.
@freezed
sealed class CreatePostRequestDto with _$CreatePostRequestDto {
  /// 게시글 생성 요청 DTO를 생성합니다.
  const factory CreatePostRequestDto({
    required String title,
    required String contentMarkdown,
    required String authorId,
    String? status,
  }) = _CreatePostRequestDto;

  /// JSON으로부터 DTO를 생성합니다.
  factory CreatePostRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePostRequestDtoFromJson(json);
}
