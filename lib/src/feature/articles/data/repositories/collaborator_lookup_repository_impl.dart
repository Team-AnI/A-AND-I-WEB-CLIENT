import 'package:a_and_i_report_web_server/src/feature/articles/data/datasources/collaborator_lookup_remote_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/collaborator_lookup_user.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/collaborator_lookup_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';

/// 협업자 조회 저장소 구현체입니다.
class CollaboratorLookupRepositoryImpl implements CollaboratorLookupRepository {
  /// 협업자 조회 저장소 구현체를 생성합니다.
  const CollaboratorLookupRepositoryImpl({
    required this.collaboratorLookupRemoteDatasource,
    required this.localAuthDatasource,
  });

  /// 협업자 조회 원격 데이터소스입니다.
  final CollaboratorLookupRemoteDatasource collaboratorLookupRemoteDatasource;

  /// 인증 로컬 데이터소스입니다.
  final LocalAuthDatasource localAuthDatasource;

  @override
  Future<CollaboratorLookupUser?> lookupByCode({
    required String code,
  }) async {
    final normalizedCode = code.trim();
    if (normalizedCode.isEmpty) {
      return null;
    }

    final authorization = await _resolveAuthorization();
    final dto = await collaboratorLookupRemoteDatasource.lookupByCode(
      authorization,
      normalizedCode,
    );
    if (dto == null) {
      return null;
    }

    return CollaboratorLookupUser(
      id: dto.id,
      nickname: dto.nickname,
      profileImageUrl: dto.profileImageUrl,
      publicCode: dto.publicCode,
    );
  }

  Future<String> _resolveAuthorization() async {
    final token = await localAuthDatasource.getUserToken();
    if (token == null || token.isEmpty) {
      throw Exception('로그인이 필요합니다.');
    }
    return 'Bearer $token';
  }
}
