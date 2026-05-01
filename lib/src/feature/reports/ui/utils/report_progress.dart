import 'package:a_and_i_report_web_server/src/feature/home/data/entities/report_summary.dart';

/// 과제가 시작되었는지 여부를 반환합니다.
bool hasReportStarted(ReportSummary report, {DateTime? now}) {
  final startAt = report.startAt;
  if (startAt == null) {
    return false;
  }

  final currentTime = (now ?? DateTime.now()).toUtc();
  return !startAt.isAfter(currentTime);
}

/// 시작한 과제 중 가장 최신 주차를 반환합니다.
///
/// `startAt`이 현재 시각보다 이전이거나 같은 과제만 시작한 것으로 간주하며,
/// 그중 가장 큰 주차 번호를 현재 진행 중인 주차로 사용합니다.
int? findCurrentProgressWeek(List<ReportSummary> reports, {DateTime? now}) {
  final currentTime = (now ?? DateTime.now()).toUtc();
  int? latestWeek;

  for (final report in reports) {
    if (!hasReportStarted(report, now: currentTime)) {
      continue;
    }

    if (latestWeek == null || report.week > latestWeek) {
      latestWeek = report.week;
    }
  }

  return latestWeek;
}
