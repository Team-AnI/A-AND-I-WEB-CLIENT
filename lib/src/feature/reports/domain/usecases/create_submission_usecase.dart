import 'package:a_and_i_report_web_server/src/core/utils/api_error_mapper.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/submission_response_dto.dart';
import 'package:aandi_oj_api/aandi_oj_api.dart' as oj_api;

/// 제출 생성 UseCase 구현체입니다.
final class CreateSubmissionUsecaseImpl implements CreateSubmissionUsecase {
  final oj_api.OjApiClient ojApiClient;
  final AuthRepository authRepository;

  const CreateSubmissionUsecaseImpl({
    required this.ojApiClient,
    required this.authRepository,
  });

  @override
  Future<SubmissionResponseDto> call({
    required String problemId,
    required String language,
    required String code,
  }) async {
    final token = await authRepository.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    var publicCode = (await authRepository.getCachedUser())?.publicCode?.trim();
    if (publicCode == null || publicCode.isEmpty) {
      final user = await authRepository.getMyInfo(token);
      await authRepository.saveCachedUser(user);
      publicCode = user.publicCode?.trim();
    }

    if (publicCode == null || publicCode.isEmpty) {
      throw Exception('사용자 publicCode를 확인할 수 없습니다.');
    }

    try {
      final response = await ojApiClient.createSubmission(
        accessToken: token,
        request: <String, dynamic>{
          'publicCode': publicCode,
          'problemId': problemId,
          'language': language,
          'code': code,
          'options': const <String, dynamic>{
            'realtimeFeedback': true,
          },
        },
      );
      return SubmissionResponseDto(
        submissionId: response.submissionId,
        streamUrl: response.streamUrl,
      );
    } on oj_api.OjApiException catch (error) {
      throw Exception(
        ApiErrorMapper.mapApiError(
          code: error.code,
          message: error.message,
          alert: error.alert,
          fallbackMessage: '소스 코드 제출에 실패했습니다.',
        ),
      );
    }
  }
}

/// 제출 생성 UseCase 인터페이스입니다.
abstract class CreateSubmissionUsecase {
  Future<SubmissionResponseDto> call({
    required String problemId,
    required String language,
    required String code,
  });
}
