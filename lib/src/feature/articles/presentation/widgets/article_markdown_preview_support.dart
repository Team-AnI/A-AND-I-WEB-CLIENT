import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:re_highlight/languages/dart.dart';
import 'package:re_highlight/languages/kotlin.dart';
import 'package:re_highlight/languages/python.dart';
import 'package:re_highlight/re_highlight.dart';
import 'package:re_highlight/styles/atom-one-dark.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';

String normalizeMarkdownForPreview(String source) {
  return source
      .replaceAllMapped(RegExp(r'>\s*\n([^\n])'), (m) => '> ${m.group(1)}')
      .replaceAllMapped(
        RegExp(r'(^|\n)>\s*\n(?=\n|$)'),
        (m) => '${m.group(1)}> ',
      );
}

MarkdownStyleSheet createArticlePreviewMarkdownStyle(BuildContext context) {
  return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
    p: const TextStyle(
      color: Color(0xFF374151),
      fontSize: 16,
      height: 1.8,
    ),
    h1: const TextStyle(
      color: HomeTheme.textMain,
      fontSize: 42,
      fontWeight: FontWeight.w800,
      height: 1.15,
      letterSpacing: -1.2,
    ),
    h2: const TextStyle(
      color: HomeTheme.textMain,
      fontSize: 30,
      fontWeight: FontWeight.w800,
      height: 1.25,
      letterSpacing: -0.8,
    ),
    h3: const TextStyle(
      color: HomeTheme.textMain,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.35,
      letterSpacing: -0.3,
    ),
    h4: const TextStyle(
      color: HomeTheme.textMain,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 1.4,
    ),
    h5: const TextStyle(
      color: HomeTheme.textMain,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 1.45,
    ),
    h6: const TextStyle(
      color: HomeTheme.textMain,
      fontSize: 17,
      fontWeight: FontWeight.w700,
      height: 1.5,
    ),
    strong: const TextStyle(
      color: HomeTheme.textMain,
      fontWeight: FontWeight.w700,
    ),
    em: const TextStyle(
      color: Color(0xFF4B5563),
      fontStyle: FontStyle.italic,
    ),
    a: const TextStyle(
      color: Color(0xFF16439C),
      decoration: TextDecoration.none,
    ),
    blockSpacing: 22,
    blockquote: const TextStyle(
      color: Color(0xFF4B5563),
      fontStyle: FontStyle.italic,
      height: 1.8,
    ),
    blockquotePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    blockquoteDecoration: BoxDecoration(
      color: const Color(0xFFF9FAFB),
      borderRadius: BorderRadius.circular(8),
      border: const Border(
        left: BorderSide(
          color: Color(0xFF111827),
          width: 4,
        ),
      ),
    ),
    listBullet: const TextStyle(
      color: HomeTheme.primary,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    code: const TextStyle(
      fontSize: 14,
      height: 1.45,
      fontFamily: 'monospace',
      color: Color(0xFF111827),
      backgroundColor: Color(0xFFEFF1F5),
      fontWeight: FontWeight.w600,
    ),
    codeblockPadding: const EdgeInsets.all(14),
    codeblockDecoration: BoxDecoration(
      color: const Color(0xFF111827),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF1F2937)),
    ),
    horizontalRuleDecoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
      ),
    ),
  );
}

class ArticleMarkdownCodeSyntaxHighlighter extends SyntaxHighlighter {
  ArticleMarkdownCodeSyntaxHighlighter() {
    highlighter.registerLanguage('dart', langDart);
    highlighter.registerLanguage('kotlin', langKotlin);
    highlighter.registerLanguage('python', langPython);
  }

  final Highlight highlighter = Highlight();

  @override
  TextSpan format(String source) {
    final code = source.replaceAll(RegExp(r'\n$'), '');
    if (code.isEmpty) {
      return const TextSpan(text: '');
    }

    const baseStyle = TextStyle(
      fontSize: 13,
      height: 1.6,
      fontFamily: 'monospace',
      color: Color(0xFFE5E7EB),
    );

    try {
      final result = highlighter.highlightAuto(
        code,
        ['dart', 'kotlin', 'python'],
      );
      final renderer = TextSpanRenderer(baseStyle, atomOneDarkTheme);
      result.render(renderer);
      return renderer.span ?? const TextSpan(text: '', style: baseStyle);
    } catch (_) {
      return TextSpan(text: code, style: baseStyle);
    }
  }
}
