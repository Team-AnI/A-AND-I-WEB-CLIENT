import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/report.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/entities/submission_result.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/get_my_problem_submissions_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/domain/usecases/get_submission_result_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/get_my_problem_submissions_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/providers/get_submission_result_usecase_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/viewModel/report_submit_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('ReportSubmitViewModel.loadSubmissionHistory', () {
    test('최신 제출 상세 결과를 다시 조회해 화면 상태를 복원한다', () async {
      final fakeHistoryUsecase = FakeGetMyProblemSubmissionsUsecase(
        results: <SubmissionResult>[
          SubmissionResult(
            submissionId: 'submission-1',
            problemId: 'problem-1',
            language: 'KOTLIN',
            status: 'WRONG_ANSWER',
            createdAt: DateTime.parse('2026-03-24T12:00:00Z'),
          ),
          SubmissionResult(
            submissionId: 'submission-2',
            problemId: 'problem-1',
            language: 'PYTHON',
            status: 'ACCEPTED',
            createdAt: DateTime.parse('2026-03-24T13:00:00Z'),
          ),
        ],
      );
      final fakeDetailUsecase = FakeGetSubmissionResultUsecase(
        responses: <String, SubmissionResult>{
          'submission-2': SubmissionResult(
            submissionId: 'submission-2',
            problemId: 'problem-1',
            language: 'PYTHON',
            status: 'ACCEPTED',
            createdAt: DateTime.parse('2026-03-24T13:00:00Z'),
            completedAt: DateTime.parse('2026-03-24T13:00:05Z'),
            testCases: const <SubmissionTestCaseResult>[
              SubmissionTestCaseResult(caseId: 1, status: 'PASSED'),
              SubmissionTestCaseResult(caseId: 2, status: 'PASSED'),
            ],
          ),
        },
      );
      final report = _buildReport();
      final container = ProviderContainer(
        overrides: [
          getMyProblemSubmissionsUsecaseProvider.overrideWith(
            (ref) => fakeHistoryUsecase,
          ),
          getSubmissionResultUsecaseProvider.overrideWith(
            (ref) => fakeDetailUsecase,
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(reportSubmitViewModelProvider(report).notifier);

      await notifier.loadSubmissionHistory(problemId: 'problem-1');

      final state = container.read(reportSubmitViewModelProvider(report));
      expect(fakeHistoryUsecase.requestedProblemIds, <String>['problem-1']);
      expect(
          fakeDetailUsecase.requestedSubmissionIds, <String>['submission-2']);
      expect(
          state.previousSubmissions.map((item) => item.submissionId), <String>[
        'submission-2',
        'submission-1',
      ]);
      expect(state.previousSubmissions.first.testCases, hasLength(2));
      expect(state.submissionStatus, SubmissionStatus.accepted);
      expect(state.score, 100);
      expect(state.submitCount, 2);
      expect(state.submittedAt, DateTime.parse('2026-03-24T13:00:00Z'));
      expect(state.latestSubmittedLanguage, SubmitLanguage.python);
      expect(state.submissionId, 'submission-2');
      expect(state.testCaseResults, hasLength(2));
      expect(state.feedbacks, contains('가장 최근 채점 기록을 불러왔습니다.'));
      expect(state.feedbacks.last, '채점이 완료되었습니다. 정답입니다!');
      expect(state.hasLoadedHistory, isTrue);
      expect(state.historyErrorMsg, isEmpty);
    });

    test('제출 이력이 없으면 상세 조회 없이 빈 히스토리만 유지한다', () async {
      final fakeHistoryUsecase = FakeGetMyProblemSubmissionsUsecase(
        results: const <SubmissionResult>[],
      );
      final fakeDetailUsecase = FakeGetSubmissionResultUsecase(
        responses: const <String, SubmissionResult>{},
      );
      final report = _buildReport();
      final container = ProviderContainer(
        overrides: [
          getMyProblemSubmissionsUsecaseProvider.overrideWith(
            (ref) => fakeHistoryUsecase,
          ),
          getSubmissionResultUsecaseProvider.overrideWith(
            (ref) => fakeDetailUsecase,
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(reportSubmitViewModelProvider(report).notifier);

      await notifier.loadSubmissionHistory(problemId: 'problem-1');

      final state = container.read(reportSubmitViewModelProvider(report));
      expect(fakeDetailUsecase.requestedSubmissionIds, isEmpty);
      expect(state.previousSubmissions, isEmpty);
      expect(state.submissionStatus, SubmissionStatus.notSubmitted);
      expect(state.submitCount, 0);
      expect(state.hasLoadedHistory, isTrue);
      expect(state.historyErrorMsg, isEmpty);
    });
  });
}

class FakeGetMyProblemSubmissionsUsecase
    implements GetMyProblemSubmissionsUsecase {
  FakeGetMyProblemSubmissionsUsecase({
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

class FakeGetSubmissionResultUsecase implements GetSubmissionResultUsecase {
  FakeGetSubmissionResultUsecase({
    required this.responses,
  });

  final Map<String, SubmissionResult> responses;
  final List<String> requestedSubmissionIds = <String>[];

  @override
  Future<SubmissionResult?> call(String submissionId) async {
    requestedSubmissionIds.add(submissionId);
    return responses[submissionId];
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
