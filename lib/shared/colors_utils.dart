import 'package:flutter/material.dart';

/// Колір категорій транзакцій - розраховується коліром в залежності від назви категорії
Color getCategoryColor(String category) {
  return category == 'Без категорії'
      ? Colors.grey
      : stringToColor(category, Colors.grey);
}

Color stringToColor(String name, Color defaultColor) {
  if (name.isEmpty) {
    return defaultColor;
  }

  final hash = name.hashCode;
  final r = (hash & 0xFF0000) >> 16;
  final g = (hash & 0x00FF00) >> 8;
  final b = hash & 0x0000FF;

  return Color.fromRGBO(r, g, b, 1);
}
