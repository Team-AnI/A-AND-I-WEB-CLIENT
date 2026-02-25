import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/providers/article_post_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 게시글 상세 화면에서 단건 게시글을 조회하는 Provider입니다.
final articleDetailViewModelProvider =
    FutureProvider.autoDispose.family<Post, String>((ref, postId) async {
  return ref.read(postRepositoryProvider).getPost(postId: postId);
});
