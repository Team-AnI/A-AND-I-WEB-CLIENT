import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/login_ui_state.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/login_ui_view_model.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/views/login_view.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 로그인 화면의 컨테이너 위젯입니다.
///
/// [LoginUiViewModel]의 상태를 구독하여 화면을 구성합니다.
/// - [Idle]: 사용자 입력을 받을 수 있는 [LoginView]를 표시합니다.
/// - [Loading]: 로그인 처리 중임을 나타내는 로딩 인디케이터를 표시합니다.
class LoginUI extends ConsumerWidget {
  const LoginUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginUiViewModelProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Center(
        child: switch (state) {
          Idle() => const LoginView(),
          Loading() => const CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(HomeTheme.primary),
            ),
        },
      ),
    );
  }
}
