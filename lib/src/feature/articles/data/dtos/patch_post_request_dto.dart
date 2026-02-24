import 'package:freezed_annotation/freezed_annotation.dart';

part 'patch_post_request_dto.freezed.dart';
part 'patch_post_request_dto.g.dart';

/// 게시글 수정 요청 DTO입니다.
@freezed
sealed class PatchPostRequestDto with _$PatchPostRequestDto {
  /// 게시글 수정 요청 DTO를 생성합니다.
  const factory PatchPostRequestDto({
    String? title,
    String? contentMarkdown,
    String? status,
  }) = _PatchPostRequestDto;

  /// JSON으로부터 DTO를 생성합니다.
  factory PatchPostRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PatchPostRequestDtoFromJson(json);
}
