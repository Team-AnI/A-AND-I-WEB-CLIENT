import 'package:aandi_course_api/aandi_course_api.dart' as course_api;
import 'package:a_and_i_report_web_server/src/feature/home/data/dtos/course_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/course.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/repositories/course_repository.dart';

/// aandi_course_api 패키지를 루트 앱 Repository 인터페이스에 맞게 변환하는 구현체다.
final class CourseRepositoryAdapter implements CourseRepository {
  CourseRepositoryAdapter({required course_api.CourseApiClient client})
      : _client = client;

  final course_api.CourseApiClient _client;

  @override
  Future<CourseDetailResponseDto> getCourseBySlugFromCourses(
    String authorization,
    String courseSlug,
  ) async {
    try {
      final course = await _client.getCourseV2(
        accessToken: _extractAccessToken(authorization),
        courseSlug: courseSlug,
      );

      return CourseDetailResponseDto(
        success: true,
        data: _toCourse(course),
      );
    } on course_api.CourseApiException catch (error) {
      return CourseDetailResponseDto(
        success: false,
        error: CourseApiErrorDto(code: error.code, message: error.message),
      );
    }
  }

  @override
  Future<CourseListResponseDto> getCourses(
    String authorization,
    String? status,
    String? phase,
    String? track,
  ) async {
    try {
      final courses = await _client.getCoursesV2(
        accessToken: _extractAccessToken(authorization),
        status: status,
        phase: phase,
        track: track,
      );

      return CourseListResponseDto(
        success: true,
        data: courses.map(_toCourse).toList(growable: false),
      );
    } on course_api.CourseApiException catch (error) {
      return CourseListResponseDto(
        success: false,
        error: CourseApiErrorDto(code: error.code, message: error.message),
      );
    }
  }
}

Course _toCourse(course_api.CourseSummary course) {
  final metadata = course.metadata;
  final fallbackDate = DateTime.fromMillisecondsSinceEpoch(0);

  return Course(
    id: course.id,
    slug: course.slug,
    fieldTag: course.targetTrack,
    startDate: course.startDate ?? '',
    endDate: course.endDate ?? '',
    metadata: CourseMetadata(
      title: metadata.title,
      description: metadata.description ?? '',
      phase: metadata.phase,
      attributes: metadata.attributes,
    ),
    status: course.status,
    createdAt: course.createdAt ?? fallbackDate,
    updatedAt: course.updatedAt ?? fallbackDate,
    title: metadata.title,
    description: metadata.description,
    phase: metadata.phase,
    targetTrack: course.targetTrack,
  );
}

String _extractAccessToken(String authorization) {
  const bearerPrefix = 'Bearer ';
  if (authorization.startsWith(bearerPrefix)) {
    return authorization.substring(bearerPrefix.length).trim();
  }

  return authorization.trim();
}
