import 'package:a_and_i_report_web_server/src/core/models/user.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_model.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_state.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/create_post_payload.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/patch_post_payload.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_author.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_page.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/post_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/providers/article_post_providers.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/ui/viewModels/article_write_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('ArticleWriteViewModel', () {
    test('임시저장은 썸네일 없이도 성공한다', () async {
      final fakeRepository = FakePostRepository();
      final container = ProviderContainer(
        overrides: [
          userViewModelProvider.overrideWith(FakeUserViewModel.new),
          postRepositoryProvider.overrideWithValue(fakeRepository),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(articleWriteViewModelProvider.notifier);
      final result = await notifier.saveDraft(
        title: '임시 제목',
        contentMarkdown: '임시 본문',
      );

      expect(result, isTrue);
      expect(fakeRepository.createCallCount, 1);
      expect(fakeRepository.lastCreatePayload?.status, 'Draft');
      expect(fakeRepository.lastCreatePayload?.imageFileName, isNull);
      expect(fakeRepository.lastCreatePayload?.imageBytes, isNull);
      expect(container.read(articleWriteViewModelProvider).errorMsg, isEmpty);
    });

    test('출간은 썸네일이 없으면 실패한다', () async {
      final fakeRepository = FakePostRepository();
      final container = ProviderContainer(
        overrides: [
          userViewModelProvider.overrideWith(FakeUserViewModel.new),
          postRepositoryProvider.overrideWithValue(fakeRepository),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(articleWriteViewModelProvider.notifier);
      final result = await notifier.publish(
        title: '출간 제목',
        contentMarkdown: '출간 본문',
      );

      expect(result, isFalse);
      expect(fakeRepository.createCallCount, 0);
      expect(
        container.read(articleWriteViewModelProvider).errorMsg,
        '썸네일 이미지를 선택해주세요.',
      );
    });
  });
}

class FakeUserViewModel extends UserViewModel {
  @override
  UserViewState build() {
    return const UserViewState(
      status: UserStatus.authenticated,
      user: User(
        id: 'user-1',
        nickname: '멘토',
        role: 'ORGANIZER',
      ),
    );
  }
}

class FakePostRepository implements PostRepository {
  int createCallCount = 0;
  CreatePostPayload? lastCreatePayload;

  @override
  Future<Post> createPost({required CreatePostPayload payload}) async {
    createCallCount += 1;
    lastCreatePayload = payload;
    return Post(
      id: 'post-1',
      title: payload.title,
      contentMarkdown: payload.contentMarkdown,
      thumbnailUrl: null,
      author: PostAuthor(
        id: payload.authorId,
        nickname: payload.authorNickname,
        profileImage: payload.authorProfileImageUrl,
      ),
      status: payload.status ?? 'Draft',
      createdAt: DateTime.parse('2026-01-01T00:00:00Z'),
      updatedAt: DateTime.parse('2026-01-01T00:00:00Z'),
    );
  }

  @override
  Future<void> deletePost({required String postId}) async {}

  @override
  Future<PostPage> getDraftPosts({int page = 0, int size = 20}) async {
    return const PostPage(
      items: <Post>[],
      page: 0,
      size: 20,
      totalElements: 0,
      totalPages: 0,
    );
  }

  @override
  Future<Post> getPost({required String postId}) async {
    throw UnimplementedError();
  }

  @override
  Future<PostPage> getPosts(
      {int page = 0, int size = 20, String? status}) async {
    return const PostPage(
      items: <Post>[],
      page: 0,
      size: 20,
      totalElements: 0,
      totalPages: 0,
    );
  }

  @override
  Future<Post> patchPost({
    required String postId,
    required PatchPostPayload payload,
  }) async {
    throw UnimplementedError();
  }
}
