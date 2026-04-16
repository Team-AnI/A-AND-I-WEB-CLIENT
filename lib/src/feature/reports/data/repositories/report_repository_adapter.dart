import 'package:aandi_course_api/aandi_course_api.dart' as course_api;
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/report_detail_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/report.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/repositories/report_repository.dart';

/// aandi_course_api 패키지를 과제 상세 Repository 인터페이스에 맞추는 구현체다.
final class ReportRepositoryAdapter implements ReportRepository {
  ReportRepositoryAdapter({required course_api.CourseApiClient client})
      : _client = client;

  final course_api.CourseApiClient _client;

  @override
  Future<ReportDetailResponseDto> getReportDetailById(
    String courseSlug,
    String assignmentId,
    String authorization,
  ) async {
    try {
      final assignment = await _client.getCourseAssignmentV2(
        accessToken: _extractAccessToken(authorization),
        courseSlug: courseSlug,
        assignmentId: assignmentId,
      );

      return ReportDetailResponseDto(
        success: true,
        data: _toReport(assignment),
      );
    } on course_api.CourseApiException catch (error) {
      return ReportDetailResponseDto(
        success: false,
        error: ReportDetailApiErrorDto(
          code: error.code,
          message: error.message,
        ),
      );
    }
  }
}

Report? _toReport(course_api.Assignment assignment) {
  final metadata = assignment.metadata;
  final reportType = _resolveReportType(
    candidates: <String?>[
      metadata.attributes['legacyReportType']?.toString(),
      metadata.attributes['reportType']?.toString(),
      assignment.courseSlug,
      metadata.title,
      metadata.description,
    ],
  );
  final level = _parseLevel(metadata.difficulty);

  if (assignment.id.isEmpty ||
      metadata.title.isEmpty ||
      metadata.description == null ||
      metadata.description!.isEmpty ||
      reportType == null ||
      level == null ||
      assignment.weekNo <= 0) {
    return null;
  }

  return Report(
    id: assignment.id,
    problemId: _extractProblemId(assignment),
    title: metadata.title,
    content: metadata.description!,
    requirement: metadata.requirements
        .map(
          (requirement) => SeqString(
            seq: requirement.sortOrder,
            content: requirement.requirementText,
          ),
        )
        .toList(growable: false),
    objects: metadata.learningGoals
        .map(
          (goal) => SeqString(
            seq: goal.sortOrder,
            content: goal.learningGoalText,
          ),
        )
        .toList(growable: false),
    exampleIo: _toExampleIo(metadata.testCases),
    codeTemplates: metadata.codeTemplates
        .where(
            (template) => (template.functionTemplate ?? '').trim().isNotEmpty)
        .map(
          (template) => CodeTemplate(
            language: template.language,
            functionTemplate: template.functionTemplate!.trim(),
          ),
        )
        .toList(growable: false),
    reportType: reportType,
    week: assignment.weekNo,
    level: level,
  );
}

String? _extractProblemId(course_api.Assignment assignment) {
  final attributes = assignment.metadata.attributes;
  for (final candidate in <Object?>[
    attributes['problemId'],
    attributes['gradingProblemId'],
    attributes['judgeProblemId'],
    attributes['problemUuid'],
  ]) {
    final value = candidate?.toString().trim();
    if (value != null && value.isNotEmpty) {
      return value;
    }
  }

  return null;
}

List<ExampleIO> _toExampleIo(List<course_api.AssignmentTestCase> testCases) {
  final examples = <ExampleIO>[];

  for (final testCase in testCases) {
    if (testCase.visibility != course_api.TestCaseVisibility.public) {
      continue;
    }

    examples.add(
      ExampleIO(
        seq: testCase.seq,
        input: _formatInputValues(testCase.inputValues),
        output: testCase.outputText ?? '',
      ),
    );
  }

  return examples;
}

String _formatInputValues(List<dynamic> values) {
  if (values.isEmpty) {
    return '';
  }

  return values.map((value) => value?.toString() ?? '').join('\n');
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

ReportType? _resolveReportType({required List<String?> candidates}) {
  for (final candidate in candidates) {
    final reportType = _parseReportType(candidate);
    if (reportType != null) {
      return reportType;
    }
  }

  return null;
}

String _extractAccessToken(String authorization) {
  const bearerPrefix = 'Bearer ';
  if (authorization.startsWith(bearerPrefix)) {
    return authorization.substring(bearerPrefix.length).trim();
  }

  return authorization.trim();
}
