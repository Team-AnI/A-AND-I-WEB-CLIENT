import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/collaborator_lookup_response_dto.dart';
import 'package:dio/dio.dart';

/// 협업자 조회 원격 데이터소스 인터페이스입니다.
abstract class CollaboratorLookupRemoteDatasource {
  /// 공개 코드로 협업자 정보를 조회합니다.
  Future<CollaboratorLookupResponseDto?> lookupByCode(
    String authorization,
    String code,
  );
}

/// 협업자 조회 원격 데이터소스 구현체입니다.
class CollaboratorLookupRemoteDatasourceImpl
    implements CollaboratorLookupRemoteDatasource {
  /// 협업자 조회 원격 데이터소스 구현체를 생성합니다.
  const CollaboratorLookupRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<CollaboratorLookupResponseDto?> lookupByCode(
    String authorization,
    String code,
  ) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/v1/users/lookup',
        queryParameters: <String, dynamic>{
          'code': code,
        },
        options: Options(
          contentType: 'application/json',
          headers: <String, dynamic>{
            'Authorization': authorization,
          },
        ),
      );

      final responseData = response.data ?? <String, dynamic>{};
      final payload = _extractPayload(responseData);
      if (payload == null) {
        return null;
      }
      return CollaboratorLookupResponseDto.fromJson(payload);
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }

  Map<String, dynamic>? _extractPayload(Map<String, dynamic> responseData) {
    final data = responseData['data'];
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }
}
