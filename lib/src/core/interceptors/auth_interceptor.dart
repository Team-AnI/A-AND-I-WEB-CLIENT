import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';

/// 401 에러 발생 시 자동으로 토큰을 갱신하는 Dio Interceptor
class AuthInterceptor extends QueuedInterceptor {
  static const _retryKey = '__auth_retry__';
  static const _refreshPath = '/v1/auth/refresh';

  final LocalAuthDatasource localAuthDatasource;
  final Dio dio;
  final Future<void> Function(String? refreshToken) onTokenExpired;

  AuthInterceptor({
    required this.localAuthDatasource,
    required this.dio,
    required this.onTokenExpired,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final hasAuthHeader = requestOptions.headers['Authorization'] != null;
    final isUnauthorized = err.response?.statusCode == 401;
    final isRefreshApi = requestOptions.path.endsWith(_refreshPath);
    final alreadyRetried = requestOptions.extra[_retryKey] == true;

    // Authorization 헤더가 포함된 요청 + 401 에러에서만 토큰 갱신 시도
    if (isUnauthorized && hasAuthHeader && !isRefreshApi && !alreadyRetried) {
      String? refreshToken;
      try {
        log('401 에러 발생, 토큰 갱신 시도...');

        // 리프레시 토큰 조회
        refreshToken = await localAuthDatasource.getRefreshToken();
        if (refreshToken == null || refreshToken.isEmpty) {
          log('리프레시 토큰이 없음, 로그아웃 처리');
          await onTokenExpired(null);
          return handler.reject(err);
        }

        // 토큰 갱신 API 호출
        final response = await dio.post(
          _refreshPath,
          data: {'refreshToken': refreshToken},
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );

        // 응답 데이터 안전하게 파싱
        if (response.statusCode == 200 && response.data is Map) {
          final responseData = response.data as Map;
          final data = responseData['data'];
          if (responseData['success'] == true && data is Map) {
            final newAccessToken = data['accessToken']?.toString();
            final newRefreshToken = data['refreshToken']?.toString();

            if (newAccessToken == null || newAccessToken.isEmpty) {
              log('토큰 갱신 응답에 accessToken이 없음');
              await onTokenExpired(refreshToken);
              return handler.reject(err);
            }

            // 새 토큰 저장 (refreshToken은 내려준 경우에만 갱신)
            await localAuthDatasource.saveUserToken(newAccessToken);
            if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
              await localAuthDatasource.saveRefreshToken(newRefreshToken);
            }

            log('토큰 갱신 성공');

            // 원래 요청 재시도 (무한 재시도 방지 플래그 포함)
            requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
            requestOptions.extra[_retryKey] = true;

            final retryResponse = await dio.fetch(requestOptions);
            return handler.resolve(retryResponse);
          } else {
            log('토큰 갱신 응답 포맷이 유효하지 않음');
            await onTokenExpired(refreshToken);
            return handler.reject(err);
          }
        } else {
          log('토큰 갱신 실패, 로그아웃 처리');
          await onTokenExpired(refreshToken);
          return handler.reject(err);
        }
      } on DioException catch (e) {
        log('토큰 갱신 중 에러 발생: ${e.response?.statusCode}');
        // 리프레시 토큰도 만료된 경우 (401)
        if (e.response?.statusCode == 401) {
          log('리프레시 토큰 만료, 로그아웃 처리');
          await onTokenExpired(refreshToken);
        }
        return handler.reject(err);
      } catch (e) {
        log('토큰 갱신 중 예외 발생: $e');
        return handler.reject(err);
      }
    }

    return handler.next(err);
  }
}
