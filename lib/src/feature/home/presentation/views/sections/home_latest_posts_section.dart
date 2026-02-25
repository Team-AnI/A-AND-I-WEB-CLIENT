import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/providers/article_post_providers.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 메인 화면 최신 블로그 게시글을 조회하는 Provider입니다.
final homeLatestPostsProvider = FutureProvider.autoDispose<List<Post>>((
  ref,
) async {
  final page =
      await ref.read(getPostListUsecaseProvider).call(page: 0, size: 20);
  return page.items.where((post) => _isPublished(post.status)).toList();
});

class HomeLatestPostsSection extends ConsumerWidget {
  const HomeLatestPostsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestPostsAsync = ref.watch(homeLatestPostsProvider);
    return latestPostsAsync.when(
      data: (posts) {
        final maxPostCount = kIsWeb ? 3 : 4;
        final visiblePosts = posts.take(maxPostCount).toList();
        if (visiblePosts.isEmpty) {
          return const SizedBox.shrink();
        }
        return _HomeLatestPostsSectionContent(posts: visiblePosts);
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _HomeLatestPostsSectionContent extends StatelessWidget {
  const _HomeLatestPostsSectionContent({
    required this.posts,
  });

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final horizontal = isMobile ? 20.0 : (isTablet ? 28.0 : 48.0);
    final titleFont = isMobile ? 28.0 : (isTablet ? 31.0 : 34.0);
    final subtitleFont = isMobile ? 14.0 : 15.0;
    final topPadding = isMobile ? 8.0 : 24.0;
    final bottomPadding = isMobile ? 44.0 : 64.0;
    final showHeaderRow = !isMobile;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              horizontal, topPadding, horizontal, bottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHeaderRow)
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '동아리 소식',
                            style: TextStyle(
                              fontSize: titleFont,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                              color: HomeTheme.textMain,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '학생 운영 스터디와 프로젝트 진행 소식을 확인해보세요.',
                            style: TextStyle(
                              fontSize: subtitleFont,
                              color: HomeTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => context.go('/articles'),
                      iconAlignment: IconAlignment.end,
                      label: const Text('전체 보기'),
                      icon: const Icon(Icons.chevron_right),
                      style: TextButton.styleFrom(
                        foregroundColor: HomeTheme.primary,
                        textStyle: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '동아리 소식',
                      style: TextStyle(
                        fontSize: titleFont,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: HomeTheme.textMain,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '학생 운영 스터디와 프로젝트 진행 소식을 확인해보세요.',
                      style: TextStyle(
                        fontSize: subtitleFont,
                        color: HomeTheme.textMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () => context.go('/articles'),
                      iconAlignment: IconAlignment.end,
                      label: const Text('전체 보기'),
                      icon: const Icon(Icons.chevron_right),
                      style: TextButton.styleFrom(
                        foregroundColor: HomeTheme.primary,
                        textStyle: const TextStyle(fontWeight: FontWeight.w700),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: isMobile ? 14 : 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
                  crossAxisSpacing: isMobile ? 14 : 18,
                  mainAxisSpacing: isMobile ? 14 : 18,
                  childAspectRatio: isMobile ? 1.18 : (isTablet ? 1.02 : 0.98),
                ),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return HomePostCard(
                    post: HomePostCardData(
                      category: _statusLabel(post.status),
                      date: _formatKoreanDate(post.updatedAt),
                      title: post.title,
                      summary: _extractSummary(post.contentMarkdown),
                      icon: _statusIcon(post.status),
                    ),
                    onTap: () => context.go('/articles/${post.id}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePostCard extends StatelessWidget {
  const HomePostCard({
    super.key,
    required this.post,
    required this.onTap,
  });

  final HomePostCardData post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final titleFont = isMobile ? 20.0 : (isTablet ? 20.0 : 21.0);
    final summaryFont = isMobile ? 13.0 : 14.0;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
              ),
              child: Center(
                child: Icon(post.icon,
                    size: isMobile ? 62 : 76,
                    color: Colors.black.withValues(alpha: 0.10)),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 10 : 12),
          Row(
            children: [
              Text(
                post.category,
                style: const TextStyle(
                  color: HomeTheme.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(width: 7),
              Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(width: 7),
              Text(
                post.date,
                style: const TextStyle(
                  color: HomeTheme.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            post.title,
            style: TextStyle(
              color: HomeTheme.textMain,
              fontSize: titleFont,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          SizedBox(height: isMobile ? 6 : 8),
          Text(
            post.summary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: HomeTheme.textMuted,
              fontSize: summaryFont,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePostCardData {
  const HomePostCardData({
    required this.category,
    required this.date,
    required this.title,
    required this.summary,
    required this.icon,
  });

  final String category;
  final String date;
  final String title;
  final String summary;
  final IconData icon;
}

bool _isPublished(String status) {
  return status.trim().toLowerCase() == 'published';
}

String _statusLabel(String status) {
  final normalized = status.trim();
  if (normalized.isEmpty) {
    return 'UNKNOWN';
  }
  return normalized.toUpperCase();
}

String _formatKoreanDate(DateTime dateTime) {
  final local = dateTime.toLocal();
  return '${local.year}년 ${local.month}월 ${local.day}일';
}

String _extractSummary(String markdown) {
  final plainText = markdown
      .replaceAll(RegExp(r'!\[[^\]]*\]\([^)]*\)'), ' ')
      .replaceAll(RegExp(r'\[[^\]]*\]\([^)]*\)'), ' ')
      .replaceAll(RegExp(r'[#>*`~_\-\[\]()]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  if (plainText.isEmpty) {
    return '본문 내용이 없습니다.';
  }

  const maxLength = 120;
  if (plainText.length <= maxLength) {
    return plainText;
  }

  return '${plainText.substring(0, maxLength)}...';
}

IconData _statusIcon(String status) {
  switch (status.toLowerCase()) {
    case 'published':
      return Icons.article;
    case 'draft':
      return Icons.edit_note;
    default:
      return Icons.description;
  }
}
