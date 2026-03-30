import 'dart:typed_data';

import 'package:a_and_i_report_web_server/src/feature/articles/data/datasources/image_remote_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/image_upload_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/repositories/image_repository_impl.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/image_upload_payload.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ImageRepositoryImpl', () {
    test('uploadImage는 파일을 전달하고 ImageUploadResult로 변환한다', () async {
      final datasource = FakeImageRemoteDatasource();
      final localAuthDatasource = FakeLocalAuthDatasource();
      final repository = ImageRepositoryImpl(
        imageRemoteDatasource: datasource,
        localAuthDatasource: localAuthDatasource,
      );
      final bytes = Uint8List.fromList(<int>[1, 2, 3, 4]);

      final result = await repository.uploadImage(
        payload: ImageUploadPayload(
          fileName: 'sample.png',
          bytes: bytes,
        ),
      );

      expect(datasource.authorization, 'Bearer token');
      final uploadedFile = datasource.file;
      expect(uploadedFile, isNotNull);
      expect(uploadedFile!.filename, 'sample.png');
      expect(uploadedFile.length, 4);
      expect(result.url, 'https://cdn.example.com/sample.png');
      expect(result.key, 'posts/sample.png');
      expect(result.contentType, 'image/png');
      expect(result.size, 4);
    });
  });
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

class FakeImageRemoteDatasource implements ImageRemoteDatasource {
  String? authorization;
  MultipartFile? file;

  @override
  Future<ImageUploadResponseDto> uploadImage({
    required String authorization,
    required MultipartFile file,
  }) async {
    this.authorization = authorization;
    this.file = file;
    return const ImageUploadResponseDto(
      url: 'https://cdn.example.com/sample.png',
      key: 'posts/sample.png',
      contentType: 'image/png',
      size: 4,
    );
  }
}
