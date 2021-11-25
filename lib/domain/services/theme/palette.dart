import 'package:flutter/material.dart';

class Palette {
  static final ThemeData _light = ThemeData(
    scaffoldBackgroundColor: Colors.yellowAccent[50],
    primarySwatch: Colors.blue,
  );
  static final ThemeData _dark =
      ThemeData(colorScheme: const ColorScheme.dark());

  static ThemeData get light => _light;
  static ThemeData get dark => _dark;
}
