import 'package:a_and_i_report_web_server/src/core/utils/app_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContentIOView extends StatelessWidget {
  final List<(String, String)> contents;
  const ContentIOView({super.key, required this.contents});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(contents.length, (index) {
        final hasInput = contents[index].$1.trim().isNotEmpty;
        final hasOutput = contents[index].$2.trim().isNotEmpty;
        final displayInput =
            hasInput ? contents[index].$1 : '입력 파라미터가 존재하지 않습니다.';
        final displayOutput =
            hasOutput ? contents[index].$2 : '반환값이 존재하지 않습니다.';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Row(
                children: [
                  Text(
                    "예제 입력${index + 1}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (hasInput)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(text: contents[index].$1),
                          );
                          showGlobalSnackBar(
                            '예제 입력 ${index + 1}를 복사했습니다.',
                          );
                        },
                        child: Icon(
                          Icons.copy,
                          color:
                              const Color(0xff000000).withValues(alpha: 0.48),
                          size: 15,
                        ),
                      ),
                    )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xffefefef),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                displayInput,
                style: TextStyle(
                    color: const Color(0xff000000).withValues(alpha: .48),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                "예제 출력${index + 1}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xffefefef),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                displayOutput,
                style: TextStyle(
                    color: const Color(0xff000000).withValues(alpha: .48),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      }),
    );
  }
}
