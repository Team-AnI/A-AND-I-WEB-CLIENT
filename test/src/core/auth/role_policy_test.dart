import 'package:a_and_i_report_web_server/src/core/auth/role_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('canManageArticlesWithRole', () {
    test('USER는 블로그 관리 권한이 없다', () {
      expect(canManageArticlesWithRole('USER'), isFalse);
    });

    test('ORGANIZER는 블로그 관리 권한이 있다', () {
      expect(canManageArticlesWithRole('ORGANIZER'), isTrue);
    });

    test('ADMIN은 블로그 관리 권한이 있다', () {
      expect(canManageArticlesWithRole('ADMIN'), isTrue);
    });

    test('null/빈 문자열은 블로그 관리 권한이 없다', () {
      expect(canManageArticlesWithRole(null), isFalse);
      expect(canManageArticlesWithRole(''), isFalse);
    });
  });
}
