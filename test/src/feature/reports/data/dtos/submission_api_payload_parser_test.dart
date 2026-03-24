import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/submission_api_payload_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SubmissionApiPayloadParser', () {
    test('숫자 output이 포함된 제출 목록도 정상 파싱한다', () {
      final raw = <Map<String, dynamic>>[
        <String, dynamic>{
          'submissionId': '30386dad-3fd3-4d27-9f7f-6f85eb9eeb5e',
          'problemId': '074f1290-1699-4c1e-b7a3-93f80772989e',
          'language': 'DART',
          'status': 'ACCEPTED',
          'testCases': <Map<String, dynamic>>[
            <String, dynamic>{
              'caseId': 1,
              'status': 'PASSED',
              'timeMs': 0.119,
              'memoryMb': 0.0,
              'output': 2,
              'error': null,
            },
            <String, dynamic>{
              'caseId': 2,
              'status': 'PASSED',
              'timeMs': 0.155,
              'memoryMb': 0.0,
              'output': 3,
              'error': null,
            },
          ],
          'createdAt': '2026-03-24T13:37:22.541Z',
          'completedAt': '2026-03-24T13:37:25.816Z',
        },
      ];

      final result = SubmissionApiPayloadParser.parseSubmissionList(raw);

      expect(result, hasLength(1));
      expect(result.first.testCases, hasLength(2));
      expect(result.first.testCases.first.output, '2');
      expect(result.first.testCases.last.output, '3');
    });
  });
}
