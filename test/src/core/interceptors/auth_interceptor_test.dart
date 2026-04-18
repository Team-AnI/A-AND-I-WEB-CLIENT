import 'package:a_and_i_report_web_server/src/core/interceptors/auth_interceptor.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthInterceptor', () {
    test('validateStatus=true 환경의 401 응답도 토큰을 갱신한 뒤 재시도한다', () async {
      final localAuthDatasource = _FakeLocalAuthDatasource(
        accessToken: 'expired-access-token',
        refreshToken: 'refresh-token',
      );
      final dio = Dio();
      var protectedRequestCount = 0;
      var refreshRequestCount = 0;

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            if (options.path == '/v2/auth/refresh') {
              refreshRequestCount += 1;
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  statusCode: 200,
                  data: <String, dynamic>{
                    'data': <String, dynamic>{
                      'accessToken': 'new-access-token',
                      'refreshToken': 'new-refresh-token',
                    },
                  },
                ),
              );
              return;
            }

            protectedRequestCount += 1;
            final authorization =
                options.headers['Authenticate']?.toString() ?? '';
            if (authorization == 'Bearer new-access-token') {
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  statusCode: 200,
                  data: <String, dynamic>{'success': true},
                ),
              );
              return;
            }

            handler.resolve(
              Response<Map<String, dynamic>>(
                requestOptions: options,
                statusCode: 401,
                data: <String, dynamic>{'success': false},
              ),
            );
          },
        ),
      );
      final interceptor = AuthInterceptor(
        localAuthDatasource: localAuthDatasource,
        dio: dio,
        onTokenExpired: (_) async {},
        requestTokenRefresh: (refreshToken) async {
          refreshRequestCount += 1;
          return Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/v2/auth/refresh'),
            statusCode: 200,
            data: <String, dynamic>{
              'data': <String, dynamic>{
                'accessToken': 'new-access-token',
                'refreshToken': 'new-refresh-token',
              },
            },
          );
        },
      );
      final handler = _TestResponseInterceptorHandler();

      await interceptor.onResponse(
        Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/v1/protected'),
          statusCode: 401,
          data: <String, dynamic>{'success': false},
        ),
        handler,
      );
      final responseState = await handler.result as dynamic;
      final response = responseState.data as Response<dynamic>;

      expect(response.statusCode, 200);
      expect(protectedRequestCount, 1);
      expect(refreshRequestCount, 1);
      expect(await localAuthDatasource.getUserToken(), 'new-access-token');
      expect(await localAuthDatasource.getRefreshToken(), 'new-refresh-token');
    });

    test('토큰 갱신이 실패하면 세션 만료 콜백을 호출한다', () async {
      final localAuthDatasource = _FakeLocalAuthDatasource(
        accessToken: 'expired-access-token',
        refreshToken: 'refresh-token',
      );
      final dio = Dio();
      final expiredRefreshTokens = <String?>[];

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            if (options.path == '/v2/auth/refresh') {
              handler.reject(
                DioException(
                  requestOptions: options,
                  response: Response<Map<String, dynamic>>(
                    requestOptions: options,
                    statusCode: 401,
                    data: <String, dynamic>{'success': false},
                  ),
                  type: DioExceptionType.badResponse,
                ),
              );
              return;
            }

            handler.resolve(
              Response<Map<String, dynamic>>(
                requestOptions: options,
                statusCode: 401,
                data: <String, dynamic>{'success': false},
              ),
            );
          },
        ),
      );
      final interceptor = AuthInterceptor(
        localAuthDatasource: localAuthDatasource,
        dio: dio,
        onTokenExpired: (refreshToken) async {
          expiredRefreshTokens.add(refreshToken);
        },
        requestTokenRefresh: (refreshToken) async {
          throw DioException(
            requestOptions: RequestOptions(path: '/v2/auth/refresh'),
            response: Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(path: '/v2/auth/refresh'),
              statusCode: 401,
              data: <String, dynamic>{'success': false},
            ),
            type: DioExceptionType.badResponse,
          );
        },
      );
      final handler = _TestResponseInterceptorHandler();

      await interceptor.onResponse(
        Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/v1/protected'),
          statusCode: 401,
          data: <String, dynamic>{'success': false},
        ),
        handler,
      );
      final responseState = await handler.result as dynamic;
      final response = responseState.data as Response<dynamic>;

      expect(response.statusCode, 401);
      expect(expiredRefreshTokens, <String?>['refresh-token']);
    });
  });
}

final class _FakeLocalAuthDatasource implements LocalAuthDatasource {
  _FakeLocalAuthDatasource({
    this.accessToken,
    this.refreshToken,
  });

  String? accessToken;
  String? refreshToken;
  String? cachedUserJson;

  @override
  Future<void> deleteCachedUserJson() async {
    cachedUserJson = null;
  }

  @override
  Future<void> deleteRefreshToken() async {
    refreshToken = null;
  }

  @override
  Future<void> deleteUserToken() async {
    accessToken = null;
  }

  @override
  Future<String?> getCachedUserJson() async => cachedUserJson;

  @override
  Future<String?> getRefreshToken() async => refreshToken;

  @override
  Future<String?> getUserToken() async => accessToken;

  @override
  Future<void> saveCachedUserJson(String userJson) async {
    cachedUserJson = userJson;
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    refreshToken = token;
  }

  @override
  Future<void> saveUserToken(String token) async {
    accessToken = token;
  }
}

final class _TestResponseInterceptorHandler extends ResponseInterceptorHandler {
  Future<Object> get result => future;
}
