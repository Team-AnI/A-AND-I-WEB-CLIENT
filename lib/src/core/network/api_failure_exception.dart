import 'package:a_and_i_report_web_server/src/core/network/base_response.dart';

/// 공통 API envelope 실패를 표현하는 예외입니다.
class ApiFailureException implements Exception {
  const ApiFailureException({
    this.statusCode,
    this.error,
    this.timestamp,
  });

  final int? statusCode;
  final BaseResponseError? error;
  final String? timestamp;

  String get message {
    final alert = error?.alert?.trim();
    if (alert != null && alert.isNotEmpty) {
      return alert;
    }

    final detail = error?.message?.trim();
    if (detail != null && detail.isNotEmpty) {
      return detail;
    }

    return '요청 처리 중 오류가 발생했습니다.';
  }

  @override
  String toString() => message;
}
