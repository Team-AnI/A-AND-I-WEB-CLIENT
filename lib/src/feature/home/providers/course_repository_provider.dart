import 'package:a_and_i_report_web_server/src/core/providers/package_api_client_providers.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/repositories/course_repository_adapter.dart';
import 'package:a_and_i_report_web_server/src/feature/home/data/repositories/course_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_repository_provider.g.dart';

@riverpod
CourseRepository courseRepository(Ref ref) {
  return CourseRepositoryAdapter(
    client: ref.read(courseApiClientProvider),
  );
}
