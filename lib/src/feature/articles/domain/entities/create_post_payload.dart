import 'dart:typed_data';

/// 게시글 생성 요청 페이로드입니다.
class CreatePostPayload {
  /// 게시글 생성 요청 페이로드를 생성합니다.
  const CreatePostPayload({
    required this.title,
    required this.contentMarkdown,
    required this.authorId,
    this.status,
    this.imageFileName,
    this.imageBytes,
  });

  /// 게시글 제목입니다.
  final String title;

  /// 게시글 본문(Markdown)입니다.
  final String contentMarkdown;

  /// 작성자 ID(UUID)입니다.
  final String authorId;

  /// 게시글 상태입니다. (예: Draft, Published, Deleted)
  final String? status;

  /// 첨부 이미지 파일명입니다.
  final String? imageFileName;

  /// 첨부 이미지 바이트입니다.
  final Uint8List? imageBytes;
}
