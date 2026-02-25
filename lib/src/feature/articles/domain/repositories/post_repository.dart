import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/patch_post_payload.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_page.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/create_post_payload.dart';

/// 게시글 조회 저장소 인터페이스입니다.
abstract class PostRepository {
  /// 게시글 목록을 조회합니다.
  Future<PostPage> getPosts({
    int page = 0,
    int size = 20,
    String? status,
  });

  /// 게시글을 생성합니다.
  Future<Post> createPost({
    required CreatePostPayload payload,
  });

  /// 게시글 상세를 조회합니다.
  Future<Post> getPost({
    required String postId,
  });

  /// 게시글 일부를 수정합니다.
  Future<Post> patchPost({
    required String postId,
    required PatchPostPayload payload,
  });

  /// 게시글을 삭제합니다.
  Future<void> deletePost({
    required String postId,
  });

  /// 임시저장 게시글 목록을 조회합니다.
  Future<PostPage> getDraftPosts({
    int page = 0,
    int size = 20,
  });
}
