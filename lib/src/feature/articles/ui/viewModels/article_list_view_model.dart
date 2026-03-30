import 'package:a_and_i_report_web_server/src/feature/articles/providers/article_post_providers.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_type.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/ui/viewModels/article_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_list_view_model.g.dart';

/// 게시글 목록 화면 상태를 관리하는 ViewModel입니다.
@riverpod
class ArticleListViewModel extends _$ArticleListViewModel {
  final Map<String, Post> _recentPublishedOverrides = <String, Post>{};
  static const int _defaultPageSize = 20;
  late PostType _postType;

  /// 초기 목록 상태를 로드합니다.
  @override
  Future<ArticleListState> build(PostType postType) async {
    ref.keepAlive();
    _postType = postType;
    return _fetchPage(page: 0, size: _defaultPageSize);
  }

  /// 목록을 다시 불러옵니다.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(
      await _fetchPage(page: 0, size: _defaultPageSize),
    );
  }

  /// 다음 페이지를 불러와 현재 목록 뒤에 이어 붙입니다.
  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null ||
        current.errorMsg.isNotEmpty ||
        current.isLoadingMore ||
        !current.hasMore) {
      return;
    }

    final nextPage = current.page + 1;
    state = AsyncData(
      current.copyWith(
        isLoadingMore: true,
        loadMoreErrorMsg: '',
      ),
    );

    try {
      final response = await ref.read(getPostListUsecaseProvider).call(
            page: nextPage,
            size: current.size,
            type: _postType,
          );
      final mergedItems = _mergeWithRecentPublished(
        <Post>[
          ...current.items,
          ...response.items,
        ],
      );
      final totalElements = response.totalElements < mergedItems.length
          ? mergedItems.length
          : response.totalElements;

      state = AsyncData(
        current.copyWith(
          items: mergedItems,
          page: response.page,
          size: response.size,
          totalElements: totalElements,
          totalPages: _resolveTotalPages(
            size: response.size,
            totalElements: totalElements,
            fallback: response.totalPages,
          ),
          hasMore: _hasMore(
            page: response.page,
            totalPages: response.totalPages,
            totalElements: totalElements,
            loadedItemsCount: mergedItems.length,
          ),
          isLoadingMore: false,
          loadMoreErrorMsg: '',
          errorMsg: '',
        ),
      );
    } catch (e) {
      final latest = state.valueOrNull ?? current;
      state = AsyncData(
        latest.copyWith(
          isLoadingMore: false,
          loadMoreErrorMsg: e.toString(),
        ),
      );
    }
  }

  /// 출간된 게시글을 목록에 즉시 반영합니다.
  void upsertPublishedPost(Post post) {
    if (!_isPublished(post.status)) {
      return;
    }

    _recentPublishedOverrides[post.id] = post;

    final current = state.valueOrNull;
    if (current == null) {
      return;
    }

    final mergedItems = _mergeWithRecentPublished(current.items);
    final totalElements = current.totalElements < mergedItems.length
        ? mergedItems.length
        : current.totalElements;
    state = AsyncData(
      current.copyWith(
        items: mergedItems,
        totalElements: totalElements,
        totalPages: _resolveTotalPages(
          size: current.size,
          totalElements: totalElements,
          fallback: current.totalPages,
        ),
        hasMore: _hasMore(
          page: current.page,
          totalPages: current.totalPages,
          totalElements: totalElements,
          loadedItemsCount: mergedItems.length,
        ),
        errorMsg: '',
      ),
    );
  }

  Future<ArticleListState> _fetchPage({
    required int page,
    required int size,
  }) async {
    try {
      final response = await ref
          .read(getPostListUsecaseProvider)
          .call(page: page, size: size, type: _postType);
      final mergedItems = _mergeWithRecentPublished(response.items);
      final totalElements = response.totalElements < mergedItems.length
          ? mergedItems.length
          : response.totalElements;
      return ArticleListState(
        items: mergedItems,
        page: response.page,
        size: response.size,
        totalElements: totalElements,
        totalPages: _resolveTotalPages(
          size: response.size,
          totalElements: totalElements,
          fallback: response.totalPages,
        ),
        hasMore: _hasMore(
          page: response.page,
          totalPages: response.totalPages,
          totalElements: totalElements,
          loadedItemsCount: mergedItems.length,
        ),
      );
    } catch (e) {
      return ArticleListState(errorMsg: e.toString());
    }
  }

  List<Post> _mergeWithRecentPublished(List<Post> baseItems) {
    final mergedById = <String, Post>{
      for (final item in baseItems) item.id: item,
      ..._recentPublishedOverrides,
    };
    final merged = mergedById.values.toList()..sort(_compareByLatestFirst);
    return merged;
  }

  bool _isPublished(String status) {
    return status.trim().toLowerCase() == 'published';
  }

  int _compareByLatestFirst(Post a, Post b) {
    final createdCompare = b.createdAt.compareTo(a.createdAt);
    if (createdCompare != 0) {
      return createdCompare;
    }
    final updatedCompare = b.updatedAt.compareTo(a.updatedAt);
    if (updatedCompare != 0) {
      return updatedCompare;
    }
    return b.id.compareTo(a.id);
  }

  int _resolveTotalPages({
    required int size,
    required int totalElements,
    required int fallback,
  }) {
    if (size <= 0) {
      return fallback;
    }
    final calculated = (totalElements / size).ceil();
    if (calculated <= 0) {
      return fallback;
    }
    return calculated;
  }

  bool _hasMore({
    required int page,
    required int totalPages,
    required int totalElements,
    required int loadedItemsCount,
  }) {
    if (totalPages > 0) {
      return page + 1 < totalPages;
    }
    if (totalElements > 0) {
      return loadedItemsCount < totalElements;
    }
    return false;
  }
}
