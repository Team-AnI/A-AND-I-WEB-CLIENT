import 'package:aandi_course_api/aandi_course_api.dart' as course_api;
import 'package:a_and_i_report_web_server/src/feature/home/data/dtos/report_summary_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_summary.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/repositories/report_summary_repository.dart';

/// aandi_course_api 패키지를 과제 요약 Repository 인터페이스에 맞추는 구현체다.
final class ReportSummaryRepositoryAdapter implements ReportSummaryRepository {
  ReportSummaryRepositoryAdapter({required course_api.CourseApiClient client})
      : _client = client;

  final course_api.CourseApiClient _client;

  @override
  Future<CourseOutlineResponseDto> getOutline(
    String authorization,
    String courseSlug,
  ) async {
    try {
      final outline = await _client.getCourseOutlineV2(
        accessToken: _extractAccessToken(authorization),
        courseSlug: courseSlug,
      );

      return CourseOutlineResponseDto(
        success: true,
        data: CourseOutlineDataDto(
          course: CourseOutlineHeaderDto(
            id: outline.course.id,
            slug: outline.course.slug,
            fieldTag: outline.course.targetTrack,
            title: outline.course.title,
            description: outline.course.description ?? '',
            phase: outline.course.phase,
          ),
          totalAssignments: outline.totalAssignments,
          assignments: outline.assignments
              .map(
                (assignment) => CourseOutlineAssignmentDto(
                  assignmentId: assignment.id,
                  weekNo: assignment.weekNo,
                  orderInWeek: assignment.orderInWeek,
                  title: assignment.title,
                  difficulty: assignment.difficulty,
                  startAt: _parseDateTimeString(assignment.startAt),
                  endAt: _parseDateTimeString(assignment.endAt),
                  checked: assignment.checked,
                ),
              )
              .toList(growable: false),
        ),
      );
    } on course_api.CourseApiException catch (error) {
      return CourseOutlineResponseDto(
        success: false,
        error: ReportSummaryApiErrorDto(
          code: error.code,
          message: error.message,
        ),
      );
    }
  }

  @override
  Future<ReportSummaryResponseDto> getReportSummaries(
    String authorization,
    String courseSlug,
    int weekNo,
    String status,
  ) async {
    try {
      final accessToken = _extractAccessToken(authorization);
      final course = await _client.getCourseV2(
        accessToken: accessToken,
        courseSlug: courseSlug,
      );
      final assignments = await _client.getWeekAssignmentsV2(
        accessToken: accessToken,
        courseSlug: courseSlug,
        weekNo: weekNo,
        status: status,
      );

      final reportType = _resolveReportType(
        phase: course.metadata.phase,
        slug: course.slug,
        title: course.metadata.title,
        description: course.metadata.description,
        fieldTag: course.targetTrack,
      );
      final summaries = reportType == null
          ? const <ReportSummary>[]
          : assignments
              .map((assignment) => _toReportSummary(assignment, reportType))
              .whereType<ReportSummary>()
              .toList(growable: false);

      return ReportSummaryResponseDto(success: true, data: summaries);
    } on course_api.CourseApiException catch (error) {
      return ReportSummaryResponseDto(
        success: false,
        data: const <ReportSummary>[],
        error: ReportSummaryApiErrorDto(
          code: error.code,
          message: error.message,
        ),
      );
    }
  }
}

ReportSummary? _toReportSummary(
  course_api.Assignment assignment,
  ReportType reportType,
) {
  final level = _parseLevel(assignment.metadata.difficulty);
  final endAt = _parseDateTimeString(assignment.endAt);

  if (assignment.id.isEmpty ||
      assignment.metadata.title.isEmpty ||
      assignment.weekNo <= 0 ||
      level == null ||
      endAt == null) {
    return null;
  }

  return ReportSummary(
    id: assignment.id,
    week: assignment.weekNo,
    seq: assignment.orderInWeek,
    title: assignment.metadata.title,
    level: level,
    reportType: reportType,
    startAt: _parseDateTimeString(assignment.startAt),
    endAt: endAt,
  );
}

Level? _parseLevel(String? value) {
  final normalized = value?.trim().toUpperCase();
  if (normalized == null || normalized.isEmpty) {
    return null;
  }

  return switch (normalized) {
    'VERY_HIGH' || 'VERYHIGH' => Level.VERYHIGH,
    'HIGH' => Level.HIGH,
    'MID' || 'MEDIUM' => Level.MEDIUM,
    'LOW' => Level.LOW,
    _ => null,
  };
}

ReportType? _parseReportType(String? value) {
  final normalized = value?.trim().toUpperCase();
  if (normalized == null || normalized.isEmpty) {
    return null;
  }

  if (normalized.contains('CS') ||
      normalized.contains('COMPUTER SCIENCE') ||
      normalized.contains('BACKEND')) {
    return ReportType.CS;
  }

  if (normalized.contains('BASIC') ||
      normalized.contains('FRAMEWORK') ||
      normalized.contains('기초')) {
    return ReportType.BASIC;
  }

  return null;
}

ReportType? _resolveReportType({
  required String? phase,
  required String? slug,
  required String? title,
  required String? description,
  required String? fieldTag,
}) {
  for (final candidate in <String?>[
    phase,
    slug,
    title,
    description,
    fieldTag,
  ]) {
    final reportType = _parseReportType(candidate);
    if (reportType != null) {
      return reportType;
    }
  }

  return null;
}

DateTime? _parseDateTimeString(String? value) {
  if (value == null || value.trim().isEmpty) {
    return null;
  }

  return DateTime.tryParse(value);
}

String _extractAccessToken(String authorization) {
  const bearerPrefix = 'Bearer ';
  if (authorization.startsWith(bearerPrefix)) {
    return authorization.substring(bearerPrefix.length).trim();
  }

  return authorization.trim();
}
