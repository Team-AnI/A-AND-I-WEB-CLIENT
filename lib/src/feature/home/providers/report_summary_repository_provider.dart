import 'package:a_and_i_report_web_server/src/feature/home/data/repositories/report_summary_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/repositories/report_summary_repository_adapter.dart';
import 'package:a_and_i_report_web_server/src/core/providers/package_api_client_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_summary_repository_provider.g.dart';

@riverpod
ReportSummaryRepository reportSummaryRepository(Ref ref) {
  return ReportSummaryRepositoryAdapter(
    client: ref.read(courseApiClientProvider),
  );
}
