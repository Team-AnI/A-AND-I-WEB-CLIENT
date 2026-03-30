import 'dart:typed_data';

/// 이미지 업로드 요청 페이로드입니다.
class ImageUploadPayload {
  /// 이미지 업로드 요청 페이로드를 생성합니다.
  const ImageUploadPayload({
    required this.fileName,
    required this.bytes,
  });

  /// 업로드할 파일명입니다.
  final String fileName;

  /// 업로드할 이미지 바이트입니다.
  final Uint8List bytes;
}
