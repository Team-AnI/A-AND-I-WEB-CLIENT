import 'package:a_and_i_report_web_server/src/feature/reports/data/repositories/report_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/data/repositories/report_repository_adapter.dart';
import 'package:a_and_i_report_web_server/src/core/providers/package_api_client_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_repository_provider.g.dart';

@riverpod
ReportRepository reportRepository(Ref ref) {
  return ReportRepositoryAdapter(
    client: ref.read(courseApiClientProvider),
  );
}
