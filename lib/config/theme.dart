import 'package:flutter/material.dart';

ColorScheme darkScheme() {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFF3A75E),
    // основной акцентный цвет (оставлен)
    surfaceTint: Color(0xFFF3A75E),
    onPrimary: Color(0xFF000000),
    // тёмный текст на акцентном фоне
    primaryContainer: Color(0xFF2A2A2A),
    onPrimaryContainer: Color(0xFFF3A75E),

    secondary: Color(0xFF444444),
    // тёмно-серый
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF2F2F2F),
    onSecondaryContainer: Color(0xFFE0E0E0),

    tertiary: Color(0xFF555555),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFF3A3A3A),
    onTertiaryContainer: Color(0xFFE0E0E0),

    error: Color(0xFFB00020),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFF370000),
    onErrorContainer: Color(0xFFFFDAD6),

    surface: Color(0xFF121212),
    onSurface: Color(0xFFE0E0E0),
    onSurfaceVariant: Color(0xFFB0B0B0),

    outline: Color(0xFF8A8A8A),
    outlineVariant: Color(0xFF4D4D4D),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    inverseSurface: Color(0xFFE0E0E0),
    inversePrimary: Color(0xFFF3A75E),
    // акцент остаётся при инверсии

    primaryFixed: Color(0xFFF3A75E),
    onPrimaryFixed: Color(0xFF000000),
    primaryFixedDim: Color(0xFFE59644),
    onPrimaryFixedVariant: Color(0xFF2A2A2A),

    secondaryFixed: Color(0xFF2F2F2F),
    onSecondaryFixed: Color(0xFFFFFFFF),
    secondaryFixedDim: Color(0xFF444444),
    onSecondaryFixedVariant: Color(0xFFD0D0D0),

    tertiaryFixed: Color(0xFF3A3A3A),
    onTertiaryFixed: Color(0xFFFFFFFF),
    tertiaryFixedDim: Color(0xFF555555),
    onTertiaryFixedVariant: Color(0xFFD0D0D0),

    surfaceDim: Color(0xFF121212),
    surfaceBright: Color(0xFF2C2C2C),
    surfaceContainerLowest: Color(0xFF0D0D0D),
    surfaceContainerLow: Color(0xFF1A1A1A),
    surfaceContainer: Color(0xFF1E1E1E),
    surfaceContainerHigh: Color(0xFF262626),
    surfaceContainerHighest: Color(0xFF2F2F2F),
  );
}

ThemeData appTheme() {
  final ColorScheme colorScheme = darkScheme();
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );
}
