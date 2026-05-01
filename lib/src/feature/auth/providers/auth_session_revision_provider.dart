import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 인증 세션 갱신 시점을 추적하는 리비전 Provider입니다.
///
/// 토큰 재발급이나 재로그인 이후 보호된 화면의 조회 Provider가
/// 자동으로 다시 실행될 수 있도록 증가값을 노출합니다.
final authSessionRevisionProvider = StateProvider<int>((ref) => 0);
