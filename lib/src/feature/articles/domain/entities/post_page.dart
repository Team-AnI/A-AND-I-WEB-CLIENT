import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post.dart';

/// 게시글 목록 페이지 응답 엔티티입니다.
class PostPage {
  /// 게시글 목록 페이지 엔티티를 생성합니다.
  const PostPage({
    required this.items,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  /// 현재 페이지의 게시글 목록입니다.
  final List<Post> items;

  /// 현재 페이지 번호입니다.
  final int page;

  /// 페이지 크기입니다.
  final int size;

  /// 전체 게시글 수입니다.
  final int totalElements;

  /// 전체 페이지 수입니다.
  final int totalPages;
}
