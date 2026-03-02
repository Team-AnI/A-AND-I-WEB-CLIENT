import 'package:a_and_i_report_web_server/src/core/providers/dio_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/datasources/image_remote_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/datasources/post_remote_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/repositories/image_repository_impl.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/repositories/post_repository_impl.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_page.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/providers/local_auth_datasource_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/image_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/post_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/usecases/get_my_draft_posts_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/usecases/get_post_list_usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 게시글 원격 데이터소스 Provider입니다.
final postRemoteDatasourceProvider = Provider<PostRemoteDatasource>((ref) {
  return PostRemoteDatasourceImpl(ref.read(dioProvider));
});

/// 이미지 원격 데이터소스 Provider입니다.
final imageRemoteDatasourceProvider = Provider<ImageRemoteDatasource>((ref) {
  return ImageRemoteDatasourceImpl(ref.read(dioProvider));
});

/// 게시글 조회 저장소 Provider입니다.
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImpl(
    postRemoteDatasource: ref.read(postRemoteDatasourceProvider),
    localAuthDatasource: ref.read(localAuthDatasourceProvider),
  );
});

/// 이미지 업로드 저장소 Provider입니다.
final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  return ImageRepositoryImpl(
    imageRemoteDatasource: ref.read(imageRemoteDatasourceProvider),
    localAuthDatasource: ref.read(localAuthDatasourceProvider),
  );
});

/// 게시글 목록 조회 유스케이스 Provider입니다.
final getPostListUsecaseProvider = Provider<GetPostListUsecase>((ref) {
  return GetPostListUsecase(ref.read(postRepositoryProvider));
});

/// 내 임시저장 게시글 목록 조회 유스케이스 Provider입니다.
final getMyDraftPostsUsecaseProvider = Provider<GetMyDraftPostsUsecase>((ref) {
  return GetMyDraftPostsUsecase(ref.read(postRepositoryProvider));
});

/// 내 임시저장 게시글 목록 조회 Provider입니다.
final myDraftPostPageProvider = FutureProvider.autoDispose<PostPage>((ref) {
  return ref.read(getMyDraftPostsUsecaseProvider).call();
});
