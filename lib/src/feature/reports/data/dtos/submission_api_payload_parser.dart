import 'package:a_and_i_report_web_server/src/feature/reports/data/dtos/submission_result_response_dto.dart';

/// 제출 관련 API 응답 본문을 실제 데이터 페이로드로 정규화합니다.
final class SubmissionApiPayloadParser {
  const SubmissionApiPayloadParser._();

  /// 제출 상세 응답에서 실제 제출 결과 payload를 추출합니다.
  static SubmissionResultResponseDto? parseSubmissionResult(Object? raw) {
    final payload = _unwrapResultPayload(raw);
    if (payload == null) {
      return null;
    }

    return SubmissionResultResponseDto.fromJson(payload);
  }

  /// 제출 이력 응답에서 실제 제출 목록 payload를 추출합니다.
  static List<SubmissionResultResponseDto> parseSubmissionList(Object? raw) {
    final payload = _unwrapListPayload(raw);
    return payload
        .map(SubmissionResultResponseDto.fromJson)
        .toList(growable: false);
  }

  static Map<String, dynamic>? _unwrapResultPayload(Object? raw) {
    if (raw is! Map<String, dynamic>) {
      return null;
    }

    if (_looksLikeSubmissionResult(raw)) {
      return raw;
    }

    final data = raw['data'];
    if (data is Map<String, dynamic>) {
      if (_looksLikeSubmissionResult(data)) {
        return data;
      }

      final nestedCandidates = <Object?>[
        data['submission'],
        data['result'],
        data['item'],
      ];
      for (final candidate in nestedCandidates) {
        if (candidate is Map<String, dynamic> &&
            _looksLikeSubmissionResult(candidate)) {
          return candidate;
        }
      }
    }

    final directCandidates = <Object?>[
      raw['submission'],
      raw['result'],
      raw['item'],
    ];
    for (final candidate in directCandidates) {
      if (candidate is Map<String, dynamic> &&
          _looksLikeSubmissionResult(candidate)) {
        return candidate;
      }
    }

    return null;
  }

  static List<Map<String, dynamic>> _unwrapListPayload(Object? raw) {
    if (raw is List) {
      return raw.whereType<Map<String, dynamic>>().toList(growable: false);
    }

    if (raw is! Map<String, dynamic>) {
      return const <Map<String, dynamic>>[];
    }

    final directCandidates = <Object?>[
      raw['data'],
      raw['submissions'],
      raw['items'],
      raw['results'],
    ];
    for (final candidate in directCandidates) {
      final list = _extractList(candidate);
      if (list.isNotEmpty) {
        return list;
      }
    }

    final data = raw['data'];
    if (data is Map<String, dynamic>) {
      final nestedCandidates = <Object?>[
        data['submissions'],
        data['items'],
        data['results'],
        data['content'],
      ];
      for (final candidate in nestedCandidates) {
        final list = _extractList(candidate);
        if (list.isNotEmpty) {
          return list;
        }
      }
    }

    return const <Map<String, dynamic>>[];
  }

  static List<Map<String, dynamic>> _extractList(Object? raw) {
    if (raw is! List) {
      return const <Map<String, dynamic>>[];
    }

    return raw.whereType<Map<String, dynamic>>().toList(growable: false);
  }

  static bool _looksLikeSubmissionResult(Map<String, dynamic> json) {
    final submissionId = json['submissionId']?.toString().trim();
    final status = json['status']?.toString().trim();
    return submissionId != null &&
        submissionId.isNotEmpty &&
        status != null &&
        status.isNotEmpty;
  }
}
