import 'package:a_and_i_report_web_server/src/core/network/api_failure_exception.dart';
import 'package:a_and_i_report_web_server/src/core/network/base_response.dart';
import 'package:a_and_i_report_web_server/src/core/utils/app_messenger.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 공통 헤더 주입과 envelope 기반 에러 처리를 담당하는 Interceptor 입니다.
class ApiInterceptor extends Interceptor {
  static const _alertHandledKey = '__api_alert_handled__';

  ApiInterceptor({
    required this.localAuthDatasource,
  });

  final LocalAuthDatasource localAuthDatasource;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.putIfAbsent('deviceOS', _resolveDeviceOs);
    options.headers.putIfAbsent('timestamp', _resolveTimestamp);

    final hasAuthenticationHeader = options.headers.keys.any((key) {
      final normalized = key.toLowerCase();
      return normalized == 'authorization' || normalized == 'authenticate';
    });
    if (!hasAuthenticationHeader && !_isAuthEndpoint(options.path)) {
      final accessToken = await localAuthDatasource.getUserToken();
      if (accessToken != null && accessToken.trim().isNotEmpty) {
        options.headers['Authenticate'] = 'Bearer ${accessToken.trim()}';
      }
    }

    _normalizeAuthenticateHeader(options.headers);

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final failure = _extractFailure(response);
    if (failure != null) {
      _showAlert(failure.error?.alert ?? failure.error?.message);
      response.requestOptions.extra[_alertHandledKey] = true;

      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: failure,
          message: failure.message,
        ),
      );
      return;
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final alreadyHandled = err.requestOptions.extra[_alertHandledKey] == true;
    if (!alreadyHandled) {
      final failure = _extractFailure(err.response);
      final alert = failure?.error?.alert ?? _extractAlert(err.response?.data);
      _showAlert(alert);
      err.requestOptions.extra[_alertHandledKey] = true;
    }

    handler.next(err);
  }

  ApiFailureException? _extractFailure(Response<dynamic>? response) {
    final data = response?.data;
    if (data is! Map<String, dynamic>) {
      return null;
    }

    final hasSuccess = data.containsKey('success');
    if (!hasSuccess || data['success'] == true) {
      return null;
    }

    return ApiFailureException(
      statusCode: response?.statusCode,
      error: BaseResponseError.fromNullableJson(data['error']),
      timestamp: data['timestamp']?.toString(),
    );
  }

  String? _extractAlert(Object? raw) {
    if (raw is! Map<String, dynamic>) {
      return null;
    }

    final error = raw['error'];
    if (error is! Map<String, dynamic>) {
      return null;
    }

    final alert = error['alert']?.toString().trim();
    if (alert != null && alert.isNotEmpty) {
      return alert;
    }

    final message = error['message']?.toString().trim();
    if (message != null && message.isNotEmpty) {
      return message;
    }

    return null;
  }

  void _showAlert(String? message) {
    final normalized = message?.trim();
    if (normalized == null || normalized.isEmpty) {
      return;
    }
    showGlobalSnackBar(normalized);
  }

  bool _isAuthEndpoint(String path) {
    final normalizedPath = Uri.tryParse(path)?.path ?? path;
    return normalizedPath.startsWith('/v1/auth/') ||
        normalizedPath.startsWith('/v2/auth/') ||
        normalizedPath == '/v2/activate';
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

  String _resolveTimestamp() {
    return DateTime.now().toUtc().toIso8601String();
  }

  void _normalizeAuthenticateHeader(Map<String, dynamic> headers) {
    final authorizationKey = headers.keys.firstWhere(
      (key) => key.toLowerCase() == 'authorization',
      orElse: () => '',
    );
    final authenticateKey = headers.keys.firstWhere(
      (key) => key.toLowerCase() == 'authenticate',
      orElse: () => '',
    );

    final rawValue =
        (authenticateKey.isNotEmpty ? headers[authenticateKey] : null) ??
        (authorizationKey.isNotEmpty ? headers[authorizationKey] : null);
    final normalizedValue = rawValue?.toString().trim();
    if (normalizedValue == null || normalizedValue.isEmpty) {
      return;
    }

    if (authorizationKey.isNotEmpty) {
      headers.remove(authorizationKey);
    }
    if (authenticateKey.isNotEmpty) {
      headers.remove(authenticateKey);
    }

    headers['Authenticate'] =
        normalizedValue.toLowerCase().startsWith('bearer ')
            ? normalizedValue
            : 'Bearer $normalizedValue';
  }
}
