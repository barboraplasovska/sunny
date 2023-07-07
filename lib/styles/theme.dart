import 'package:flutter/material.dart';

final ThemeData sunnyTheme = _sunnyTheme();

ThemeData _sunnyTheme() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: const Color(0xff5ad2f4),
      onPrimary: const Color(0xFFF5F5F5),
      secondary: const Color(0xFF323233),
      onSecondary: const Color(0xFFF5F5F5),
      tertiary: const Color(0xff5ad2f4),
      onTertiary: const Color(0xFF1E1E1E),
      background: const Color(0xFF1E1E1E),
      onBackground: const Color(0xFFF5F5F5),
      primaryContainer: const Color(0xFF252526),
      onPrimaryContainer: const Color(0xFFF5F5F5),
    ),
  );
}
