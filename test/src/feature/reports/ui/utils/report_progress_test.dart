import 'package:a_and_i_report_web_server/src/feature/home/data/entities/level.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_summary.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_type.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/utils/report_progress.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('findCurrentProgressWeek', () {
    test('시작한 과제 중 가장 최신 주차를 진행 중으로 본다', () {
      final now = DateTime.parse('2026-04-07T12:00:00Z');
      final reports = [
        _report(
          week: 1,
          startAt: DateTime.parse('2026-04-01T00:00:00Z'),
        ),
        _report(
          week: 2,
          startAt: DateTime.parse('2026-04-05T00:00:00Z'),
        ),
        _report(
          week: 3,
          startAt: DateTime.parse('2026-04-08T00:00:00Z'),
        ),
      ];

      expect(findCurrentProgressWeek(reports, now: now), 2);
    });

    test('시작한 과제가 없으면 진행 중 주차가 없다', () {
      final now = DateTime.parse('2026-04-07T12:00:00Z');
      final reports = [
        _report(
          week: 3,
          startAt: DateTime.parse('2026-04-08T00:00:00Z'),
        ),
      ];

      expect(findCurrentProgressWeek(reports, now: now), isNull);
    });
  });
}

ReportSummary _report({
  required int week,
  DateTime? startAt,
}) {
  return ReportSummary(
    id: 'report-$week',
    week: week,
    seq: 1,
    title: 'Report $week',
    level: Level.LOW,
    reportType: ReportType.CS,
    startAt: startAt,
    endAt: DateTime.parse('2026-04-30T00:00:00Z'),
  );
}
