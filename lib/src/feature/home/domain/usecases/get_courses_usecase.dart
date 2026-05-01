import 'package:a_and_i_report_web_server/src/core/utils/api_error_mapper.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/course.dart';
import 'package:aandi_course_api/aandi_course_api.dart' as course_api;

/// 코스 목록 조회 UseCase 인터페이스입니다.
abstract class GetCoursesUsecase {
  Future<List<Course>> call();
}

/// 코스 목록을 조회하는 UseCase 구현체입니다.
final class GetCoursesUsecaseImpl implements GetCoursesUsecase {
  final course_api.CourseApiClient _courseApiClient;
  final AuthRepository _authRepository;

  const GetCoursesUsecaseImpl({
    required course_api.CourseApiClient courseApiClient,
    required AuthRepository authRepository,
  })  : _courseApiClient = courseApiClient,
        _authRepository = authRepository;

  @override
  Future<List<Course>> call() async {
    final token = await _authRepository.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    final requests = <({String? status, String? phase, String? track})>[
      (status: null, phase: null, track: null),
      (status: 'PUBLISHED', phase: null, track: null),
      (status: 'PUBLISHED', phase: null, track: 'FL'),
      (status: 'PUBLISHED', phase: 'BASIC', track: 'FL'),
      (status: 'PUBLISHED', phase: 'CS', track: 'FL'),
    ];

    for (final request in requests) {
      try {
        final courses = await _courseApiClient.getCoursesV2(
          accessToken: token,
          status: request.status,
          phase: request.phase,
          track: request.track,
        );

        if (courses.isNotEmpty) {
          return _deduplicateCourses(
            courses.map(_toCourse).toList(growable: false),
          );
        }
      } on course_api.CourseApiException catch (error) {
        throw Exception(
          ApiErrorMapper.mapApiError(
            code: error.code,
            message: error.message,
            alert: error.alert,
            fallbackMessage: '코스 목록 조회에 실패했습니다.',
          ),
        );
      } catch (error) {
        throw Exception(
          ApiErrorMapper.map(
            error,
            fallbackMessage: '코스 목록 조회에 실패했습니다.',
          ),
        );
      }
    }

    return const [];
  }

  List<Course> _deduplicateCourses(List<Course> courses) {
    final uniqueById = <String, Course>{};

    for (final course in courses) {
      uniqueById[course.id] = course;
    }

    return uniqueById.values.toList(growable: false);
  }

  Course _toCourse(course_api.CourseSummary course) {
    return Course(
      id: course.id,
      slug: course.slug,
      fieldTag: course.targetTrack,
      startDate: course.startDate ?? '',
      endDate: course.endDate ?? '',
      metadata: CourseMetadata(
        title: course.metadata.title,
        description: course.metadata.description ?? '',
        phase: course.metadata.phase,
        attributes: course.metadata.attributes,
      ),
      status: course.status,
      createdAt: course.createdAt ??
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      updatedAt: course.updatedAt ??
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      title: course.metadata.title,
      description: course.metadata.description,
      phase: course.metadata.phase,
      targetTrack: course.targetTrack,
    );
  }
}
