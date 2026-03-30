import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/content_io_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContentIOView', () {
    testWidgets('입력이 없으면 안내 문구를 표시하고 복사 버튼은 숨긴다', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ContentIOView(contents: [('', '출력 예시')]),
          ),
        ),
      );

      expect(find.text('입력 파라미터가 존재하지 않습니다.'), findsOneWidget);
      expect(find.byIcon(Icons.copy), findsNothing);
      expect(find.text('출력 예시'), findsOneWidget);
    });

    testWidgets('출력이 없으면 안내 문구를 표시한다', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ContentIOView(contents: [('입력 예시', '')]),
          ),
        ),
      );

      expect(find.text('입력 예시'), findsOneWidget);
      expect(find.text('반환값이 존재하지 않습니다.'), findsOneWidget);
    });
  });
}
