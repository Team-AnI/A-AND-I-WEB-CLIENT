import 'package:a_and_i_report_web_server/src/core/constants/api_url.dart';
import 'package:aandi_course_api/aandi_course_api.dart';
import 'package:aandi_oj_api/aandi_oj_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 외부 공통 API 패키지의 코스 클라이언트를 제공합니다.
final courseApiClientProvider = Provider<CourseApiClient>((ref) {
  return CourseApiClient(baseUrl: baseUrl);
});

/// 외부 공통 API 패키지의 OJ 클라이언트를 제공합니다.
final ojApiClientProvider = Provider<OjApiClient>((ref) {
  return OjApiClient(baseUrl: baseUrl);
});
