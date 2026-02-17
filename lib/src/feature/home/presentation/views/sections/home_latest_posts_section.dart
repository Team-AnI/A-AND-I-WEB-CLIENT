import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';

class HomeLatestPostsSection extends StatelessWidget {
  const HomeLatestPostsSection({super.key});

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
          padding: EdgeInsets.fromLTRB(horizontal, topPadding, horizontal, bottomPadding),
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                itemCount: homePostCards.length,
                itemBuilder: (context, index) {
                  return HomePostCard(post: homePostCards[index]);
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
  });

  final HomePostCardData post;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final titleFont = isMobile ? 20.0 : (isTablet ? 20.0 : 21.0);
    final summaryFont = isMobile ? 13.0 : 14.0;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
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

const List<HomePostCardData> homePostCards = [
  HomePostCardData(
    category: 'Project',
    date: '2026년 2월 10일',
    title: '겨울방학 팀 프로젝트 회고',
    summary: '학생 팀이 직접 기획하고 개발한 웹 프로젝트의 아키텍처, 협업 방식, 배운 점을 공유합니다.',
    icon: Icons.groups,
  ),
  HomePostCardData(
    category: 'Study',
    date: '2026년 2월 6일',
    title: '알고리즘 스터디 4주차 기록',
    summary: '문제 풀이 전략부터 코드 리뷰 포인트까지, 스터디에서 실제로 다룬 내용을 정리했습니다.',
    icon: Icons.functions,
  ),
  HomePostCardData(
    category: 'Session',
    date: '2026년 1월 29일',
    title: '프론트엔드 실습 세션 안내',
    summary: 'Flutter와 웹 프론트엔드 기초를 함께 학습하는 실습 중심 세션 일정을 안내합니다.',
    icon: Icons.web,
  ),
];
