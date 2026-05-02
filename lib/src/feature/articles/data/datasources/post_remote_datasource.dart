import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/post_author_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/post_list_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/post_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_author.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_type.dart';
import 'package:aandi_tech_blog/aandi_tech_blog.dart' as blog_api;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 게시글 원격 데이터소스입니다.
abstract class PostRemoteDatasource {
  /// 서버에서 게시글 목록을 조회합니다.
  Future<PostListResponseDto> getPosts(
    String? authorization,
    int page,
    int size,
    PostType? type,
    String? status,
  );

  /// 서버에 게시글을 생성합니다.
  Future<PostResponseDto> createPost(
    String authorization,
    String title,
    String contentMarkdown,
    PostType type,
    String? summary,
    String authorId,
    String authorNickname,
    String? authorProfileImageUrl,
    String? status,
    DateTime? scheduledPublishAt,
    List<PostAuthor> collaborators,
    MultipartFile? thumbnail,
  );

  /// 서버에서 게시글 상세를 조회합니다.
  Future<PostResponseDto> getPost(
    String? authorization,
    String postId,
    PostType? type,
  );

  /// 서버의 게시글을 일부 수정합니다.
  Future<PostResponseDto> patchPost(
    String authorization,
    String postId,
    PostType? type,
    String? title,
    String? contentMarkdown,
    String? summary,
    String? status,
    DateTime? scheduledPublishAt,
    List<PostAuthor> collaborators,
    MultipartFile? thumbnail,
  );

  /// 서버에서 게시글을 삭제합니다.
  Future<void> deletePost(String authorization, String postId);

  /// 서버에서 임시저장 게시글 목록을 조회합니다.
  Future<PostListResponseDto> getDraftPosts(
    String authorization,
    int page,
    int size,
    PostType? type,
  );
}

/// 게시글 원격 데이터소스 구현체입니다.
class PostRemoteDatasourceImpl implements PostRemoteDatasource {
  /// 게시글 원격 데이터소스 구현체를 생성합니다.
  PostRemoteDatasourceImpl(this.dio)
      : _client = blog_api.TechBlogApiClient(
          baseUrl: dio.options.baseUrl,
          dio: dio,
          deviceOs: _resolveDeviceOs(),
        );

  /// HTTP 클라이언트입니다.
  final Dio dio;
  final blog_api.TechBlogApiClient _client;

  @override
  Future<PostListResponseDto> getPosts(
    String? authorization,
    int page,
    int size,
    PostType? type,
    String? status,
  ) async {
    final normalizedAuthorization = authorization?.trim();
    final resolvedType = _requireType(type);
    final response = normalizedAuthorization == null ||
            normalizedAuthorization.isEmpty
        ? await _listPublicPostsByType(
            type: resolvedType,
            page: page,
            size: size,
            status:
                status == null || status.isEmpty ? null : _toBlogStatus(status),
          )
        : await _listPostsByType(
            accessToken: _extractAccessToken(normalizedAuthorization),
            type: resolvedType,
            page: page,
            size: size,
            status:
                status == null || status.isEmpty ? null : _toBlogStatus(status),
          );
    return _toPostListResponseDto(response, type);
  }

  @override
  Future<PostResponseDto> createPost(
    String authorization,
    String title,
    String contentMarkdown,
    PostType type,
    String? summary,
    String authorId,
    String authorNickname,
    String? authorProfileImageUrl,
    String? status,
    DateTime? scheduledPublishAt,
    List<PostAuthor> collaborators,
    MultipartFile? thumbnail,
  ) async {
    final response = await _client.createPostV2(
      accessToken: _extractAccessToken(authorization),
      post: blog_api.CreatePostRequest(
        title: title,
        author: blog_api.PostAuthor(
          id: authorId,
          nickname: authorNickname,
          profileImageUrl: authorProfileImageUrl,
        ),
        summary: summary,
        contentMarkdown: contentMarkdown,
        collaborators: collaborators.map(_toBlogAuthor).toList(),
        type: _toBlogType(type),
        status: status == null || status.isEmpty ? null : _toBlogStatus(status),
        scheduledPublishAt: scheduledPublishAt,
      ),
      thumbnail: thumbnail,
    );
    return _toPostResponseDto(response);
  }

