import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';

/// 401 에러 발생 시 자동으로 토큰을 갱신하는 Dio Interceptor
class AuthInterceptor extends QueuedInterceptor {
  static const _retryKey = '__auth_retry__';
  static const _refreshPath = '/v2/auth/refresh';

  final LocalAuthDatasource localAuthDatasource;
  final Dio dio;
  final Future<void> Function(String? refreshToken) onTokenExpired;
  final Future<Response<dynamic>> Function(String refreshToken)?
      requestTokenRefresh;

  AuthInterceptor({
    required this.localAuthDatasource,
    required this.dio,
    required this.onTokenExpired,
    this.requestTokenRefresh,
  });

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final requestOptions = response.requestOptions;
    final isUnauthorized = response.statusCode == 401;
    final isRefreshApi = _isRefreshApi(requestOptions);
    final alreadyRetried = requestOptions.extra[_retryKey] == true;

    if (isUnauthorized && !isRefreshApi && !alreadyRetried) {
      try {
        final retryResponse = await _refreshAndRetry(requestOptions);
        if (retryResponse != null) {
          return handler.resolve(retryResponse);
        }
      } on _SessionExpiredException catch (_) {
        return handler.next(response);
      } catch (e) {
        log('401 응답 처리 중 예외 발생: $e');
      }
    }

    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final isUnauthorized = err.response?.statusCode == 401;
    final isRefreshApi = _isRefreshApi(requestOptions);
    final alreadyRetried = requestOptions.extra[_retryKey] == true;

    // 401 에러 발생 시 토큰 갱신을 시도한다.
    // 헤더가 누락되었더라도 로컬 토큰이 있으면 재발급을 시도해
    // 브라우저/프록시 환경에서의 헤더 유실 케이스를 흡수한다.
    if (isUnauthorized && !isRefreshApi && !alreadyRetried) {
      try {
        final retryResponse = await _refreshAndRetry(requestOptions);
        if (retryResponse != null) {
          return handler.resolve(retryResponse);
        }
      } on _SessionExpiredException catch (_) {
        return handler.reject(err);
      } catch (e) {
        log('토큰 갱신 중 예외 발생: $e');
        return handler.reject(err);
      }
    }

    return handler.next(err);
  }

  Future<Response<dynamic>> _requestTokenRefresh(String refreshToken) {
    final refreshDio = Dio(dio.options.copyWith());

    return refreshDio.post<dynamic>(
      _refreshPath,
      data: {'refreshToken': refreshToken},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'deviceOS': _resolveDeviceOs(),
          'timestamp': DateTime.now().toUtc().toIso8601String(),
        },
      ),
    );
  }

  Future<Response<dynamic>?> _refreshAndRetry(RequestOptions requestOptions) async {
    final authorizationHeader = _readAuthorizationHeader(requestOptions);
    final accessToken = await localAuthDatasource.getUserToken();
    final hasAuthContext =
        _hasToken(authorizationHeader) || _hasToken(accessToken);

    if (!hasAuthContext) {
      return null;
    }

    log('401 에러 발생, 토큰 갱신 시도...');

    final refreshToken = await localAuthDatasource.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      log('리프레시 토큰이 없음, 로그아웃 처리');
      await onTokenExpired(null);
      throw const _SessionExpiredException();
    }

    try {
      final response =
          await (requestTokenRefresh?.call(refreshToken) ??
              _requestTokenRefresh(refreshToken));
      final statusCode = response.statusCode ?? 0;
      if (statusCode < 200 || statusCode >= 300) {
        log('토큰 갱신 실패, 로그아웃 처리');
        await onTokenExpired(refreshToken);
        throw const _SessionExpiredException();
      }

      final newAccessToken = _extractAccessToken(response.data);
      final newRefreshToken = _extractRefreshToken(response.data);

      if (!_hasToken(newAccessToken)) {
        log('토큰 갱신 응답에 accessToken이 없음');
        await onTokenExpired(refreshToken);
        throw const _SessionExpiredException();
      }

      await localAuthDatasource.saveUserToken(newAccessToken!);
      if (_hasToken(newRefreshToken)) {
        await localAuthDatasource.saveRefreshToken(newRefreshToken!);
      }

      log('토큰 갱신 성공');

      final retryOptions = _buildRetryOptions(requestOptions)
        ..extra[_retryKey] = true;
      _setAuthorizationHeader(retryOptions, 'Bearer $newAccessToken');

      return dio.fetch<dynamic>(retryOptions);
    } on DioException catch (e) {
      log('토큰 갱신 중 에러 발생: ${e.response?.statusCode}');
      await onTokenExpired(refreshToken);
      throw const _SessionExpiredException();
    }
  }

  bool _isRefreshApi(RequestOptions options) {
    final parsed = Uri.tryParse(options.path);
    final normalizedPath = parsed?.path ?? options.path;
    return normalizedPath.endsWith(_refreshPath);
  }

  bool _hasToken(String? token) {
    if (token == null) {
      return false;
    }
    return token.trim().isNotEmpty;
  }

  String? _extractAccessToken(dynamic body) {
    final root = _toMap(body);
    if (root == null) {
      return null;
    }
    final data = _toMap(root['data']);
    final token = data?['accessToken'] ?? root['accessToken'];
    return token?.toString();
  }

  String? _extractRefreshToken(dynamic body) {
    final root = _toMap(body);
    if (root == null) {
      return null;
    }
    final data = _toMap(root['data']);
    final token = data?['refreshToken'] ?? root['refreshToken'];
    return token?.toString();
  }

  Map<String, dynamic>? _toMap(dynamic source) {
    if (source is Map<String, dynamic>) {
      return source;
    }
    if (source is Map) {
      return Map<String, dynamic>.from(source);
    }
    return null;
  }

  String? _readAuthorizationHeader(RequestOptions options) {
    for (final entry in options.headers.entries) {
      final key = entry.key.toLowerCase();
      if (key != 'authorization' && key != 'authenticate') {
        continue;
      }
      final value = entry.value?.toString().trim();
      if (value == null || value.isEmpty) {
        return null;
      }
      return value;
    }
    return null;
  }

  void _setAuthorizationHeader(RequestOptions options, String value) {
    final authenticateHeaderKey = options.headers.keys.firstWhere(
      (key) {
        final normalized = key.toLowerCase();
        return normalized == 'authorization' || normalized == 'authenticate';
      },
      orElse: () => 'Authenticate',
    );
    options.headers
      ..removeWhere(
        (key, _) =>
            key.toLowerCase() == 'authorization' ||
            key.toLowerCase() == 'authenticate',
      )
      ..[authenticateHeaderKey == 'Authorization'
              ? 'Authenticate'
              : authenticateHeaderKey] =
          value;
  }

  RequestOptions _buildRetryOptions(RequestOptions source) {
    final data = source.data;
    final clonedData = data is FormData ? data.clone() : data;
    return source.copyWith(data: clonedData);
  }

  String _resolveDeviceOs() {
    if (kIsWeb) {
      return 'web';
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      TargetPlatform.macOS => 'macos',
      TargetPlatform.windows => 'windows',
      TargetPlatform.linux => 'linux',
      TargetPlatform.fuchsia => 'fuchsia',
    };
  }
}

final class _SessionExpiredException implements Exception {
  const _SessionExpiredException();
}
