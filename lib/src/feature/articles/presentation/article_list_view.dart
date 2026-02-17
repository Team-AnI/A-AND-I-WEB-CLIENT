import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/auth_event.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/auth_state.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/auth_view_model.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_event.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_model.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_state.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/sections/home_footer_section.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/sections/home_top_bar_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleListView extends ConsumerWidget {
  const ArticleListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authViewModelProvider).status ==
        AuthenticationStatus.authenticated;
    final userState = ref.watch(userViewModelProvider);
    final nickname = userState.nickname ?? '동아리원';
    final width = MediaQuery.of(context).size.width;
    final horizontal = width >= 1200 ? 48.0 : 24.0;

    return Scaffold(
      backgroundColor: HomeTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white.withValues(alpha: 0.92),
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            title: HomeTopBarSection(
              nickname: nickname,
              isLoggedIn: isLoggedIn,
              onGoIntro: () => context.go('/promotion'),
              onGoEducation: () => context.go('/report'),
              onGoPosts: () => context.go('/articles'),
              onLogin: () => context.go('/sign-in'),
              onLogout: () async {
                await ref
                    .read(authViewModelProvider.notifier)
                    .onEvent(const SignOut());
                await ref
                    .read(userViewModelProvider.notifier)
                    .onEvent(const UserViewEvent.clear());
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 960),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(horizontal, 64, horizontal, 72),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '게시글',
                        style: TextStyle(
                          fontSize: 46,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.1,
                          color: HomeTheme.textMain,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'A&I 커뮤니티의 최신 기술 동향, 연구 결과 및 활동 소식을 확인하세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.6,
                          color: HomeTheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 36),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: const [
                          _CategoryChip(text: '전체', selected: true),
                          _CategoryChip(text: '기술 블로그'),
                          _CategoryChip(text: '공지사항'),
                          _CategoryChip(text: '활동 후기'),
                        ],
                      ),
                      const SizedBox(height: 44),
                      const _ArticleCard(
                        category: 'ARCHITECTURE',
                        date: '2023년 10월 24일',
                        title: 'LLM 아키텍처 탐구: 효율적인 추론을 향한 진화',
                        summary:
                            '최신 대규모 언어 모델 구조와 효율적인 추론을 향한 진화 과정을 심도 있게 다룹니다.',
                        views: '1,240',
                        comments: '12',
                        icon: Icons.hub,
                      ),
                      const SizedBox(height: 24),
                      const _ArticleCard(
                        category: 'RESEARCH',
                        date: '2023년 10월 20일',
                        title: '신경망의 미래: 차세대 딥러닝 패러다임',
                        summary:
                            '프로덕션 환경에서 더욱 효율적이고 확장 가능한 신경망 아키텍처로의 전환을 분석합니다.',
                        views: '980',
                        comments: '8',
                        icon: Icons.data_object,
                      ),
                      const SizedBox(height: 24),
                      const _ArticleCard(
                        category: 'PRACTICES',
                        date: '2023년 10월 15일',
                        title: '데이터 과학 베스트 프랙티스: 안정적인 파이프라인 구축',
                        summary:
                            '고품질 데이터 파이프라인 유지 및 대규모 프로젝트의 재현성 확보를 위한 필수 전략입니다.',
                        views: '2,150',
                        comments: '24',
                        icon: Icons.storage,
                      ),
                      const SizedBox(height: 24),
                      const _ArticleCard(
                        category: 'COMMUNITY',
                        date: '2023년 10월 10일',
                        title: '2023 하계 해커톤 활동 후기',
                        summary:
                            '치열했던 48시간의 기록. A&I 멤버들이 함께 모여 실전 AI 문제를 해결했던 해커톤 현장을 공유합니다.',
                        views: '850',
                        comments: '15',
                        icon: Icons.groups,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: HomeFooterSection(),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.text,
    this.selected = false,
  });

  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: selected ? HomeTheme.textMain : Colors.black.withValues(alpha: 0.05),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : HomeTheme.textMuted,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({
    required this.category,
    required this.date,
    required this.title,
    required this.summary,
    required this.views,
    required this.comments,
    required this.icon,
  });

  final String category;
  final String date;
  final String title;
  final String summary;
  final String views;
  final String comments;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final stacked = width < 760;
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: HomeTheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                category,
                style: const TextStyle(
                  color: HomeTheme.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            Text(
              '•',
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.2),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              date,
              style: const TextStyle(
                color: HomeTheme.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: HomeTheme.textMain,
            fontSize: 27,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          summary,
          style: const TextStyle(
            color: HomeTheme.textMuted,
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.visibility, size: 16, color: HomeTheme.textMuted),
            const SizedBox(width: 4),
            Text(
              views,
              style: const TextStyle(
                color: HomeTheme.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.chat_bubble, size: 14, color: HomeTheme.textMuted),
            const SizedBox(width: 4),
            Text(
              comments,
              style: const TextStyle(
                color: HomeTheme.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Flex(
        direction: stacked ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: stacked ? double.infinity : 240,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 56,
                color: Colors.black.withValues(alpha: 0.14),
              ),
            ),
          ),
          SizedBox(width: stacked ? 0 : 24, height: stacked ? 16 : 0),
          if (stacked) content else Expanded(child: content),
        ],
      ),
    );
  }
}