  @override
  Future<PostResponseDto> getPost(
    String? authorization,
    String postId,
    PostType? type,
  ) async {
    final normalizedAuthorization = authorization?.trim();
    final resolvedType = _requireType(type);
    final response =
        normalizedAuthorization == null || normalizedAuthorization.isEmpty
            ? await _getPublicPostByType(
                postId: postId,
                type: resolvedType,
              )
            : await _getPostByType(
                accessToken: _extractAccessToken(normalizedAuthorization),
                postId: postId,
                type: resolvedType,
              );
    return _toPostResponseDto(response);
  }

  @override
  Future<PostResponseDto> patchPost(
    String authorization,
    String postId,
    PostType? type,
    String? title,
    String? contentMarkdown,
    String? summary,
    String? status,
    DateTime? scheduledPublishAt,
    List<PostAuthor> collaborators,
    MultipartFile? thumbnail,
  ) async {
    final response = await _client.patchPostV2(
      postId: postId,
      accessToken: _extractAccessToken(authorization),
      post: blog_api.PatchPostRequest(
        title: title,
        summary: summary,
        contentMarkdown: contentMarkdown,
        collaborators: collaborators.isEmpty
            ? null
            : collaborators.map(_toBlogAuthor).toList(),
        type: _toBlogType(type),
        status: status == null || status.isEmpty ? null : _toBlogStatus(status),
        scheduledPublishAt: scheduledPublishAt,
      ),
      thumbnail: thumbnail,
    );
    return _toPostResponseDto(response);
  }

  @override
  Future<void> deletePost(String authorization, String postId) async {
    await _client.deletePostV2(
      postId: postId,
      accessToken: _extractAccessToken(authorization),
    );
  }

  @override
  Future<PostListResponseDto> getDraftPosts(
    String authorization,
    int page,
    int size,
    PostType? type,
  ) async {
    final response = await _listMyDraftPostsByType(
      accessToken: _extractAccessToken(authorization),
      type: _requireType(type),
      page: page,
      size: size,
    );
    return _toPostListResponseDto(response, type);
  }

  Future<blog_api.PagedPostResponse> _listPublicPostsByType({
    required PostType type,
    required int page,
    required int size,
    required blog_api.PostStatus? status,
  }) {
    return switch (type) {
      PostType.blog => _client.listBlogs(
          page: page,
          size: size,
          status: status,
        ),
      PostType.lecture => _client.listLectures(
          page: page,
          size: size,
          status: status,
        ),
    };
  }

  Future<blog_api.PagedPostResponse> _listPostsByType({
    required String accessToken,
    required PostType type,
    required int page,
    required int size,
    required blog_api.PostStatus? status,
  }) {
    return switch (type) {
      PostType.blog => _client.listBlogs(
          accessToken: accessToken,
          page: page,
          size: size,
          status: status,
        ),
      PostType.lecture => _client.listLectures(
          accessToken: accessToken,
          page: page,
          size: size,
          status: status,
        ),
    };
  }

  Future<blog_api.PostResponse> _getPublicPostByType({
    required String postId,
    required PostType type,
  }) {
    return switch (type) {
      PostType.blog => _client.getBlog(postId: postId),
      PostType.lecture => _client.getLecture(postId: postId),
    };
  }

  Future<blog_api.PostResponse> _getPostByType({
    required String accessToken,
    required String postId,
    required PostType type,
  }) {
    return switch (type) {
      PostType.blog => _client.getBlog(
          postId: postId,
          accessToken: accessToken,
        ),
      PostType.lecture => _client.getLecture(
          postId: postId,
          accessToken: accessToken,
        ),
    };
  }

