import 'package:flutter/material.dart';

/// 앱 전역에서 사용할 [ScaffoldMessengerState] 키입니다.
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

/// 앱 어디서든 공통 스낵바를 노출합니다.
void showGlobalSnackBar(String message) {
  final messenger = rootScaffoldMessengerKey.currentState;
  if (messenger == null) {
    return;
  }

  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
