import 'package:a_and_i_report_web_server/src/core/widgets/logo_image.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';

class HomeFooterSection extends StatelessWidget {
  const HomeFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final horizontal = isMobile ? 20.0 : (isTablet ? 28.0 : 48.0);
    final topPadding = isMobile ? 24.0 : 32.0;
    final bottomPadding = isMobile ? 30.0 : 40.0;
    final logoWidth = isMobile ? 40.0 : (isTablet ? 46.0 : 50.0);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC).withValues(alpha: 0.7),
        border: Border(
          top: BorderSide(color: Colors.black.withValues(alpha: 0.05)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                horizontal, topPadding, horizontal, bottomPadding),
            child: Wrap(
              runSpacing: isMobile ? 14 : 18,
              spacing: isMobile ? 18 : 24,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                LogoImage(
                  width: logoWidth,
                ),
                Text(
                  '© 2026 A&I. All rights reserved.',
                  style: TextStyle(
                    color: HomeTheme.textMuted.withValues(alpha: 0.7),
                    fontSize: isMobile ? 11 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeFooterLink extends StatelessWidget {
  const HomeFooterLink({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: HomeTheme.textMuted,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
      ),
    );
  }
}
