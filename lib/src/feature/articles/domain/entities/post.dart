/// 블로그 게시글 요약 엔티티입니다.
class Post {
  /// 게시글 요약 엔티티를 생성합니다.
  const Post({
    required this.id,
    required this.title,
    required this.contentMarkdown,
    required this.authorId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 게시글 ID(UUID)입니다.
  final String id;

  /// 게시글 제목입니다.
  final String title;

  /// 게시글 본문(Markdown)입니다.
  final String contentMarkdown;

  /// 작성자 ID(UUID)입니다.
  final String authorId;

  /// 게시글 상태입니다. (예: Draft, Published)
  final String status;

  /// 생성 시각입니다.
  final DateTime createdAt;

  /// 수정 시각입니다.
  final DateTime updatedAt;
}
