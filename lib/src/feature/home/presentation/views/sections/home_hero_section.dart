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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final stacked = width < 1024;
    final horizontal = width >= 1200 ? 48.0 : 24.0;
    final isRecruiting = ref.watch(applyViewProvider);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Padding(
          padding: EdgeInsets.fromLTRB(horizontal, 56, horizontal, 64),
          child: Flex(
            direction: stacked ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment:
                stacked ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 11,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: HomeTheme.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: HomeTheme.primary.withValues(alpha: 0.20),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: HomeTheme.primary,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'DEVELOPER CLUB',
                            style: TextStyle(
                              color: HomeTheme.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    HomeTypingTitle(
                      fontSize: width < 680 ? 42 : 62,
                      onCompleted: () {
                        if (_showDescription) return;
                        setState(() => _showDescription = true);
                      },
                    ),
                    const SizedBox(height: 12),
                    AnimatedOpacity(
                      opacity: _showDescription ? 1 : 0,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                      child: const Text(
                        'A&I는 개발을 좋아하는 사람들이 모여 스터디, 프로젝트, 코드 리뷰를 함께 진행하는 실전형 개발 동아리입니다.',
                        style: TextStyle(
                          color: HomeTheme.textMuted,
                          fontSize: 17,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
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
                ),
              ),
              SizedBox(width: stacked ? 0 : 36, height: stacked ? 28 : 0),
              const HomeLogo(),
            ],
          ),
        ),
      ),
    );
  }
}
