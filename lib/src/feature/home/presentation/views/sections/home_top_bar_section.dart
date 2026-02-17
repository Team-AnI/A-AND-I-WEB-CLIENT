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
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final horizontal = isMobile ? 20.0 : (isTablet ? 28.0 : 48.0);
    final barHeight = isMobile ? 72.0 : (isTablet ? 76.0 : 80.0);
    final logoWidth = isMobile ? 42.0 : (isTablet ? 46.0 : 50.0);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: SizedBox(
            height: barHeight,
            child: Row(
              children: [
                LogoImage(
                  width: logoWidth,
                ),
                if (!isMobile) ...[
                  const Spacer(),
                  HomeTopBarNavButton(text: '동아리 소개', onTap: onGoIntro),
                  const SizedBox(width: 18),
                  HomeTopBarNavButton(text: '스터디', onTap: onGoEducation),
                  const SizedBox(width: 18),
                  HomeTopBarNavButton(text: '블로그', onTap: onGoPosts),
                  const Spacer(),
                ] else
                  const Spacer(),
                Row(
                  children: [
                    if (isLoggedIn) ...[
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
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 13,
                          fontWeight: FontWeight.w600,
                          color: HomeTheme.textMain,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
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
                              textStyle: TextStyle(
                                fontSize: isMobile ? 11 : 12,
                                fontWeight: FontWeight.w700,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 10 : 12,
                                vertical: isMobile ? 8 : 9,
                              ),
                            ),
                          )
                        : FilledButton(
                            onPressed: onLogin,
                            style: FilledButton.styleFrom(
                              backgroundColor: HomeTheme.primary,
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontSize: isMobile ? 11 : 12,
                                fontWeight: FontWeight.w700,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 12 : 14,
                                vertical: isMobile ? 8 : 9,
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
    final width = MediaQuery.of(context).size.width;
    final isTablet = width >= 768 && width < 1200;
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: HomeTheme.textMuted,
          fontSize: isTablet ? 13 : 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
