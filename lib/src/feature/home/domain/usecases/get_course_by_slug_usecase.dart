import 'package:a_and_i_report_web_server/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/course.dart';
import 'package:aandi_course_api/aandi_course_api.dart' as course_api;

/// 코스 슬러그로 코스 상세 정보를 조회하는 UseCase 인터페이스입니다.
abstract class GetCourseBySlugUsecase {
  Future<Course> call(String courseSlug);
}

/// 코스 슬러그로 코스 상세 정보를 조회하는 UseCase 구현체입니다.
final class GetCourseBySlugUsecaseImpl implements GetCourseBySlugUsecase {
  final course_api.CourseApiClient _courseApiClient;
  final AuthRepository _authRepository;

  const GetCourseBySlugUsecaseImpl({
    required course_api.CourseApiClient courseApiClient,
    required AuthRepository authRepository,
  })  : _courseApiClient = courseApiClient,
        _authRepository = authRepository;

  @override
  Future<Course> call(String courseSlug) async {
    final token = await _authRepository.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('인증되지 않은 사용자입니다. 로그인이 필요합니다.');
    }

    try {
      final course = await _courseApiClient.getCourseV2(
        accessToken: token,
        courseSlug: courseSlug,
      );
      return _toCourse(course);
    } on course_api.CourseApiException catch (error) {
      throw Exception(
        error.alert?.trim().isNotEmpty == true
            ? error.alert!
            : error.message,
      );
    }
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
      createdAt:
          course.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      updatedAt:
          course.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      title: course.metadata.title,
      description: course.metadata.description,
      phase: course.metadata.phase,
      targetTrack: course.targetTrack,
    );
  }
}
