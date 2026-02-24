import 'package:a_and_i_report_web_server/src/feature/articles/providers/article_post_providers.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/ui/viewModels/article_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_list_view_model.g.dart';

/// 게시글 목록 화면 상태를 관리하는 ViewModel입니다.
@riverpod
class ArticleListViewModel extends _$ArticleListViewModel {
  /// 초기 목록 상태를 로드합니다.
  @override
  Future<ArticleListState> build() async {
    return _fetch();
  }

  /// 목록을 다시 불러옵니다.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _fetch());
  }

  Future<ArticleListState> _fetch({
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await ref
          .read(getPostListUsecaseProvider)
          .call(page: page, size: size);
      return ArticleListState(
        items: response.items,
        page: response.page,
        size: response.size,
        totalElements: response.totalElements,
        totalPages: response.totalPages,
      );
    } catch (e) {
      return ArticleListState(errorMsg: e.toString());
    }
  }
}
