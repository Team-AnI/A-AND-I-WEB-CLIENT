# aandi_api_endpoints

A&I 웹 플랫폼에서 공통으로 사용하는 서버 API 엔드포인트 템플릿/경로 빌더 패키지입니다.

## 제공 타입

- `AandiApiEndpointTemplate`
  - Retrofit 어노테이션에 사용할 템플릿 문자열 제공
- `AandiApiEndpointPath`
  - 런타임에서 실제 경로 문자열 생성
- `AandiApiUrlResolver`
  - `baseUrl + endpoint` 조합 유틸리티 제공
