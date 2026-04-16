import 'package:a_and_i_report_web_server/src/core/utils/api_error_mapper.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_summary.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/dtos/report_summary_response_dto.dart';
import 'package:aandi_course_api/aandi_course_api.dart' as course_api;

/// 과제 목록을 조회하는 UseCase 구현체입니다.
///
/// **동작 순서:**
/// 1. [AuthRepository]를 통해 로컬 저장소의 토큰을 확인합니다.
/// 2. 토큰이 없으면 예외를 발생시킵니다 (로그인 필요).
/// 3. 토큰을 `Authorization` 헤더 포맷(`Bearer ...`)으로 가공합니다.
/// 4. [ReportSummaryRepository]를 호출하여 데이터를 받아옵니다.
final class GetReportSummaryUsecaseImpl implements GetReportSummaryUsecase {
  final AuthRepository authRepository;
  final course_api.CourseApiClient courseApiClient;
  const GetReportSummaryUsecaseImpl({
    required this.authRepository,
    required this.courseApiClient,
  });

  @override
  Future<List<ReportSummary>> call(String courseSlug) async {
    if (courseSlug.trim().isEmpty) {
      throw Exception('코스 슬러그가 없어 과제 목록을 조회할 수 없습니다.');
    }

    // 세션 스토리지에서 토큰 가져오기
    final token = await authRepository.getToken();
    // 토큰이 없으면 인증되지 않은 사용자
    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    try {
      final outline = await courseApiClient.getCourseOutlineV2(
        accessToken: token,
        courseSlug: courseSlug,
      );

      final outlineResponse = CourseOutlineResponseDto.fromJson(<String, dynamic>{
        'success': true,
        'data': outline.toJson(),
        'error': null,
        'timestamp': null,
      });

      final reports = outlineResponse.toSummaries();

      reports.sort((a, b) {
        final weekCompare = a.week.compareTo(b.week);
        if (weekCompare != 0) {
          return weekCompare;
        }

        return a.seq.compareTo(b.seq);
      });

      return reports;
    } on course_api.CourseApiException catch (error) {
      throw Exception(
        ApiErrorMapper.mapApiError(
          code: error.code,
          message: error.message,
          alert: error.alert,
          fallbackMessage: '코스 목차 조회에 실패했습니다.',
        ),
      );
    } catch (error) {
      throw Exception(
        ApiErrorMapper.map(
          error,
          fallbackMessage: '코스 목차를 불러오지 못했습니다.',
        ),
      );
    }
  }
}

/// 과제 목록 조회 UseCase 인터페이스입니다.
abstract class GetReportSummaryUsecase {
  Future<List<ReportSummary>> call(String courseSlug);
}
