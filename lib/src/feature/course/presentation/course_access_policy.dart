/// 강좌 목록에 노출 가능한지 반환합니다.
///
/// 시작일이 미래라면 아직 시작 전 과정으로 보고 목록에서 숨깁니다.
bool isCourseVisible(String? startDate, {DateTime? now}) {
  final startAt = _parseCourseStartAt(startDate);
  if (startAt == null) {
    return true;
  }

  final currentTime = (now ?? DateTime.now()).toUtc();
  return !startAt.isAfter(currentTime);
}

/// 강좌 종료 여부를 판별합니다.
///
/// 종료일이 날짜만 포함된 형식(`yyyy-MM-dd`)이면 해당 날짜의 마지막 시각까지
/// 유효한 것으로 간주합니다.
bool isCourseClosed(String? endDate, {DateTime? now}) {
  final deadline = _parseCourseDeadline(endDate);
  if (deadline == null) {
    return false;
  }

  final currentTime = (now ?? DateTime.now()).toUtc();
  return !deadline.isAfter(currentTime);
}

DateTime? _parseCourseStartAt(String? rawStartDate) {
  final normalized = rawStartDate?.trim();
  if (normalized == null || normalized.isEmpty) {
    return null;
  }

  final dateOnlyPattern = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$');
  final dateOnlyMatch = dateOnlyPattern.firstMatch(normalized);
  if (dateOnlyMatch != null) {
    final year = int.parse(dateOnlyMatch.group(1)!);
    final month = int.parse(dateOnlyMatch.group(2)!);
    final day = int.parse(dateOnlyMatch.group(3)!);
    return DateTime.utc(year, month, day);
  }

  final parsed = DateTime.tryParse(normalized);
  if (parsed == null) {
    return null;
  }

  return parsed.isUtc ? parsed : parsed.toUtc();
}

DateTime? _parseCourseDeadline(String? rawEndDate) {
  final normalized = rawEndDate?.trim();
  if (normalized == null || normalized.isEmpty) {
    return null;
  }

  final dateOnlyPattern = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$');
  final dateOnlyMatch = dateOnlyPattern.firstMatch(normalized);
  if (dateOnlyMatch != null) {
    final year = int.parse(dateOnlyMatch.group(1)!);
    final month = int.parse(dateOnlyMatch.group(2)!);
    final day = int.parse(dateOnlyMatch.group(3)!);
    return DateTime.utc(year, month, day, 23, 59, 59, 999);
  }

  final parsed = DateTime.tryParse(normalized);
  if (parsed == null) {
    return null;
  }

  return parsed.isUtc ? parsed : parsed.toUtc();
}
