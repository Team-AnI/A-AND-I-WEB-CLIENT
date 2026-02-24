import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_upload_response_dto.freezed.dart';
part 'image_upload_response_dto.g.dart';

/// 이미지 업로드 응답 DTO입니다.
@freezed
sealed class ImageUploadResponseDto with _$ImageUploadResponseDto {
  /// 이미지 업로드 응답 DTO를 생성합니다.
  const factory ImageUploadResponseDto({
    required String url,
    required String key,
    required String contentType,
    required int size,
  }) = _ImageUploadResponseDto;

  /// JSON으로부터 DTO를 생성합니다.
  factory ImageUploadResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ImageUploadResponseDtoFromJson(json);
}
