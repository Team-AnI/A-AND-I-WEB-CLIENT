import 'package:a_and_i_report_web_server/src/core/utils/api_error_mapper.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/report_detail_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/report.dart';
import 'package:aandi_course_api/aandi_course_api.dart' as course_api;

/// 과제 상세 정보를 조회하는 UseCase 구현체입니다.
///
/// **동작 순서:**
/// 1. 인증 토큰 존재 여부를 확인합니다.
/// 2. [id]에 해당하는 과제 정보를 [ReportRepository]를 통해 요청합니다.
final class GetReportDetailUsecaseImpl implements GetReportDetailUsecase {
  final course_api.CourseApiClient courseApiClient;
  final AuthRepository authRepository;

  const GetReportDetailUsecaseImpl({
    required this.courseApiClient,
    required this.authRepository,
  });

  @override
  Future<Report> call(String courseSlug, String assignmentId) async {
    // 세션 스토리지에서 토큰 가져오기
    final token = await authRepository.getToken();

    // 토큰이 없으면 인증되지 않은 사용자
    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    try {
      final assignment = await courseApiClient.getCourseAssignmentV2(
        accessToken: token,
        courseSlug: courseSlug,
        assignmentId: assignmentId,
      );

      final response = ReportDetailResponseDto.fromJson(
        _buildReportDetailResponseJson(assignment),
      );

      if (response.data == null) {
        throw Exception(
          '과제 상세 응답을 해석하지 못했습니다.',
        );
      }

      return response.data!;
    } on course_api.CourseApiException catch (error) {
      throw Exception(
        ApiErrorMapper.mapApiError(
          code: error.code,
          message: error.message,
          alert: error.alert,
          fallbackMessage: '과제 상세 조회에 실패했습니다.',
        ),
      );
    } catch (error) {
      throw Exception(
        ApiErrorMapper.map(
          error,
          fallbackMessage: '과제 상세 조회에 실패했습니다.',
        ),
      );
    }
  }
}

Map<String, dynamic> _buildReportDetailResponseJson(
  course_api.Assignment assignment,
) {
  final metadata = assignment.metadata;

  return <String, dynamic>{
    'success': true,
    'data': <String, dynamic>{
      'assignmentId': assignment.id,
      'courseSlug': assignment.courseSlug,
      'weekNo': assignment.weekNo,
      'orderInWeek': assignment.orderInWeek,
      'startAt': assignment.startAt,
      'endAt': assignment.endAt,
      'status': assignment.status,
      'publishedAt': assignment.publishedAt,
      'metadata': <String, dynamic>{
        'title': metadata.title,
        'difficulty': metadata.difficulty,
        'description': metadata.description,
        'learningGoals': metadata.learningGoals
            .map(
              (goal) => <String, dynamic>{
                'sortOrder': goal.sortOrder,
                'learningGoalText': goal.learningGoalText,
              },
            )
            .toList(growable: false),
        'requirements': metadata.requirements
            .map(
              (requirement) => <String, dynamic>{
                'sortOrder': requirement.sortOrder,
                'requirementText': requirement.requirementText,
              },
            )
            .toList(growable: false),
        'testCases': metadata.testCases
            .map(
              (testCase) => <String, dynamic>{
                'seq': testCase.seq,
                'inputValues': testCase.inputValues,
                'outputText': testCase.outputText,
                'visibility': testCase.visibility.name.toUpperCase(),
              },
            )
            .toList(growable: false),
        'codeTemplates': metadata.codeTemplates
            .map(
              (template) => <String, dynamic>{
                'language': template.language,
                'codeTemplate': template.codeTemplate,
                'runnableTemplate': template.runnableTemplate,
                'commentTemplate': template.commentTemplate,
                'functionTemplate': template.functionTemplate,
              },
            )
            .toList(growable: false),
        'attributes': metadata.attributes,
      },
    },
    'error': null,
    'timestamp': null,
  };
}

/// 과제 상세 정보 조회 UseCase 인터페이스입니다.
abstract class GetReportDetailUsecase {
  Future<Report> call(String courseSlug, String assignmentId);
}
