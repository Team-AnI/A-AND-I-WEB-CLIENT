import 'dart:collection';

import 'package:a_and_i_report_web_server/src/core/theme/code_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:re_highlight/languages/dart.dart';
import 'package:re_highlight/languages/kotlin.dart';
import 'package:re_highlight/languages/python.dart';
import 'package:re_highlight/re_highlight.dart';
import 'package:re_highlight/styles/atom-one-dark.dart';
import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:url_launcher/url_launcher.dart';

String normalizeMarkdownForPreview(String source) {
  if (!source.contains('>\n')) {
    return source;
  }

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
    code: vscodeCodeTextStyle(const TextStyle(
      fontSize: 14,
      height: 1.45,
      color: Color(0xFF111827),
      backgroundColor: Color(0xFFEFF1F5),
      fontWeight: FontWeight.w600,
    )),
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
  static const int _cacheLimit = 120;

  ArticleMarkdownCodeSyntaxHighlighter() {
    highlighter.registerLanguage('dart', langDart);
    highlighter.registerLanguage('kotlin', langKotlin);
    highlighter.registerLanguage('python', langPython);
  }

  final Highlight highlighter = Highlight();
  final LinkedHashMap<String, TextSpan> _spanCache = LinkedHashMap();

  @override
  TextSpan format(String source) {
    final code = source.replaceAll(RegExp(r'\n$'), '');
    if (code.isEmpty) {
      return const TextSpan(text: '');
    }

    final baseStyle = vscodeCodeTextStyle(const TextStyle(
      fontSize: 13,
      height: 1.6,
      color: Color(0xFFE5E7EB),
    ));

    if (code.length > 4000) {
      return TextSpan(text: code, style: baseStyle);
    }

    final cachedSpan = _spanCache[code];
    if (cachedSpan != null) {
      return cachedSpan;
    }

    try {
      final result = highlighter.highlightAuto(
        code,
        ['dart', 'kotlin', 'python'],
      );
      final renderer = TextSpanRenderer(baseStyle, atomOneDarkTheme);
      result.render(renderer);
      final span = renderer.span ?? TextSpan(text: '', style: baseStyle);
      _rememberSpan(code, span);
      return span;
    } catch (_) {
      final span = TextSpan(text: code, style: baseStyle);
      _rememberSpan(code, span);
      return span;
    }
  }

  void _rememberSpan(String code, TextSpan span) {
    _spanCache[code] = span;
    if (_spanCache.length <= _cacheLimit) {
      return;
    }
    _spanCache.remove(_spanCache.keys.first);
  }
}

Future<void> launchArticleMarkdownLink(
  BuildContext context,
  String? href,
) async {
  final uri = _resolveArticleMarkdownUri(href);
  if (uri == null) {
    return;
  }

  final launched = await launchUrl(
    uri,
    mode: LaunchMode.platformDefault,
    webOnlyWindowName: '_blank',
  );
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('링크를 열 수 없습니다.')),
    );
  }
}

Uri? _resolveArticleMarkdownUri(String? href) {
  final raw = href?.trim();
  if (raw == null || raw.isEmpty) {
    return null;
  }

  if (raw.startsWith('//')) {
    return Uri.tryParse('https:$raw');
  }

  final parsed = Uri.tryParse(raw);
  if (parsed != null && parsed.hasScheme) {
    return parsed;
  }

  if (raw.startsWith('/')) {
    return Uri.base.resolve(raw);
  }

  return Uri.tryParse('https://$raw');
}
