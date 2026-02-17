import 'package:a_and_i_report_web_server/src/core/widgets/logo.dart';
import 'package:a_and_i_report_web_server/src/core/widgets/logo_image.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';

class HomeFooterSection extends StatelessWidget {
  const HomeFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontal = width >= 1200 ? 48.0 : 24.0;

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
            padding: EdgeInsets.fromLTRB(horizontal, 32, horizontal, 40),
            child: Wrap(
              runSpacing: 18,
              spacing: 24,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                const LogoImage(
                  width: 50,
                ),
                const Wrap(
                  spacing: 16,
                  runSpacing: 10,
                  children: [
                    HomeFooterLink(text: '개인정보 처리방침'),
                    HomeFooterLink(text: '이용약관'),
                    HomeFooterLink(text: '문의하기'),
                  ],
                ),
                Text(
                  '© 2026 A&I. All rights reserved.',
                  style: TextStyle(
                    color: HomeTheme.textMuted.withValues(alpha: 0.7),
                    fontSize: 12,
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
