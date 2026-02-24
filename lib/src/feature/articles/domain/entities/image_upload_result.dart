/// 이미지 업로드 결과 엔티티입니다.
class ImageUploadResult {
  /// 이미지 업로드 결과 엔티티를 생성합니다.
  const ImageUploadResult({
    required this.url,
    required this.key,
    required this.contentType,
    required this.size,
  });

  /// 공개 URL입니다.
  final String url;

  /// 스토리지 키입니다.
  final String key;

  /// 콘텐츠 타입입니다.
  final String contentType;

  /// 파일 크기(byte)입니다.
  final int size;
}
