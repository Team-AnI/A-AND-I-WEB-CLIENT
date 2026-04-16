import 'package:a_and_i_report_web_server/src/core/utils/api_error_mapper.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/submission_result.dart';
import 'package:aandi_oj_api/aandi_oj_api.dart' as oj_api;

/// 특정 문제에 대한 내 제출 이력을 조회하는 UseCase 구현체입니다.
final class GetMyProblemSubmissionsUsecaseImpl
    implements GetMyProblemSubmissionsUsecase {
  const GetMyProblemSubmissionsUsecaseImpl({
    required this.ojApiClient,
    required this.authRepository,
  });

  final oj_api.OjApiClient ojApiClient;
  final AuthRepository authRepository;

  @override
  Future<List<SubmissionResult>> call(String problemId) async {
    final token = await authRepository.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    try {
      final response = await ojApiClient.getMyProblemSubmissions(
        accessToken: token,
        problemId: problemId,
      );

      return response
          .map(
            (submission) => SubmissionResult(
              submissionId: submission.submissionId,
              problemId: submission.problemId,
              language: submission.language,
              status: submission.status,
              testCases: submission.testCases
                  .map(
                    (testCase) => SubmissionTestCaseResult(
                      caseId: testCase.caseId,
                      status: testCase.status,
                      timeMs: testCase.timeMs,
                      memoryMb: testCase.memoryMb,
                      output: testCase.output,
                      error: testCase.error,
                    ),
                  )
                  .toList(growable: false),
              createdAt: submission.createdAt,
              completedAt: submission.completedAt,
            ),
          )
          .toList(growable: false);
    } on oj_api.OjApiException catch (error) {
      throw Exception(
        ApiErrorMapper.mapApiError(
          code: error.code,
          message: error.message,
          alert: error.alert,
          fallbackMessage: '이전 제출 이력을 불러오지 못했습니다.',
        ),
      );
    } catch (error) {
      throw Exception(
        ApiErrorMapper.map(
          error,
          fallbackMessage: '이전 제출 이력을 불러오지 못했습니다.',
        ),
      );
    }
  }
}

/// 특정 문제에 대한 내 제출 이력을 조회하는 UseCase 인터페이스입니다.
abstract class GetMyProblemSubmissionsUsecase {
  Future<List<SubmissionResult>> call(String problemId);
}
