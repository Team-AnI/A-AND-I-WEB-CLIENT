import 'package:a_and_i_report_web_server/src/feature/auth/providers/auth_repository_provider.dart';
import 'package:a_and_i_report_web_server/src/core/providers/package_api_client_providers.dart';
import 'package:a_and_i_report_web_server/src/feature/home/domain/usecases/get_course_by_slug_usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_course_by_slug_usecase_provider.g.dart';

@riverpod
GetCourseBySlugUsecase getCourseBySlugUsecase(Ref ref) {
  return GetCourseBySlugUsecaseImpl(
    courseApiClient: ref.read(courseApiClientProvider),
    authRepository: ref.read(authRepositoryProvider),
  );
}
