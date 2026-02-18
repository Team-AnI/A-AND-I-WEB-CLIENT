import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/presentation/widgets/article_markdown_preview_support.dart';

class ArticlePreviewPanel extends StatelessWidget {
  const ArticlePreviewPanel({
    super.key,
    required this.title,
    required this.markdown,
  });

  static final SyntaxHighlighter codeSyntaxHighlighter =
      ArticleMarkdownCodeSyntaxHighlighter();

  final String title;
  final String markdown;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final horizontalPadding = isMobile ? 20.0 : (width < 1200 ? 28.0 : 40.0);
    final verticalPadding = isMobile ? 20.0 : (width < 1200 ? 28.0 : 38.0);
    final displayTitle = title.isEmpty ? '미리보기 제목' : title;
    final normalizedMarkdown = normalizeMarkdownForPreview(markdown);
    final hasBody = normalizedMarkdown.trim().isNotEmpty;
    final markdownStyle = createArticlePreviewMarkdownStyle(context);

    return Container(
      color: const Color(0xFFFAFAFA),
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            verticalPadding,
            horizontalPadding,
            40,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      displayTitle,
                      style: TextStyle(
                        color: HomeTheme.textMain,
                        fontSize: isMobile ? 34 : 46,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 28),
                    if (hasBody)
                      MarkdownBody(
                        data: normalizedMarkdown,
                        selectable: true,
                        fitContent: false,
                        styleSheet: markdownStyle,
                        syntaxHighlighter: codeSyntaxHighlighter,
                      )
                    else
                      const Text(
                        '본문을 입력하면 프리뷰가 표시됩니다.',
                        style: TextStyle(
                          color: HomeTheme.textMuted,
                          fontSize: 16,
                          height: 1.8,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
