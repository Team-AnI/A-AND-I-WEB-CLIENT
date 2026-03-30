import 'package:a_and_i_report_web_server/src/feature/articles/data/datasources/collaborator_lookup_remote_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/collaborator_lookup_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/repositories/collaborator_lookup_repository_impl.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CollaboratorLookupRepositoryImpl', () {
    test('lookupByCode는 authorization을 포함해 조회하고 엔티티를 반환한다', () async {
      final datasource = FakeCollaboratorLookupRemoteDatasource();
      final localAuthDatasource = FakeLocalAuthDatasource();
      final repository = CollaboratorLookupRepositoryImpl(
        collaboratorLookupRemoteDatasource: datasource,
        localAuthDatasource: localAuthDatasource,
      );

      final result = await repository.lookupByCode(code: '#OR009');

      expect(datasource.authorization, 'Bearer token');
      expect(datasource.code, '#OR009');
      expect(result, isNotNull);
      expect(result!.id, 'user-1');
      expect(result.nickname, '협업자');
      expect(result.publicCode, '#OR009');
    });

    test('lookupByCode는 공백 코드 입력 시 null을 반환한다', () async {
      final datasource = FakeCollaboratorLookupRemoteDatasource();
      final localAuthDatasource = FakeLocalAuthDatasource();
      final repository = CollaboratorLookupRepositoryImpl(
        collaboratorLookupRemoteDatasource: datasource,
        localAuthDatasource: localAuthDatasource,
      );

      final result = await repository.lookupByCode(code: '   ');

      expect(result, isNull);
      expect(datasource.authorization, isNull);
      expect(datasource.code, isNull);
    });
  });
}

class FakeCollaboratorLookupRemoteDatasource
    implements CollaboratorLookupRemoteDatasource {
  String? authorization;
  String? code;

  @override
  Future<CollaboratorLookupResponseDto?> lookupByCode(
    String authorization,
    String code,
  ) async {
    this.authorization = authorization;
    this.code = code;
    return const CollaboratorLookupResponseDto(
      id: 'user-1',
      nickname: '협업자',
      publicCode: '#OR009',
      profileImageUrl: 'https://example.com/profile.png',
    );
  }
}

class FakeLocalAuthDatasource implements LocalAuthDatasource {
  @override
  Future<void> deleteCachedUserJson() async {}

  @override
  Future<void> deleteRefreshToken() async {}

  @override
  Future<void> deleteUserToken() async {}

  @override
  Future<String?> getCachedUserJson() async {
    return null;
  }

  @override
  Future<String?> getRefreshToken() async {
    return null;
  }

  @override
  Future<String?> getUserToken() async {
    return 'token';
  }

  @override
  Future<void> saveCachedUserJson(String userJson) async {}

  @override
  Future<void> saveRefreshToken(String token) async {}

  @override
  Future<void> saveUserToken(String token) async {}
}
