import 'dart:typed_data';

import 'package:a_and_i_report_web_server/src/core/models/user.dart';
import 'package:dio/dio.dart';

/// 내 정보 수정 네트워크 오류다.
class UpdateMyProfileNetworkException implements Exception {}

/// 내 정보 수정 요청/응답 오류다.
class UpdateMyProfileRequestException implements Exception {}

/// 비밀번호 변경 네트워크 오류다.
class ChangePasswordNetworkException implements Exception {}

/// 비밀번호 변경 요청/응답 오류다.
class ChangePasswordRequestException implements Exception {}

/// 사용자 프로필 원격 데이터소스다.
class UserProfileRemoteDatasource {
  UserProfileRemoteDatasource(
    this.dio, {
    required String baseUrl,
  }) : _baseUrl = baseUrl;

  final Dio dio;
  final String _baseUrl;

  /// `/v1/me` 내 정보 수정 API를 호출한다.
  Future<User?> updateMyProfile({
    required String authorization,
    String? nickname,
    Uint8List? profileImageBytes,
    String? profileImageFileName,
    String? profileImageMimeType,
  }) async {
    try {
      final formDataMap = <String, dynamic>{};

      final trimmedNickname = nickname?.trim();
      if (trimmedNickname != null && trimmedNickname.isNotEmpty) {
        formDataMap['nickname'] = trimmedNickname;
      }

      if (profileImageBytes != null && profileImageBytes.isNotEmpty) {
        final resolvedFileName = profileImageFileName ??
            _resolveDefaultFileName(profileImageMimeType);
        formDataMap['profileImage'] = MultipartFile.fromBytes(
          profileImageBytes,
          filename: resolvedFileName,
        );
      }

      if (formDataMap.isEmpty) {
        throw UpdateMyProfileRequestException();
      }

      final response = await dio.post(
        _buildUrl('/v1/me'),
        data: FormData.fromMap(formDataMap),
        options: Options(
          headers: {
            'Authorization': authorization,
          },
        ),
      );

      return _parseUser(response);
    } on DioException catch (error) {
      final isNetworkError = error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.unknown;
      if (isNetworkError) {
        throw UpdateMyProfileNetworkException();
      }
      throw UpdateMyProfileRequestException();
    } catch (_) {
      throw UpdateMyProfileRequestException();
    }
  }

  /// `/v1/me/password` 비밀번호 변경 API를 호출한다.
  Future<void> changePassword({
    required String authorization,
    required String newPassword,
  }) async {
    try {
      final trimmedPassword = newPassword.trim();
      if (trimmedPassword.isEmpty) {
        throw ChangePasswordRequestException();
      }

      Response<dynamic> response;
      try {
        response = await dio.post(
          _buildUrl('/v1/me/password'),
          data: {
            'newPassword': trimmedPassword,
          },
          options: Options(
            headers: {
              'Authorization': authorization,
            },
          ),
        );
      } on DioException catch (error) {
        final statusCode = error.response?.statusCode;
        if (statusCode == 400 || statusCode == 422) {
          response = await dio.post(
            _buildUrl('/v1/me/password'),
            data: {
              'password': trimmedPassword,
            },
            options: Options(
              headers: {
                'Authorization': authorization,
              },
            ),
          );
        } else {
          rethrow;
        }
      }

      final responseData = response.data;
      if (responseData is! Map<String, dynamic> ||
          responseData['success'] != true) {
        throw ChangePasswordRequestException();
      }
    } on DioException catch (error) {
      final isNetworkError = error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.unknown;
      if (isNetworkError) {
        throw ChangePasswordNetworkException();
      }
      throw ChangePasswordRequestException();
    } on ChangePasswordRequestException {
      rethrow;
    } catch (_) {
      throw ChangePasswordRequestException();
    }
  }

  String _resolveDefaultFileName(String? mimeType) {
    if (mimeType == null || mimeType.isEmpty) {
      return 'profile.jpg';
    }
    if (mimeType.contains('webp')) {
      return 'profile.webp';
    }
    if (mimeType.contains('png')) {
      return 'profile.png';
    }
    return 'profile.jpg';
  }

  String _buildUrl(String endpoint) {
    if (_baseUrl.trim().isEmpty) {
      return endpoint;
    }
    return Uri.parse(_baseUrl).resolve(endpoint).toString();
  }

  User? _parseUser(Response<dynamic> response) {
    final responseData = response.data;
    if (responseData is! Map<String, dynamic>) {
      throw UpdateMyProfileRequestException();
    }

    final isSuccess = responseData['success'] == true;
    if (!isSuccess) {
      throw UpdateMyProfileRequestException();
    }

    final responseDataField = responseData['data'];
    if (responseDataField is! Map<String, dynamic>) {
      return null;
    }

    final dynamic nestedUser = responseDataField['user'];
    final userData =
        nestedUser is Map<String, dynamic> ? nestedUser : responseDataField;

    final id = userData['id']?.toString() ?? userData['userId']?.toString();
    final role = userData['role']?.toString();
    final nickname =
        userData['nickname']?.toString() ?? userData['username']?.toString();
    if (id == null || role == null || nickname == null || nickname.isEmpty) {
      return null;
    }

    final profileImage = userData['profileImageUrl']?.toString() ??
        userData['profileImagePath']?.toString() ??
        userData['profileImage']?.toString();

    return User(
      id: id,
      role: role,
      nickname: nickname,
      profileImageUrl: profileImage,
    );
  }
}
