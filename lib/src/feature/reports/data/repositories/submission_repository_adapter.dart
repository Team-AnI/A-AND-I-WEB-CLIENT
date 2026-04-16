import 'package:aandi_oj_api/aandi_oj_api.dart' as oj_api;
import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/submission_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/repositories/submission_repository.dart';

/// aandi_oj_api 패키지를 제출 Repository 인터페이스에 맞추는 구현체다.
final class SubmissionRepositoryAdapter implements SubmissionRepository {
  SubmissionRepositoryAdapter({required oj_api.OjApiClient client})
      : _client = client;

  final oj_api.OjApiClient _client;

  @override
  Future<SubmissionResponseDto> createSubmission(
    String authorization,
    String contentType,
    String accept,
    Map<String, dynamic> request,
  ) async {
    try {
      final response = await _client.createSubmission(
        accessToken: _extractAccessToken(authorization),
        request: request,
      );

      return SubmissionResponseDto(
        submissionId: response.submissionId,
        streamUrl: response.streamUrl,
      );
    } on oj_api.OjApiException catch (error) {
      throw Exception(error.message);
    }
  }

  @override
  Future<dynamic> getMyProblemSubmissions(
    String problemId,
    String authorization,
  ) async {
    try {
      final submissions = await _client.getMyProblemSubmissions(
        accessToken: _extractAccessToken(authorization),
        problemId: problemId,
      );

      return submissions.map(_submissionToJson).toList(growable: false);
    } on oj_api.OjApiException catch (error) {
      throw Exception(error.message);
    }
  }

  @override
  Future<dynamic> getSubmissionResult(
    String submissionId,
    String authorization,
  ) async {
    try {
      final submission = await _client.getSubmissionResult(
        accessToken: _extractAccessToken(authorization),
        submissionId: submissionId,
      );

      return _submissionToJson(submission);
    } on oj_api.OjApiException catch (error) {
      throw Exception(error.message);
    }
  }
}

Map<String, dynamic> _submissionToJson(oj_api.Submission submission) {
  return <String, dynamic>{
    'submissionId': submission.submissionId,
    'submitterId': submission.submitterId,
    'submitterPublicCode': submission.submitterPublicCode,
    'problemId': submission.problemId,
    'language': submission.language,
    'code': submission.code,
    'status': submission.status,
    'testCases': submission.testCases
        .map(
          (testCase) => <String, dynamic>{
            'caseId': testCase.caseId,
            'status': testCase.status,
            'timeMs': testCase.timeMs,
            'memoryMb': testCase.memoryMb,
            'output': testCase.output,
            'error': testCase.error,
          },
        )
        .toList(growable: false),
    'createdAt': submission.createdAt?.toIso8601String(),
    'completedAt': submission.completedAt?.toIso8601String(),
  };
}

String _extractAccessToken(String authorization) {
  const bearerPrefix = 'Bearer ';
  if (authorization.startsWith(bearerPrefix)) {
    return authorization.substring(bearerPrefix.length).trim();
  }

  return authorization.trim();
}
