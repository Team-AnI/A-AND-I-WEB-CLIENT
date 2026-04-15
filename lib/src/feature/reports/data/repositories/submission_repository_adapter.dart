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

      return submissions.map((submission) => submission.toJson()).toList();
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

      return submission.toJson();
    } on oj_api.OjApiException catch (error) {
      throw Exception(error.message);
    }
  }
}

String _extractAccessToken(String authorization) {
  const bearerPrefix = 'Bearer ';
  if (authorization.startsWith(bearerPrefix)) {
    return authorization.substring(bearerPrefix.length).trim();
  }

  return authorization.trim();
}
