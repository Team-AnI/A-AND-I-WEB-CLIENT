import 'dart:async';

import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/submission_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/report.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/submission_result.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/create_submission_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/get_my_problem_submissions_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/get_submission_result_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/stream_submission_events_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/create_submission_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/get_my_problem_submissions_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/get_submission_result_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/stream_submission_events_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/problem_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('ProblemDetailView', () {
    testWidgets('제출 성공 후 자동으로 결과 탭으로 이동할 때는 이력을 먼저 조회하지 않는다',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1440, 2000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final fakeCreateUsecase = _FakeCreateSubmissionUsecase(
        response: const SubmissionResponseDto(
          submissionId: 'submission-1',
          streamUrl: '/streams/submission-1',
        ),
      );
      final fakeHistoryUsecase = _FakeGetMyProblemSubmissionsUsecase(
        results: const <SubmissionResult>[],
      );
      final fakeDetailUsecase = _FakeGetSubmissionResultUsecase(
        responses: const <String, SubmissionResult?>{},
      );
      final fakeStreamUsecase = _FakeStreamSubmissionEventsUsecase(
        streams: <String, Stream<String>>{
          '/streams/submission-1': const Stream<String>.empty(),
        },
      );
      final container = ProviderContainer(
        overrides: [
          createSubmissionUsecaseProvider.overrideWith((ref) {
            return fakeCreateUsecase;
          }),
          getMyProblemSubmissionsUsecaseProvider.overrideWith((ref) {
            return fakeHistoryUsecase;
          }),
          getSubmissionResultUsecaseProvider.overrideWith((ref) {
            return fakeDetailUsecase;
          }),
          streamSubmissionEventsUsecaseProvider.overrideWith((ref) {
            return fakeStreamUsecase;
          }),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(
              body: ProblemDetailView(report: _buildReport()),
            ),
          ),
        ),
      );

      await tester.tap(find.text('제출'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('제출하기'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));

      expect(fakeCreateUsecase.requestedProblemIds, <String>['problem-1']);
      expect(fakeHistoryUsecase.requestedProblemIds, isEmpty);
      expect(find.text('제출 결과'), findsOneWidget);
    });

    testWidgets('사용자가 결과 탭을 직접 선택하면 기존처럼 제출 이력을 조회한다',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1440, 2000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final fakeHistoryUsecase = _FakeGetMyProblemSubmissionsUsecase(
        results: const <SubmissionResult>[],
      );
      final fakeDetailUsecase = _FakeGetSubmissionResultUsecase(
        responses: const <String, SubmissionResult?>{},
      );
      final container = ProviderContainer(
        overrides: [
          getMyProblemSubmissionsUsecaseProvider.overrideWith((ref) {
            return fakeHistoryUsecase;
          }),
          getSubmissionResultUsecaseProvider.overrideWith((ref) {
            return fakeDetailUsecase;
          }),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(
              body: ProblemDetailView(report: _buildReport()),
            ),
          ),
        ),
      );

      await tester.tap(find.text('결과'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));

      await tester.tap(find.text('문제').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('결과'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));

      expect(fakeHistoryUsecase.requestedProblemIds, <String>['problem-1']);
      expect(find.text('제출 결과'), findsOneWidget);
    });

    testWidgets('채점 스트림이 끝나기 전에는 결과 탭을 다시 눌러도 이력을 조회하지 않는다',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1440, 2000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final streamController = StreamController<String>();
      addTearDown(streamController.close);

      final fakeCreateUsecase = _FakeCreateSubmissionUsecase(
        response: const SubmissionResponseDto(
          submissionId: 'submission-2',
          streamUrl: '/streams/submission-2',
        ),
      );
      final fakeHistoryUsecase = _FakeGetMyProblemSubmissionsUsecase(
        results: const <SubmissionResult>[],
      );
      final fakeDetailUsecase = _FakeGetSubmissionResultUsecase(
        responses: const <String, SubmissionResult?>{},
      );
      final fakeStreamUsecase = _FakeStreamSubmissionEventsUsecase(
        streams: <String, Stream<String>>{
          '/streams/submission-2': streamController.stream,
        },
      );
      final container = ProviderContainer(
        overrides: [
          createSubmissionUsecaseProvider.overrideWith((ref) {
            return fakeCreateUsecase;
          }),
          getMyProblemSubmissionsUsecaseProvider.overrideWith((ref) {
            return fakeHistoryUsecase;
          }),
          getSubmissionResultUsecaseProvider.overrideWith((ref) {
            return fakeDetailUsecase;
          }),
          streamSubmissionEventsUsecaseProvider.overrideWith((ref) {
            return fakeStreamUsecase;
          }),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(
              body: ProblemDetailView(report: _buildReport()),
            ),
          ),
        ),
      );

      await tester.tap(find.text('제출'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('제출하기'));
      await tester.pump();

      await tester.tap(find.text('문제').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('결과'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));

      expect(fakeHistoryUsecase.requestedProblemIds, isEmpty);
      expect(find.text('제출 결과'), findsOneWidget);
    });
  });
}

class _FakeCreateSubmissionUsecase implements CreateSubmissionUsecase {
  _FakeCreateSubmissionUsecase({
    required this.response,
  });

  final SubmissionResponseDto response;
  final List<String> requestedProblemIds = <String>[];

  @override
  Future<SubmissionResponseDto> call({
    required String problemId,
    required String language,
    required String code,
  }) async {
    requestedProblemIds.add(problemId);
    return response;
  }
}

class _FakeGetMyProblemSubmissionsUsecase
    implements GetMyProblemSubmissionsUsecase {
  _FakeGetMyProblemSubmissionsUsecase({
    required this.results,
  });

  final List<SubmissionResult> results;
  final List<String> requestedProblemIds = <String>[];

  @override
  Future<List<SubmissionResult>> call(String problemId) async {
    requestedProblemIds.add(problemId);
    return results;
  }
}

class _FakeGetSubmissionResultUsecase implements GetSubmissionResultUsecase {
  _FakeGetSubmissionResultUsecase({
    required this.responses,
  });

  final Map<String, SubmissionResult?> responses;

  @override
  Future<SubmissionResult?> call(String submissionId) async {
    return responses[submissionId];
  }
}

class _FakeStreamSubmissionEventsUsecase
    implements StreamSubmissionEventsUsecase {
  _FakeStreamSubmissionEventsUsecase({
    required this.streams,
  });

  final Map<String, Stream<String>> streams;

  @override
  Future<Stream<String>> call(String streamUrl) async {
    return streams[streamUrl] ?? const Stream<String>.empty();
  }
}

Report _buildReport() {
  return Report(
    id: 'report-1',
    problemId: 'problem-1',
    title: '문제',
    content: '설명',
    requirement: <SeqString>[],
    objects: <SeqString>[],
    exampleIo: <ExampleIO>[],
    codeTemplates: <CodeTemplate>[],
    reportType: ReportType.CS,
    week: 1,
    level: Level.MEDIUM,
  );
}
