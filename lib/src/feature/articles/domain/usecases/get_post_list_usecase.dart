import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_page.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/post_repository.dart';

/// 게시글 목록 조회 유스케이스입니다.
class GetPostListUsecase {
  /// 게시글 목록 조회 유스케이스를 생성합니다.
  const GetPostListUsecase(this.postRepository);

  /// 게시글 저장소입니다.
  final PostRepository postRepository;

  /// 게시글 목록을 조회합니다.
  Future<PostPage> call({
    int page = 0,
    int size = 20,
  }) {
    return postRepository.getPosts(page: page, size: size);
  }
}
