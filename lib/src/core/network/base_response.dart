/// 서버의 공통 응답 envelope 입니다.
class BaseResponse<T> {
  const BaseResponse({
    required this.success,
    this.data,
    this.error,
    this.timestamp,
  });

  final bool success;
  final T? data;
  final BaseResponseError? error;
  final String? timestamp;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T? Function(Object? rawData) fromData,
  ) {
    return BaseResponse<T>(
      success: json['success'] == true,
      data: fromData(json['data']),
      error: BaseResponseError.fromNullableJson(json['error']),
      timestamp: json['timestamp']?.toString(),
    );
  }
}

/// 서버의 공통 에러 payload 입니다.
class BaseResponseError {
  const BaseResponseError({
    this.code,
    this.message,
    this.value,
    this.alert,
  });

  final int? code;
  final String? message;
  final String? value;
  final String? alert;

  factory BaseResponseError.fromJson(Map<String, dynamic> json) {
    return BaseResponseError(
      code: _asInt(json['code']),
      message: json['message']?.toString(),
      value: json['value']?.toString(),
      alert: json['alert']?.toString(),
    );
  }

  static BaseResponseError? fromNullableJson(Object? raw) {
    if (raw is! Map<String, dynamic>) {
      return null;
    }
    return BaseResponseError.fromJson(raw);
  }

  static int? _asInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '');
  }
}
