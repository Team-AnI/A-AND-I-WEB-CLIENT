/// API base URL과 endpoint 경로를 안전하게 합성하는 유틸리티다.
final class AandiApiUrlResolver {
  const AandiApiUrlResolver._();

  /// [baseUrl]이 비어 있으면 [endpoint]를 그대로 반환한다.
  ///
  /// [baseUrl]이 있으면 표준 URI resolve 규칙으로 절대 URL을 만든다.
  static String resolve(String baseUrl, String endpoint) {
    if (baseUrl.trim().isEmpty) {
      return endpoint;
    }

    return Uri.parse(baseUrl).resolve(endpoint).toString();
  }
}