  Future<blog_api.PagedPostResponse> _listMyDraftPostsByType({
    required String accessToken,
    required PostType type,
    required int page,
    required int size,
  }) {
    return switch (type) {
      PostType.blog => _client.listMyBlogDrafts(
          accessToken: accessToken,
          page: page,
          size: size,
        ),
      PostType.lecture => _client.listMyLectureDrafts(
          accessToken: accessToken,
          page: page,
          size: size,
        ),
    };
  }

  PostType _requireType(PostType? type) {
    if (type == null) {
      throw ArgumentError(
          'PostType is required because /v2/posts 조회 API는 deprecated 되었습니다.');
    }
    return type;
  }

  PostListResponseDto _toPostListResponseDto(
    blog_api.PagedPostResponse page,
    PostType? requestedType,
  ) {
    final filteredItems = page.items.where((post) {
      final type = post.type ?? blog_api.PostType.blog;
      return _matchesRequestedType(type, requestedType);
    }).toList();
    return PostListResponseDto(
      items: filteredItems.map(_toPostResponseDto).toList(),
      page: page.page,
      size: page.size,
      totalElements: filteredItems.length == page.items.length
          ? page.totalElements
          : filteredItems.length,
      totalPages: page.totalPages,
    );
  }

  PostResponseDto _toPostResponseDto(blog_api.PostResponse post) {
    return PostResponseDto(
      id: post.id,
      type: (post.type ?? blog_api.PostType.blog).toApi(),
      title: post.title,
      contentMarkdown: post.contentMarkdown ?? '',
      summary: post.summary,
      thumbnailUrl: post.thumbnailUrl,
      author: _toPostAuthorResponseDto(post.author),
      collaborators: post.collaborators.map(_toPostAuthorResponseDto).toList(),
      status: post.status.toApi(),
      scheduledPublishAt: post.scheduledPublishAt,
      publishedAt: post.publishedAt,
      createdAt: post.createdAt ?? DateTime.now(),
      updatedAt: post.updatedAt ?? DateTime.now(),
    );
  }

  PostAuthorResponseDto _toPostAuthorResponseDto(blog_api.PostAuthor author) {
    return PostAuthorResponseDto(
      id: author.id,
      nickname: author.nickname ?? '',
      profileImage: author.profileImageUrl,
    );
  }

  blog_api.PostAuthor _toBlogAuthor(PostAuthor author) {
    return blog_api.PostAuthor(
      id: author.id,
      nickname: author.nickname,
      profileImageUrl: author.profileImage,
    );
  }

  blog_api.PostType? _toBlogType(PostType? type) {
    return switch (type) {
      null => null,
      PostType.blog => blog_api.PostType.blog,
      PostType.lecture => blog_api.PostType.lecture,
    };
  }

  blog_api.PostStatus _toBlogStatus(String value) {
    return switch (value) {
      'Draft' => blog_api.PostStatus.draft,
      'Scheduled' => blog_api.PostStatus.scheduled,
      'Published' => blog_api.PostStatus.published,
      'Deleted' => blog_api.PostStatus.deleted,
      _ => blog_api.PostStatus.draft,
    };
  }

  String _extractAccessToken(String authorization) {
    final normalized = authorization.trim();
    if (normalized.toLowerCase().startsWith('bearer ')) {
      return normalized.substring(7).trim();
    }
    return normalized;
  }

  static String _resolveDeviceOs() {
    if (kIsWeb) {
      return 'web';
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      TargetPlatform.macOS => 'macos',
      TargetPlatform.windows => 'windows',
      TargetPlatform.linux => 'linux',
      TargetPlatform.fuchsia => 'fuchsia',
    };
  }

  bool _matchesRequestedType(blog_api.PostType type, PostType? requestedType) {
    return switch (requestedType) {
      null => true,
      PostType.blog => type == blog_api.PostType.blog,
      PostType.lecture => type == blog_api.PostType.lecture,
    };
  }
}
