import 'package:a_and_i_report_web_server/src/core/widgets/logo.dart';
import 'package:a_and_i_report_web_server/src/core/widgets/logo_image.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';

class HomeTopBarSection extends StatelessWidget {
  const HomeTopBarSection({
    super.key,
    required this.nickname,
    required this.isLoggedIn,
    required this.onGoIntro,
    required this.onGoEducation,
    required this.onGoPosts,
    required this.onLogin,
    required this.onLogout,
  });

  final String nickname;
  final bool isLoggedIn;
  final VoidCallback onGoIntro;
  final VoidCallback onGoEducation;
  final VoidCallback onGoPosts;
  final VoidCallback onLogin;
  final Future<void> Function() onLogout;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 860;
    final horizontal = width >= 1200 ? 48.0 : 24.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: SizedBox(
            height: 80,
            child: Row(
              children: [
                const LogoImage(
                  width: 50,
                ),
                if (!isMobile) ...[
                  const Spacer(),
                  HomeTopBarNavButton(text: '동아리 소개', onTap: onGoIntro),
                  const SizedBox(width: 18),
                  HomeTopBarNavButton(text: '스터디', onTap: onGoEducation),
                  const SizedBox(width: 18),
                  HomeTopBarNavButton(text: '프로젝트', onTap: onGoPosts),
                  const Spacer(),
                ] else
                  const Spacer(),
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: HomeTheme.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Icon(Icons.person,
                          color: HomeTheme.primary, size: 18),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      nickname,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: HomeTheme.textMain,
                      ),
                    ),
                    const SizedBox(width: 12),
                    isLoggedIn
                        ? OutlinedButton.icon(
                            onPressed: onLogout,
                            icon: const Icon(Icons.logout, size: 14),
                            label: const Text('로그아웃'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: HomeTheme.textMain,
                              side: BorderSide(
                                color: Colors.black.withValues(alpha: 0.08),
                              ),
                              backgroundColor:
                                  Colors.black.withValues(alpha: 0.03),
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 9,
                              ),
                            ),
                          )
                        : FilledButton(
                            onPressed: onLogin,
                            style: FilledButton.styleFrom(
                              backgroundColor: HomeTheme.primary,
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 9,
                              ),
                            ),
                            child: const Text('로그인'),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTopBarNavButton extends StatelessWidget {
  const HomeTopBarNavButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: HomeTheme.textMuted,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
