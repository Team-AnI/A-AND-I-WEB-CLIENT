import 'package:a_and_i_report_web_server/src/feature/auth/ui/views/error_message_view.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/views/login_button_view.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/views/login_text_field_view.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width < 560 ? width - 40 : 420.0;

    return Container(
      width: cardWidth,
      constraints: const BoxConstraints(minHeight: 430),
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 8),
            color: Colors.black.withValues(alpha: 0.06),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 150,
            child: Image.asset("assets/logo.webp"),
          ),
          const SizedBox(height: 22),
          const LoginTextFieldView(),
          const SizedBox(height: 14),
          const LoginButtonView(),
          const SizedBox(height: 10),
          const ErrorMessageView(),
        ],
      ),
    );
  }
}
