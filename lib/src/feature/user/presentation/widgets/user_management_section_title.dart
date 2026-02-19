import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';

/// 사용자 관리 화면의 섹션 타이틀 위젯이다.
class UserManagementSectionTitle extends StatelessWidget {
  const UserManagementSectionTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.1,
          color: HomeTheme.textMuted,
        ),
      ),
    );
  }
}
