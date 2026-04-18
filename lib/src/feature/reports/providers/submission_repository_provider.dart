import 'package:a_and_i_report_web_server/src/core/providers/package_api_client_providers.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/repositories/submission_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/repositories/submission_repository_adapter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_repository_provider.g.dart';

/// 제출 API Repository Provider입니다.
@riverpod
SubmissionRepository submissionRepository(Ref ref) {
  return SubmissionRepositoryAdapter(
    client: ref.read(ojApiClientProvider),
  );
}
