import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/sections/home_logo.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/sections/home_typing_title.dart';
import 'package:a_and_i_report_web_server/src/feature/promotion/ui/viewModels/apply_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeHeroSection extends ConsumerStatefulWidget {
  const HomeHeroSection({super.key});

  @override
  ConsumerState<HomeHeroSection> createState() => _HomeHeroSectionState();
}

class _HomeHeroSectionState extends ConsumerState<HomeHeroSection> {
  bool _showDescription = false;
  bool _typingDone = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final stacked = width < 1100;
    final horizontal = isMobile ? 20.0 : (isTablet ? 28.0 : 48.0);
    final topPadding = isMobile ? 40.0 : (isTablet ? 50.0 : 56.0);
    final bottomPadding = isMobile ? 44.0 : (isTablet ? 54.0 : 64.0);
    final titleFont = isMobile ? 34.0 : (isTablet ? 48.0 : 62.0);
    final summaryFont = isMobile ? 15.0 : (isTablet ? 16.0 : 17.0);
    final isRecruiting = ref.watch(applyViewProvider);
    final heroTextContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: isMobile ? 24 : 40),
        _typingDone
            ? Text(
                '함께 만들고\n함께 성장하는\n개발 동아리',
                style: TextStyle(
                  fontSize: titleFont,
                  fontWeight: FontWeight.w800,
                  height: 1.08,
                  letterSpacing: -1.2,
                  color: HomeTheme.textMain,
                ),
              )
            : HomeTypingTitle(
                fontSize: titleFont,
                onCompleted: () {
                  if (_typingDone && _showDescription) return;
                  setState(() {
                    _typingDone = true;
                    _showDescription = true;
                  });
                },
              ),
        SizedBox(height: isMobile ? 8 : 12),
        AnimatedOpacity(
          opacity: _showDescription ? 1 : 0,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOut,
          child: Text(
            'A&I는 개발을 좋아하는 사람들이 모여 스터디, 프로젝트, 코드 리뷰를 함께 진행하는 실전형 개발 동아리입니다.',
            style: TextStyle(
              color: HomeTheme.textMuted,
              fontSize: summaryFont,
              height: 1.6,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 18 : 26),
        Wrap(
          spacing: isMobile ? 8 : 12,
          runSpacing: isMobile ? 8 : 12,
          children: [
            if (isRecruiting)
              IgnorePointer(
                ignoring: !_showDescription,
                child: AnimatedOpacity(
                  opacity: _showDescription ? 1 : 0,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  child: FilledButton.icon(
                    onPressed: () => context.go('/promotion'),
                    icon: const Icon(Icons.arrow_forward, size: 18),
                    style: FilledButton.styleFrom(
                      backgroundColor: HomeTheme.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 18 : 24,
                        vertical: isMobile ? 13 : 16,
                      ),
                      textStyle: TextStyle(
                        fontSize: isMobile ? 14 : 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    label: const Text('동아리 모집 공고'),
                  ),
                ),
              ),
          ],
        ),
      ],
    );

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              horizontal, topPadding, horizontal, bottomPadding),
          child: stacked
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile || isTablet) ...[
                      const HomeLogo(),
                      const SizedBox(height: 20),
                      heroTextContent,
                    ] else ...[
                      heroTextContent,
                      const SizedBox(height: 24),
                      const HomeLogo(),
                    ],
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 11, child: heroTextContent),
                    const SizedBox(width: 28),
                    const Expanded(flex: 9, child: HomeLogo()),
                  ],
                ),
        ),
      ),
    );
  }
}
