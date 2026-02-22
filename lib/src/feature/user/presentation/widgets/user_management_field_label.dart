import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';

/// 사용자 관리 화면의 입력 필드 라벨 위젯이다.
class UserManagementFieldLabel extends StatelessWidget {
  const UserManagementFieldLabel({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
        color: HomeTheme.textMuted,
      ),
    );
  }
}
