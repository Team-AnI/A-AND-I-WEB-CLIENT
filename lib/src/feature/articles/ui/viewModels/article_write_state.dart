import 'dart:typed_data';

import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_author.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_write_state.freezed.dart';

/// 블로그 작성/출간 플로우 상태입니다.
@freezed
sealed class ArticleWriteState with _$ArticleWriteState {
  /// 블로그 작성/출간 플로우 상태를 생성합니다.
  const factory ArticleWriteState({
    @Default('') String postId,
    @Default('') String editingPostStatus,
    @Default('') String title,
    @Default('') String contentMarkdown,
    @Default('') String summary,
    @Default(<String>[]) List<String> tags,
    @Default(<PostAuthor>[]) List<PostAuthor> collaborators,
    String? thumbnailUrl,
    Uint8List? thumbnailBytes,
    String? thumbnailFileName,
    @Default(false) bool isUploadingImage,
    @Default(false) bool isSubmitting,
    @Default('') String errorMsg,
    @Default('') String successMsg,
  }) = _ArticleWriteState;
}
