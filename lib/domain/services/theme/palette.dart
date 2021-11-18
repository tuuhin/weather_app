import 'package:flutter/material.dart';

class Palette {
  static final ThemeData _light = ThemeData(
      colorScheme: const ColorScheme.light(),
      scaffoldBackgroundColor: Colors.orange[50]);
  static final ThemeData _dark =
      ThemeData(colorScheme: const ColorScheme.dark());

  static ThemeData get light => _light;
  static ThemeData get dark => _dark;
}
