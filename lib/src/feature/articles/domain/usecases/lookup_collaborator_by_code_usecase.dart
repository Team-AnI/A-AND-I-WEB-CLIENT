import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/collaborator_lookup_user.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/collaborator_lookup_repository.dart';

/// 공개 코드로 협업자를 조회하는 유스케이스입니다.
class LookupCollaboratorByCodeUsecase {
  /// 공개 코드로 협업자를 조회하는 유스케이스를 생성합니다.
  const LookupCollaboratorByCodeUsecase(this._repository);

  final CollaboratorLookupRepository _repository;

  /// 공개 코드로 협업자를 조회합니다.
  Future<CollaboratorLookupUser?> call({
    required String code,
  }) {
    return _repository.lookupByCode(code: code);
  }
}
