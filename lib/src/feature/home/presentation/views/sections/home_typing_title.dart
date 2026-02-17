import 'dart:async';

import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';

class HomeTypingTitle extends StatefulWidget {
  const HomeTypingTitle({
    required this.fontSize,
    this.onCompleted,
    super.key,
  });

  final double fontSize;
  final VoidCallback? onCompleted;

  @override
  State<HomeTypingTitle> createState() => _HomeTypingTitleState();
}

class _HomeTypingTitleState extends State<HomeTypingTitle> {
  static const String _fullText = '함께 만들고\n함께 성장하는\n개발 동아리';
  static const Duration _typingStep = Duration(milliseconds: 90);

  int _visibleCount = 0;
  bool _didNotifyCompleted = false;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _startTypingOnce();
  }

  void _startTypingOnce() {
    _typingTimer = Timer.periodic(_typingStep, (timer) {
      if (!mounted) return;
      if (_visibleCount >= _fullText.length) {
        timer.cancel();
        if (!_didNotifyCompleted) {
          _didNotifyCompleted = true;
          widget.onCompleted?.call();
        }
        return;
      }
      setState(() => _visibleCount++);
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typedText = _fullText.substring(0, _visibleCount);
    final titleStyle = TextStyle(
      fontSize: widget.fontSize,
      fontWeight: FontWeight.w800,
      height: 1.08,
      letterSpacing: -1.2,
      color: HomeTheme.textMain,
    );
    final reservedHeight = widget.fontSize * 1.08 * 3.1;

    return SizedBox(
      width: double.infinity,
      height: reservedHeight,
      child: Align(
        alignment: Alignment.topLeft,
        child: RichText(
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: TextSpan(
            style: titleStyle,
            children: [
              TextSpan(text: typedText),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Transform.translate(
                  offset: Offset(0, widget.fontSize * 0.08),
                  child: Container(
                    margin: EdgeInsets.only(left: widget.fontSize * 0.05),
                    width: widget.fontSize * 0.2,
                    height: widget.fontSize,
                    color: HomeTheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
