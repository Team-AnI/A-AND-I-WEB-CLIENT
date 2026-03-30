import 'package:flutter/material.dart';

class ArticleEditorMarkdownActions {
  static void applyBold(
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    applyInlineWrap(controller, focusNode, '**', '**', 'bold text');
  }

  static void applyItalic(
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    applyInlineWrap(controller, focusNode, '*', '*', 'italic text');
  }

  static void applyStrikethrough(
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    applyInlineWrap(controller, focusNode, '~~', '~~', '취소선');
  }

  static void applyQuote(
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    final selection = safeSelection(controller);
    final text = controller.text;
    if (selection.isCollapsed) {
      replaceSelection(
        controller,
        selection,
        '> ',
        selectionOffset: 2,
      );
      focusNode.requestFocus();
      return;
    }

    final selectedText = text.substring(selection.start, selection.end);
    final quoted = selectedText
        .split('\n')
        .map((line) => line.isEmpty ? '>' : '> $line')
        .join('\n');
    replaceSelection(
      controller,
      selection,
      quoted,
      selectionOffset: quoted.length,
    );
    focusNode.requestFocus();
  }

  static void applyCodeBlock(
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    final selection = safeSelection(controller);
    final text = controller.text;
    final selectedText = selection.isCollapsed
        ? '코드를 입력하세요'
        : text.substring(selection.start, selection.end);
    final replacement = '```\n$selectedText\n```';
    final cursorOffset =
        selection.isCollapsed ? '```\n'.length : replacement.length;

    replaceSelection(
      controller,
      selection,
      replacement,
      selectionOffset: cursorOffset,
    );
    focusNode.requestFocus();
  }

  static void applyImage(
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    final selection = safeSelection(controller);
    replaceSelection(
      controller,
      selection,
      '![이미지 설명](https://)',
      selectionOffset: '![이미지 설명]('.length,
    );
    focusNode.requestFocus();
  }

  static void applyUploadedImage(
    TextEditingController controller,
    FocusNode focusNode, {
    required String imageUrl,
    String altText = '이미지',
  }) {
    final selection = safeSelection(controller);
    final replacement = '![$altText]($imageUrl)';
    replaceSelection(
      controller,
      selection,
      replacement,
      selectionOffset: replacement.length,
    );
    focusNode.requestFocus();
  }

  static void applyLink(
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    final selection = safeSelection(controller);
    final text = controller.text;
    final selectedText = selection.isCollapsed
        ? '링크 텍스트'
        : text.substring(selection.start, selection.end);
    final replacement = '[$selectedText](https://)';
    replaceSelection(
      controller,
      selection,
      replacement,
      selectionOffset: replacement.length - 1,
    );
    focusNode.requestFocus();
  }

  static void applyInlineWrap(
    TextEditingController controller,
    FocusNode focusNode,
    String prefix,
    String suffix,
    String placeholder,
  ) {
    final selection = safeSelection(controller);
    final text = controller.text;
    if (selection.isCollapsed) {
      final replacement = '$prefix$placeholder$suffix';
      replaceSelection(
        controller,
        selection,
        replacement,
        selectionBaseOffset: selection.start + prefix.length,
        selectionExtentOffset:
            selection.start + prefix.length + placeholder.length,
      );
      focusNode.requestFocus();
      return;
    }

    final selectedText = text.substring(selection.start, selection.end);
    final replacement = '$prefix$selectedText$suffix';
    replaceSelection(
      controller,
      selection,
      replacement,
      selectionBaseOffset: selection.start + prefix.length,
      selectionExtentOffset:
          selection.start + prefix.length + selectedText.length,
    );
    focusNode.requestFocus();
  }

  static TextSelection safeSelection(TextEditingController controller) {
    final selection = controller.selection;
    if (selection.start < 0 || selection.end < 0) {
      final offset = controller.text.length;
      return TextSelection.collapsed(offset: offset);
    }
    final start =
        selection.start <= selection.end ? selection.start : selection.end;
    final end =
        selection.end >= selection.start ? selection.end : selection.start;
    return TextSelection(baseOffset: start, extentOffset: end);
  }

  static void replaceSelection(
    TextEditingController controller,
    TextSelection selection,
    String replacement, {
    int? selectionOffset,
    int? selectionBaseOffset,
    int? selectionExtentOffset,
  }) {
    final text = controller.text;
    final newText =
        text.replaceRange(selection.start, selection.end, replacement);
    final base = selectionBaseOffset ??
        (selection.start + (selectionOffset ?? replacement.length));
    final extent = selectionExtentOffset ?? base;
    controller.value = controller.value.copyWith(
      text: newText,
      selection: TextSelection(
        baseOffset: base,
        extentOffset: extent,
      ),
      composing: TextRange.empty,
    );
  }
}
