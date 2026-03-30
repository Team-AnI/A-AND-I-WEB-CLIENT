import 'package:a_and_i_report_web_server/src/core/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    test('publicCode를 JSON으로 직렬화/역직렬화한다', () {
      const user = User(
        id: 'user-1',
        nickname: '멘토',
        role: 'ORGANIZER',
        profileImageUrl: 'https://example.com/profile.png',
        publicCode: 'ABC123',
      );

      final json = user.toJson();
      expect(json['publicCode'], 'ABC123');

      final parsed = User.fromJson(json);
      expect(parsed.publicCode, 'ABC123');
    });
  });
}
