import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:a_and_i_report_web_server/src/feature/promotion/ui/viewModels/apply_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCtaSection extends ConsumerWidget {
  const HomeCtaSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecruiting = ref.watch(applyViewProvider);
    if (!isRecruiting) {
      return const SizedBox.shrink();
    }

    final width = MediaQuery.of(context).size.width;
    final horizontal = width >= 1200 ? 48.0 : 24.0;
    final verticalLayout = width < 820;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Padding(
          padding: EdgeInsets.fromLTRB(horizontal, 0, horizontal, 72),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
            ),
            padding: const EdgeInsets.all(28),
            child: Flex(
              direction: verticalLayout ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: verticalLayout
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '이번 학기, 같이 개발할 팀원을 찾고 있나요?',
                        style: TextStyle(
                          color: HomeTheme.textMain,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '초심자도 환영합니다. 스터디부터 사이드 프로젝트까지, 함께 실력을 쌓을 수 있는 팀 문화를 경험해보세요.',
                        style: TextStyle(
                          color: HomeTheme.textMuted,
                          fontSize: 15,
                          height: 1.55,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width: verticalLayout ? 0 : 16,
                    height: verticalLayout ? 16 : 0),
                FilledButton.icon(
                  onPressed: _launchApplyForm,
                  icon: const Icon(Icons.school, size: 18),
                  style: FilledButton.styleFrom(
                    backgroundColor: HomeTheme.primary,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.w700),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 16),
                  ),
                  label: const Text('A&I 참여하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchApplyForm() async {
    final uri = Uri.parse(
      'https://docs.google.com/forms/d/e/1FAIpQLSdIXB0FxwJaQw6f-vpf5mYBxNMlJs2PII_0UQo31n3As2PgyA/viewform?usp=header',
    );
    await launchUrl(uri);
  }
}
