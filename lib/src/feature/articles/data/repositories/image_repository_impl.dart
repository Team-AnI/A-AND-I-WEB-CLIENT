import 'package:a_and_i_report_web_server/src/feature/articles/data/datasources/image_remote_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/image_upload_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/image_upload_payload.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/image_upload_result.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/image_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';
import 'package:dio/dio.dart';

/// 이미지 업로드 저장소 구현체입니다.
class ImageRepositoryImpl implements ImageRepository {
  /// 이미지 업로드 저장소 구현체를 생성합니다.
  const ImageRepositoryImpl({
    required this.imageRemoteDatasource,
    required this.localAuthDatasource,
  });

  /// 이미지 원격 데이터소스입니다.
  final ImageRemoteDatasource imageRemoteDatasource;

  /// 인증 로컬 데이터소스입니다.
  final LocalAuthDatasource localAuthDatasource;

  @override
  Future<ImageUploadResult> uploadImage({
    required ImageUploadPayload payload,
  }) async {
    final authorization = await _resolveAuthorization();
    final response = await imageRemoteDatasource.uploadImage(
      authorization: authorization,
      file: MultipartFile.fromBytes(
        payload.bytes,
        filename: payload.fileName,
      ),
    );
    return response.toEntity();
  }

  Future<String> _resolveAuthorization() async {
    final token = await localAuthDatasource.getUserToken();
    if (token == null || token.isEmpty) {
      throw Exception('로그인이 필요합니다.');
    }
    return 'Bearer $token';
  }
}

extension on ImageUploadResponseDto {
  /// DTO를 도메인 엔티티로 변환합니다.
  ImageUploadResult toEntity() {
    return ImageUploadResult(
      url: url,
      key: key,
      contentType: contentType,
      size: size,
    );
  }
}
