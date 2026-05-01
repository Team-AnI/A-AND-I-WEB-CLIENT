import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

/// 로그인 API의 최상위 응답 DTO(ApiResponseLoginResponse)입니다.
@freezed
abstract class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    required bool success,
    LoginDataDto? data,
    ApiErrorDto? error,
    String? timestamp,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);
}

/// 로그인 API의 data 필드 DTO입니다.
@freezed
abstract class LoginDataDto with _$LoginDataDto {
  const factory LoginDataDto({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    String? tokenType,
    @Default(false) bool forcePasswordChange,
    required LoginUserDto user,
  }) = _LoginDataDto;

  factory LoginDataDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDataDtoFromJson(json);
}

/// 로그인 사용자 정보 DTO입니다.
@freezed
abstract class LoginUserDto with _$LoginUserDto {
  const factory LoginUserDto({
    required String id,
    required String username,
    required String role,
    String? publicCode,
  }) = _LoginUserDto;

  factory LoginUserDto.fromJson(Map<String, dynamic> json) =>
      _$LoginUserDtoFromJson(json);
}

/// 공통 API 에러 DTO입니다.
@freezed
abstract class ApiErrorDto with _$ApiErrorDto {
  const factory ApiErrorDto({
    int? code,
    String? message,
    String? value,
    String? alert,
  }) = _ApiErrorDto;

  factory ApiErrorDto.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorDtoFromJson(json);
}

/// v2 토큰 재발급 API의 최상위 응답 DTO입니다.
@freezed
abstract class RefreshTokenResponseDto with _$RefreshTokenResponseDto {
  const factory RefreshTokenResponseDto({
    required bool success,
    RefreshTokenDataDto? data,
    ApiErrorDto? error,
    String? timestamp,
  }) = _RefreshTokenResponseDto;

  factory RefreshTokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseDtoFromJson(json);
}

/// v2 토큰 재발급 API의 data 필드 DTO입니다.
@freezed
abstract class RefreshTokenDataDto with _$RefreshTokenDataDto {
  const factory RefreshTokenDataDto({
    required String accessToken,
    required int expiresIn,
  }) = _RefreshTokenDataDto;

  factory RefreshTokenDataDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDataDtoFromJson(json);
}
