import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/login_ui_state.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/login_ui_view_model.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorMessageView extends ConsumerWidget {
  const ErrorMessageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMsg = ref.watch(loginUiViewModelProvider.select((state) {
      if (state is Idle) {
        return state.errorMsg;
      }
      return "";
    }));
    if (errorMsg.isEmpty) {
      return const SizedBox(height: 20);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFFF1F1),
        border: Border.all(color: const Color(0xFFFFD2D2)),
      ),
      child: Text(
        errorMsg,
        style: const TextStyle(
          color: HomeTheme.textMain,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
