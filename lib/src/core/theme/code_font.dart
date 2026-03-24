import 'package:flutter/material.dart';

const String kVsCodeCodeFontFamily = 'Consolas';
const List<String> kVsCodeCodeFontFamilyFallback = <String>[
  'Menlo',
  'Monaco',
  'Courier New',
  'Liberation Mono',
  'DejaVu Sans Mono',
  'monospace',
];

TextStyle vscodeCodeTextStyle(TextStyle style) {
  return style.copyWith(
    fontFamily: kVsCodeCodeFontFamily,
    fontFamilyFallback: kVsCodeCodeFontFamilyFallback,
  );
}
