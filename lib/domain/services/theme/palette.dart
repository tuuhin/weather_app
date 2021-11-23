import 'package:flutter/material.dart';

class Palette {
  static final ThemeData _light = ThemeData(
    colorScheme: const ColorScheme.light(),
    primarySwatch: Colors.blue,
  );
  static final ThemeData _dark =
      ThemeData(colorScheme: const ColorScheme.dark());

  static ThemeData get light => _light;
  static ThemeData get dark => _dark;
}
