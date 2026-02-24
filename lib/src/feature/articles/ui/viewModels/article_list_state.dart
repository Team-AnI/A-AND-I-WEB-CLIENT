import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_list_state.freezed.dart';

/// 게시글 목록 화면 상태 모델입니다.
@freezed
sealed class ArticleListState with _$ArticleListState {
  /// 게시글 목록 화면 상태 모델을 생성합니다.
  const factory ArticleListState({
    @Default(<Post>[]) List<Post> items,
    @Default(0) int page,
    @Default(0) int size,
    @Default(0) int totalElements,
    @Default(0) int totalPages,
    @Default('') String errorMsg,
  }) = _ArticleListState;
}
