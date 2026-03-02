import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/collaborator_lookup_user.dart';

/// 협업자 조회 저장소 인터페이스입니다.
abstract class CollaboratorLookupRepository {
  /// 공개 코드로 협업자 정보를 조회합니다.
  Future<CollaboratorLookupUser?> lookupByCode({
    required String code,
  });
}
